terraform {
    backend "s3" {
        bucket = "appbucket"
        key = "terraform/dev/appserver1/terraform.tfstate"
        region = "us-east-2"
        profile = "default"
    }
}

variable "subnetid" { default = "subnet-xxxx" }
variable "privateip" { default = "10.0.0.1"}
variable "aws_region" { default = "us-east-2" }
variable "bucket" { default = "appbucket" }
variable "aws_profile" { default = "default" }

data "aws_ami" "myami" {
    most_recent = true 
    filter {
        name = "name"
        values = ["custom_ami_name"]
    }
    owners = ["owners account number"]

}

variable "environment" { default = "dev" }
variable "availability_zone" { default = "a" }
variable "enable_api_termination" { default = "true" }
variable  "kms_key_id" { default = "arn of kms key" }

variable "app" {
    default = {
        app_instance_type = "t2.micro"
        profilename = "appserver or instance name (optional)"
    }
}

variable "sg_ids" {
    type = list
}

variable "tags" {
    default = {
        Name = "appserver1"
        environment = "development"
        os = "linux"
        application = "alvaria"
        function = "application server"
    }
}

variable "additional_tags" {
    default = {
        owerner = "platform engineering"
    }
}