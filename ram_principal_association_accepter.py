"""Helper script to accept invite for cross-account RAM Share."""
from __future__ import print_function

import argparse
import collections
import logging
import os
import sys
import time

import botocore.credentials
import botocore.session

DEFAULT_LOG_LEVEL = logging.INFO
LOG_LEVELS = collections.defaultdict(
    lambda: DEFAULT_LOG_LEVEL,
    {
        "critical": logging.CRITICAL,
        "error": logging.ERROR,
        "warning": logging.WARNING,
        "info": logging.INFO,
        "debug": logging.DEBUG,
    },
)

# Clear out any other root log handler
root = logging.getLogger()
if root.handlers:
    for handler in root.handlers:
        root.removeHandler(handler)

logging.basicConfig(
    format="%(asctime)s.%(msecs)03dZ [%(name)s][%(levelname)-5s]: %(message)s",
    datefmt="%Y-%m-%dT%H:%M:%S",
    level=LOG_LEVELS[os.environ.get("LOG_LEVEL", "").lower()],
)
log = logging.getLogger("ram_principal_association_accepter")


class NoPendingInviteException(Exception):
    pass


class AssumeRoleProvider(object):
    METHOD = "assume-role"

    def __init__(self, fetcher):
        self._fetcher = fetcher

    def load(self):
        return botocore.credentials.DeferredRefreshableCredentials(
            self._fetcher.fetch_credentials, self.METHOD
        )


def filter_none_values(data):
    """Returns a new dictionary excluding items where value was None"""
    return {k: v for k, v in data.items() if v is not None}


def assume_role(
    session, role_arn, duration=3600, session_name=None, serial_number=None
):
    fetcher = botocore.credentials.AssumeRoleCredentialFetcher(
        session.create_client,
        session.get_credentials(),
        role_arn,
        extra_args=filter_none_values(
            {
                "DurationSeconds": duration,
                "RoleSessionName": session_name,
                "SerialNumber": serial_number,
            }
        ),
        cache=botocore.credentials.JSONFileCache(),
    )
    role_session = botocore.session.Session()
    role_session.register_component(
        "credential_provider",
        botocore.credentials.CredentialResolver([AssumeRoleProvider(fetcher)]),
    )
    return role_session


def get_pending_invite_arn(ram, resource_share_arn):
    invitations = ram.get_resource_share_invitations(
        resourceShareArns=[resource_share_arn]
    )

    for invite in invitations["resourceShareInvitations"]:
        invite_arn = invite["resourceShareInvitationArn"]
        if invite["status"] == "PENDING":
            return invite_arn


def get_invite_status(ram, invite_arn):
    invitations = ram.get_resource_share_invitations(
        resourceShareInvitationArns=[invite_arn]
    )["resourceShareInvitations"]
    return invitations[0]["status"]


def accept_pending_invite(ram, invite_arn, timeout=60):
    ram.accept_resource_share_invitation(resourceShareInvitationArn=invite_arn)

    # Pause 3 seconds to allow AWS some time to acknowledge the invite and
    # associate shared resources
    time.sleep(3)

    start = time.time()
    sleep = 1
    while (
        get_invite_status(ram, invite_arn) != "ACCEPTED"
        and time.time() < start + timeout
    ):
        log.info("Invite is still pending, checking again in %s second(s)", sleep)
        time.sleep(sleep)
        sleep *= 2


def main(resource_share_arn, profile=None, role_arn=None, region=None):
    region = region or None
    profile = profile or None
    role_arn = role_arn or None

    session = botocore.session.Session(profile=profile)
    if role_arn:
        session = assume_role(session, role_arn)

    ram = session.create_client("ram", region_name=region)

    invite_arn = get_pending_invite_arn(ram, resource_share_arn)

    if not invite_arn:
        raise NoPendingInviteException(
            "No pending invite found for resource share ARN: {}".format(
                resource_share_arn
            )
        )

    log.info("Found pending invite ARN: %s", invite_arn)
    accept_pending_invite(ram, invite_arn)
    log.info("Accepted invite for resource share ARN: %s", resource_share_arn)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--resource-share-arn", help="ARN of the Resource Share to accept"
    )
    parser.add_argument(
        "--profile", default=None, help="Profile to use when setting up the AWS session"
    )
    parser.add_argument(
        "--role-arn",
        default=None,
        help="ARN of a role to assume with permissions to RAM",
    )
    parser.add_argument(
        "--region", default=None, help="Region in which to look for the RAM invite"
    )

    args = parser.parse_args()
    sys.exit(main(**vars(args)))
