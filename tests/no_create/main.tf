provider aws {
  region = "us-east-1"
}

module "create_ram_accept" {
  source = "../../"
  providers = {
    aws       = aws
    aws.owner = aws
  }

  create_ram_principal_association = false
}
