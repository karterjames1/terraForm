data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu image here"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["account number of owner"] # numerical/canonical
}

data "template_file" "userdata" {
  template = file("${path.module}/templates/userdata.txt")

resource "aws_launch_configuration" "as_conf" {
  name                   = "var.lcname"
  image_id               = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = var.sg_ids
  user_data              = data.template_file.userdata.rendered


}

resource "aws_launch_configuration" "server" {
  name_prefix          = "var.servername"
  image_id             = data.aws_ami.ubuntu.id
  instance_type        = var.instance_type
  vpc_security_group_ids = var.sg_ids
  user_data            = data.template_file.userdata.rendered

  lifecycle {
    create_before_destroy = true
  }

  root_block_device {
    delete_on_termination = true
    volume_type           = "gp2"
    volume_size           = "10"
  }
}

resource "aws_autoscaling_group" "bar" {
  #load_balancers = [aws_elb.server_elb.name]
  launch_configuration  = aws_launch_configuration.server.id
  availability_zones = ["us-east-1a"]
  desired_capacity          = 1
  max_size                  = 1
  min_size                  = 1
  wait_for_elb_capacity     = 1
  desired_capacity          = 1
  #health_check_grace_period = 180
  #health_check_type = "ELB"
  name                      = var.asgname
  lifecycle {
    create_before_destroy = true
  }


#  launch_template {
#    id      = aws_launch_template.foobar.id
#    version = "$Latest"
#  }
}


resource "aws_autoscaling_policy" "scale_up" {
  name                   = "foobar3-terraform-test"
  scaling_adjustment     = 4
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.bar.name
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "foobar3-terraform-test"
  scaling_adjustment     = 4
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.bar.name
}


resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name                = "terraform-test-foobar5"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []

      dimensions = {
        AutoScalingGroupName = aws_autoscaling_group.bar.name
    }
}

}
resource "aws_cloudwatch_metric_alarm" "low_cpu" {
  alarm_name                = "terraform-test-foobar5"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []
      dimensions = {
        AutoScalingGroupName = aws_autoscaling_group.bar.name
    }
}

}