# output "master_instance_public_ip" {
#   value = aws_instance.master_instance[*].public_ip
# }
output "slave_instance_public_ip" {
  value = aws_instance.slave_instance[*].public_ip
}