variable "linux_ami" {
  default     = "ami-0cf1ef0f7d7421ea7"
  description = "Linux AMI used"
}

variable "intance_type" {
  default     = "t2.micro"
  description = "Instance type used"
}


variable "instance_count" {
  default     = "1"
  description = "Instance count"
}

variable "region" {
  default     = "us-west-2"
  description = "AWS Region"
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "VPC CIDR"
}

variable "public_subnet_1_cidr" {
  description = "Public Subnet 1 CIDR"
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "Public Subnet 2 CIDR"
  default     = "10.0.3.0/24"
}

variable "private_subnet_1_cidr" {
  description = "Private Subnet 1 CIDR"
  default     = "10.0.2.0/24"
}

variable "private_subnet_2_cidr" {
  description = "Private Subnet 2 CIDR"
  default     = "10.0.4.0/24"
}

variable "private_subnet_3_cidr" {
  description = "Private Subnet 3 CIDR"
  default     = "10.0.5.0/24"
}

variable "ingress_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [22]
}

variable "allowed_ips" {
  type        = list(string)
  default     = ["45.50.88.178/32"]
  description = "Allowed CIDR IPs"
}

variable "key_pair_name" {
  default = "BlackMambaKey"
}
