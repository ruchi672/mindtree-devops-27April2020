# Instruction for CloudLab. 

Step1: Setup the root user password as per your choice
=> sudo su - 
=> passwd root
	-> Supply user password 


Step2: Check the SSH Config Setting for Password Auth
=>  grep -i "PermitRootLogin" /etc/ssh/sshd_config
=>  sed -i "s/PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/ssh d_config

=>  grep -i "PasswordAuthentication" /etc/ssh/sshd_config
=>  sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd _config

=>  service sshd restart

Step3: Check SSH Connectivity & Identify your private IP Address - eth0 / enp0s8
=>  ip addr 
=>  ssh root@ipaddress  or ssh root@10.0.0.4


Step4: Update your inventory with the following ip address, like below

=> cat inventory

[web]
10.0.0.4

[db]
10.0.0.4

[dc:children]
web
db

[dc:vars]
ansible_ssh_user="root"
ansible_ssh_pass="password of our choice"

Step5: Run the ansible ad-hoc commands 
=> ansible dc -i inventory -m ping -s -k

//
************** If the above command fail with sshpass or python error ***************
=> apt-get install sshpass python -y 
*************************************************************************************
//

 
=> ansible dc -i inventory -m ping



Step6: Run the ansible Playbook Excution
=> ansible-playbook -i inventory planbook.yaml


