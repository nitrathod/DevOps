output "ec2_security_group_id" {
  description = "The security group ID for EC2 instances"
  value       = aws_security_group.ec2_sg.id  # Adjust this based on your actual resource name in the security group module
}