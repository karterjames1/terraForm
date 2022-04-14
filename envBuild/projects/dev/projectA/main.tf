provider "aws" {
  region     = var.region
}

module "ec2module" {
  source = "../../modules/ec2"
}
