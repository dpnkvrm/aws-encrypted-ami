provider "aws" {
  version = "~> 2.7"
  region   = "${var.region}"
}

variable "region" {
  type  = "string"
  default = false
}

locals {
  timestamp = "${timestamp()}"
  timestamp_only_date = "${substr("${local.timestamp}", "0" , "10")}"
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.????????.?-x86_64-gp2"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_instance" "amazon2" {
    ami         = "${data.aws_ami.amazon_linux_2.id}"
    instance_type   = "t2.micro"
    root_block_device {
        encrypted = true
    }
}


resource "aws_ami_from_instance" "encrypted_ami" {
  name               = "Rax-Encrypted-Amazon2-Vanilla-${local.timestamp_only_date}"
  source_instance_id = "${aws_instance.amazon2.id}"
  description        = "Encrypted ami of ${data.aws_ami.amazon_linux_2.id} created at ${local.timestamp_only_date}"
  tags  {
    CreatedAt        = "${local.timestamp_only_date}"
    OriginalAmiId    = "${data.aws_ami.amazon_linux_2.id}"
    OriginalAmiName  = "${data.aws_ami.amazon_linux_2.name}"
  }
}


output "encrypted_amiid" {
  value = "${aws_ami_from_instance.encrypted_ami.id}"
}

output "amazon2_instance_id" {
  value = "${aws_instance.amazon2.id}"
}