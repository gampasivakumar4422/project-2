provider "aws" { 
 region = "us-west-2" 
} 
resource "aws_key_pair" "test" { 
 key_name = "demo" 
 public_key = file("./demo.pub") 
} 
resource "aws_instance" "web" { 
 ami = "ami-03c983f9003cb9cd1" 
 instance_type = "t2.micro"  
 availability_zone = "us-west-2a"
 key_name = aws_key_pair.test.key_name 
 vpc_security_group_ids =["sg-0bc5cd5487adfa7bd"]
 tags = { 
 Name = "Demo_Instance-1" 
 } 
 connection {
 type = "ssh" 
 user = "ubuntu" 
 private_key = file("./demo")  
 host = self.public_ip 
 timeout = "1m" 
 agent = false 
 } 
 provisioner "remote-exec" { 
 inline = [ 
 "sudo apt-get update", 
 "sudo apt-get install maven -y",
 "sudo apt-get install tomcat9 tomcat9-admin -y",
 "mkdir siva && cd siva",
 "git clone https://github.com/gampasivakumar4422/Task-1.git",
 "cd Task-1 && mvn clean package",
 "cd target && sudo mv SivaKumar-1.0.war /var/lib/tomcat9/webapps/Siva.war"
 ] 
timeout = "10m"
 } 
} 
resource "aws_instance" "webserver" { 
 ami = "ami-03c983f9003cb9cd1" 
 instance_type = "t2.micro" 
 availability_zone = "us-west-2b" 
 key_name = aws_key_pair.test.key_name 
 vpc_security_group_ids =["sg-0bc5cd5487adfa7bd"]
 tags = { 
 Name = "Demo_Instance-2" 
 } 
 connection {
 type = "ssh" 
 user = "ubuntu" 
 private_key = file("./demo")  
 host = self.public_ip 
 timeout = "1m" 
 agent = false 
 } 
 provisioner "remote-exec" { 
 inline = [ 
 "sudo apt-get update", 
 "sudo apt-get install maven -y",
 "sudo apt-get install tomcat9 tomcat9-admin -y",
 "mkdir siva && cd siva",
 "git clone https://github.com/gampasivakumar4422/Task-2.git",
 "cd Task-2 && mvn clean package",
 "cd target && sudo mv SivaKumar-1.0.war /var/lib/tomcat9/webapps/Siva.war"
 ] 
 } 
} 
