terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.32.1"
    }
  }
}

provider "aws" {
  region  = "eu-central-1"
  profile = "shared"
}

resource "aws_default_vpc" "default" {
  force_destroy = true

}


resource "aws_default_subnet" "default_az1" {
  depends_on        = [aws_default_vpc.default]
  force_destroy     = true
  availability_zone = "eu-central-1a"
}

resource "aws_default_subnet" "default_az2" {
  depends_on        = [aws_default_vpc.default]
  availability_zone = "eu-central-1b"
  force_destroy     = true
}

resource "aws_default_subnet" "default_az4" {
  depends_on        = [aws_default_vpc.default]
  availability_zone = "eu-central-1c"
  force_destroy     = true
}

resource "aws_default_route_table" "default" {
  depends_on             = [aws_default_vpc.default]
  default_route_table_id = aws_default_vpc.default.default_route_table_id

  route = []
}

resource "aws_default_security_group" "default" {
  depends_on = [aws_default_vpc.default]
  vpc_id     = aws_default_vpc.default.id

}

resource "aws_default_network_acl" "default" {
  depends_on             = [aws_default_vpc.default]
  default_network_acl_id = aws_default_vpc.default.default_network_acl_id

}

resource "aws_default_vpc_dhcp_options" "default" {

}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_default_vpc.default.id
}