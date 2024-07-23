![alt text](image.png)

ssh keys attached to instance. or dynamically create and add it inside ec2 key pair
https://www.youtube.com/watch?v=lJbf0J9rRzE


#vpc-ec2-direct-public-ip.tf ---> this is just create ec2 instance with public ip enabled. and connect.

#vpc-ec2-via-jumphost.tf ---> this is creating jump host server and private instance. but connect via cloud ui and ssh

#vpc-ec2-via-jumphost-keys.tf ----> this is ssh from terraform local ram machine to jumphost and there to private ec2.

source reference#https://www.youtube.com/watch?v=lJbf0J9rRzE
theory #https://www.youtube.com/watch?v=FZPTL_kNvXc&list=PLdpzxOOAlwvLNOxX0RfndiYSt1Le9azze&index=9


rkyasan44@jenkins-server:~/tf/Terraform/aws-projects/awsresources$ chmod 600 ramsagar-private_key.pem
rkyasan44@jenkins-server:~/tf/Terraform/aws-projects/awsresources$ ssh ec2-user@44.200.18.175 -i ramsagar-private_key.pem 
   ,     #_
   ~\_  ####_        Amazon Linux 2
  ~~  \_#####\
  ~~     \###|       AL2 End of Life is 2025-06-30.
  ~~       \#/ ___
   ~~       V~' '->
    ~~~         /    A newer version of Amazon Linux is available!
      ~~._.   _/
         _/ _/       Amazon Linux 2023, GA and supported until 2028-03-15.
       _/m/'           https://aws.amazon.com/linux/amazon-linux-2023/

36 package(s) needed for security, out of 54 available
Run "sudo yum update" to apply all updates.
[ec2-user@ip-10-0-1-102 ~]$ ls -ltr /tmp/

[ec2-user@ip-10-0-1-102 ~]$ ls -ltr /tmp/terraform_private_key.pub
-rw-r--r-- 1 ec2-user ec2-user 3243 Jul 23 19:48 /tmp/terraform_private_key.pub
[ec2-user@ip-10-0-1-102 ~]$ chmod 600 /tmp/terraform_private_key.pub
[ec2-user@ip-10-0-1-102 ~]$ ssh -i  /tmp/terraform_private_key.pub ec2-user@10.0.1.155
   ,     #_
   ~\_  ####_        Amazon Linux 2
  ~~  \_#####\
  ~~     \###|       AL2 End of Life is 2025-06-30.
  ~~       \#/ ___
   ~~       V~' '->
    ~~~         /    A newer version of Amazon Linux is available!
      ~~._.   _/
         _/ _/       Amazon Linux 2023, GA and supported until 2028-03-15.
       _/m/'           https://aws.amazon.com/linux/amazon-linux-2023/

[ec2-user@ip-10-0-1-155 ~]$ 

