data "aws_ami" "ubuntu_20" {

  most_recent = true

  owners = ["099720109477"]

  filter {
    name = "name"
    values = [
      "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
    ]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

resource "aws_instance" "mongodb" {

  ami = data.aws_ami.ubuntu_20.id

  instance_type = "t3.small"

  subnet_id = module.vpc.public_subnets[0]


  vpc_security_group_ids = [
    aws_security_group.mongodb.id
  ]

  iam_instance_profile = aws_iam_instance_profile.mongodb_profile.name

  associate_public_ip_address = true

  user_data = file("${path.module}/userdata/mongodb.sh")

  root_block_device {

    volume_size = 20

    volume_type = "gp3"

  }

  tags = {
    Name = "mongodb-server"
  }

}