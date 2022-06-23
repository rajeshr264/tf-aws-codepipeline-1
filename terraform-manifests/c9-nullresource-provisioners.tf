# Create a Null Resource and Provisioners
resource "null_resource" "name" {
  depends_on = [module.ec2_public]
  # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type     = "ssh"
    host     = aws_eip.bastion_eip.public_ip    
    user     = "ec2-user"
    password = ""
    private_key = file("private-key/rajeshr-us-east-1.pem")
  }  

## File Provisioner: Copies the rajeshr-us-east-1.pem file to /tmp/rajeshr-us-east-1.pem
  provisioner "file" {
    source      = "private-key/rajeshr-us-east-1.pem"
    destination = "/tmp/rajeshr-us-east-1.pem"
  }
## Remote Exec Provisioner: Using remote-exec provisioner fix the private key permissions on Bastion Host
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/rajeshr-us-east-1.pem"
    ]
  }
}


# Creation Time Provisioners - By default they are created during resource creations (terraform apply)
# Destory Time Provisioners - Will be executed during "terraform destroy" command (when = destroy)