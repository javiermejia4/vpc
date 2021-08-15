locals {
  #Nothing to see here

}

resource "aws_iam_instance_profile" "bastion_profile" {
  name = "bastion_profile"
  role = aws_iam_role.bastion_role.name
}

resource "aws_iam_role" "bastion_role" {
  name = "bastion_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  tags = merge(
    {
      Role = "Bastion"
    },
    local.common_tags
  )
}

resource "aws_iam_policy" "bastion_policy" {
  name        = "bastion_policy"
  path        = "/"
  description = "Bastion Policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
          "s3:*",
          "ssm:*",
          "secretsmanager:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "bastion-policy-attach" {
  name       = "bastion-policy-attachment"
  roles      = [aws_iam_role.bastion_role.name]
  policy_arn = aws_iam_policy.bastion_policy.arn
}


module "ec2-instance" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "2.19.0"
  name                   = "bastion_host"
  count                  = var.instance_count
  ami                    = var.linux_ami
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  subnet_id              = aws_subnet.public-subnet-1.id
  vpc_security_group_ids = [aws_security_group.allowed_traffic.id]
  iam_instance_profile   = aws_iam_instance_profile.bastion_profile.name

  
  root_block_device = [
    {
      delete_on_termination = true
      encrypted             = false
      volume_size           = 20
      volume_type           = "gp3"
    },
  ]

  tags = merge(
    {
      Name = "blackMamba-bastion-0${count.index}"
      Role = "Bastion"
    },
    local.common_tags
  )
}
