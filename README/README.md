## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

<img src="Images/Screen Shot 2020-10-27 at 7.25.55 pm.png">

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the __playbook___ file may be used to install only certain pieces of it, such as Filebeat.

  Ansible/Filebeat/filebeat-playbook.yml (Ansible/Filebeat/filebeat-playbook.yml)
  Ansible/install-elk.yml (Ansible/install-elk.yml)

This document contains the following details:
- Description of the Topologu
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly _avalable_, in addition to restricting __access__ to the network.
- _TODO: What aspect of security do load balancers protect? What is the advantage of a jump box?_

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the __filesystem__ and system __usage__.
- __Filebeat watch's for new logfiles and file/log events.__
- __Metricbeat records the metric data of runnig services such as systems CPU and memory.__

The configuration details of each machine may be found below.

| Name     | Function | IP Address | Operating System |
|----------|----------|------------|------------------|
| Jump-Box-Provisioner | Gateway  | 10.0.0.4   |Linux ubuntu 18.04|
| Web-1    | Sever    | 10.0.0.5   |Linux ubuntu 18.04|
| Web-2    | Sever    | 10.0.0.6   |Linux ubuntu 18.04|
| Web-3    | Sever    | 10.0.0.7   |Linux ubuntu 18.04|

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the __Jump-Box-Provisioner__ machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:

- __58.0.0.0__

Machines within the network can only be accessed by __Jump-Box-Provisioner__.
- __Jump-Box-Provisioner__ __58.0.0.0__

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump-Box-Provisioner | no      | 58.0.0.0       |
|    Load-Balancer     | no      | 58.0.0.0       |
|     ELK-Sever        | no      | 58.0.0.0       |    

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- __It makes installing and setting up machines the same and can show troubleshooting issues before they are installed. It also automates the instalation processes, it removes mistakes that can be made manually__

The playbook implements the following tasks:

- The playbook starts off by installing docker.io and the doccker python module.
- It increase the virtual memory on the VM to be able to accomedate the ELK sever.
- It then configures docker to run when the VM has been restarted.
- Then it will install the ELK sever container, it makes sure it always starts after reset and aassigns ports to connet to the sever.

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

<img src="Images/Screen Shot 2020-10-31 at 9.05.21 am.png">

### Target Machines & Beats
This ELK server is configured to monitor the following machines:

| Name     | IP Addresses |
|----------|--------------|
| Web-1  |     10.0.0.5   |
| Web-2  |     10.0.0.6   |
| Web-3  |     10.0.0.7   |   

We have installed the following Beats on these machines:
- _Filebeat and Metricbeat_

These Beats allow us to collect the following information from each machine:
- _Filebeats collects log files andfile locations and collets log events. Metricbeat is used for monetoring the performance of runnig services. It analyze system CPU, memory and load._

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the __/etc/ansible/files/filebeat-config.yml__ file to __/etc/filebeat/filebeat.yml__.
- Update the __/etc/ansible/hosts__ file to include the name of the host severs Eg (Websevers or ELK sever) and inclued their IP adresses and the ansible python cmd to be able to run (ansible_python_interpreter=/usr/bin/python3)
- Run the playbook, and navigate to __52.189.233.231:5601__ to check that the installation worked as expected.

_**Bonus**_

- _Go to your command line and run the command: git clone https://github.com/your-username/yourlink.git_

- When you want you add or upload you will need to be in the top directory of your repo. and run __<git add .>__ the . will sync everything in you repo.

- Use __<git commit -m "describing commit">__ to confirm the commit and you can add a note describing what you have done in the " " marks ("describing commit").

- Then use  __git push__ to finalize the sync. then go to  github.com and confirm that it has worked. 
