provider "aws" {
  region = "us-east-1"
  
}

resource "aws_spot_instance_request" "name_2" {
    ami           = "ami-0bb6af715826253bf"
    instance_type = "t3a.small"
    spot_type     = "persistent"
    #iam_instance_profile = aws_iam_instance_profile.demo-profile.name
    instance_interruption_behavior = "stop"
    wait_for_fulfillment=true
    vpc_security_group_ids = ["sg-036e9bfb37a180657"]
    tags = {
      Name = "Instance-1"
    }

    timeouts {
    create = "10m"
    delete = "10m"
  }

  /* provisioner "remote-exec" {
    connection {
      host=aws_spot_instance_request.name_2.public_ip
      user="centos"
      password="DevOps321"
    
    }
    inline = [
      "sudo git clone https://github.com/sai-pranay-teja/practise-roboshop-shell",
      "sudo cd practise-roboshop-shell/",
      "sudo bash frontend.sh"
     ]
    
  } */

}

output "public_ip"{
    value=aws_spot_instance_request.name_2.public_ip
}
