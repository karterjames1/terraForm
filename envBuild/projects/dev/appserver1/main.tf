provider "aws" {
    profile = var.aws_profile 
    region = var.aws_region
}

terraform {
    required_version = ">= 0.13.0"

    required_providers {
        aws = "~> 3.36.0"
    }
}

module "ec2" {
    source = "../../../modules/appserver1/ec2"
    aws_region = "${var.aws_region}"
    environment = "${var.environment}"
    availability_zone = "${var.availability_zone}"
    tags = "${var.tags}"
    bucket = "${var.bucket}"
    application = "${var.application}"
    privateip = "${var.privateip}"
    subnet = "${var.subnetid}"
    sg_ids = "${var.sg_ids}"
    myami = "${data.aws_ami.myami.id}"
    enable_api_termination = "${var.enable_api_termination}"
    additional_tags = "${var.additional_tags}"
    kms_key_id = "${var.kms_key_id}"
}