variable "project" {}

variable "cidr_block_vpc"{}

variable "public_azs" {
  type = list(string)
}

variable "public_cidr_blocks" {
  type = list(string)
}

variable "private_azs" {
  type = list(string)
}

variable "private_cidr_blocks" {
  type = list(string)
}

variable "environment_tag" {}