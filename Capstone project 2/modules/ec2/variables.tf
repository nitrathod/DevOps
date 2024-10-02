variable "ami_id" {
  description = "AMI ID to use for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "t2.medium"
}

variable "key_name" {
  description = "SSH Key name for access"
  type        = string
  default     = ""
}

variable "subnet_id" {
  description = "The subnet ID where the EC2 instance will be deployed"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the instance"
  type        = list(string)
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
}

variable "additional_tags" {
  description = "Additional tags to apply to the EC2 instance"
  type        = map(string)
  default     = {}
}

variable "user_data" {
  description = "User data script to initialize the instance"
  type        = string
  default     = ""
}

variable "root_volume_size" {
  description = "Root EBS volume size in GB"
  type        = number
  default     = 20
}

variable "root_volume_type" {
  description = "Type of root EBS volume (gp2, io1, etc.)"
  type        = string
  default     = "gp2"
}

variable "disable_api_termination" {
  description = "Enable/disable termination protection"
  type        = bool
  default     = false
}