# This is how we write Output when we use 'Count' as meta argument:-
/*
output "ec2_public_ip" {
  value = aws_instance.my_instance[*].public_ip
}

output "ec2_public_dns" {
  value = aws_instance.my_instance[*].public_dns
}

output "ec2_private_ip" {
  value = aws_instance.my_instance[*].private_ip
}
*/
/* Note:-
    We are creating multiple instances using "count" so we have to use "[*]" while providing the output.
    [*] just means that there are multiple resources of this type. So give me the output accordingly.
*/



# And This is how we write Output when we use 'for_each' as meta argument:-
output "ec2_public_ip" {
  value = [
    for key in aws_instance.my_instance : key.public_ip
  ]
}

output "ec2_public_dns" {
  value = [
    for key in aws_instance.my_instance : key.public_dns
  ]
}

output "ec2_private_ip" {
  value = [
    for key in aws_instance.my_instance : key.private_ip
  ]
}