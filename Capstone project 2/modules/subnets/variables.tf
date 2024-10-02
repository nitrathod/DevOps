variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "vpc_name" {
  description = "VPC Name"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
}

variable "public_route_table_id" {
  description = "ID of the public route table"
  type        = string
}