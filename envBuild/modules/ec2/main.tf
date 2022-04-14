resource "aws_instance" "instance" {
  ami = var.myami
  private_ip = var.private_ip
  instance_type = "${var.app["app_instance_type]}"
  vpc_security_group_ids = var.sg_ids
  availability_zone = "${var.aws_region}${var.availability_zone}"
  disable_api_termination = var.enable_api_termination
  iam_instance_profile = "${var.app["profilename]}"
  subnet_id = var.subnet 
  tags = var.tags
}