# Agent Instructions

Before starting any task in this repository:

1. Run `make agents/sync`. It writes the shared Plus3 IT instructions for this repository's tardigrade-ci version to `.agents/plus3it/AGENTS.md`.
2. Read `.agents/plus3it/AGENTS.md` and follow it together with this file. If the sync fails, tell the user, and don't guess the conventions.

These rules always apply, even without the shared instructions:

- Don't push, open pull requests, publish releases, or apply infrastructure changes unless the user asks. List those steps for a person in your final report.
- Don't edit files under `.agents/plus3it/`; they are generated and overwritten by the sync.

@.agents/plus3it/AGENTS.md

## Repository-specific

### Purpose

This Terraform module creates an AWS Resource Access Manager (RAM) resource share and associates resources and principals with it. The main input is `name`; `resources` (a list of objects with `name` and `resource_arn`) and `principals` (account IDs or Organizations ARNs) are optional lists, and `allow_external_principals` defaults to `false`. The outputs are `resource_share`, `resource_associations`, and `principal_associations`.

### Module-specific files

- `modules/resource_association/` — Creates one `aws_ram_resource_association`; the root module calls it once for each item in `resources`
- `modules/principal_association/` — Creates one `aws_ram_principal_association`; the root module calls it once for each item in `principals`, and `cross_account_principal_association` also calls it
- `modules/share_accepter/` — Creates an `aws_ram_resource_share_accepter`; the root module does not call it, and `cross_account_principal_association` calls it
- `modules/cross_account_principal_association/` — Associates the calling account with a share owned by the `aws.owner` provider and then accepts the share; the root module does not call it, and the `cross_account` test calls it directly
