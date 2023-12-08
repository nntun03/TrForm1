variable "region" {
  default = "us-east-1"
}

variable "os-name" {
  default = "ami-0fc5d935ebf8bc3bc"
}

variable "instance-type" {
  default = "t2.micro"
}

variable "key-name" {
  default = "pubKP1"
}

variable "vpc-cidr" {
  default = "10.10.0.0/16"
}

variable "subnet1-cidr" {
  default = "10.10.1.0/24"
}

variable "subnet-az" {
  default = "us-east-1b"
}

