# Runbook for Creating Ami with encrypted root volume in rackspce
## Problem Statement:
- Unable to use rackspace ec2_ar or ec2_asg module to create a instance with encrypted root volume.


## Process used currently (Manual Process): 

    - Create base instance
    - Create AMI of Base instance
    - Copy snapshot of this AMI as new Encrypted snapshot.
    - Create new encrypted AMI using encrypted snapshot
    - Create instances using this encrypted ami.

# Solutions: 
### 1. Terraform provided solution proposed to be used in rackspace modules: 
```
resource "aws_instance" "example" {
  ami = "ami-00000000000000000"
  ...
  root_block_device {
    [..]
    encrypted = true
  }
  ...
} 
```

# 2. Use following files to create ami and terminate the instance automatically:
### prerequisites:
- terraform
- aws cli
- faws cli 
- jq parser
### Steps:
1) Download these [files](amazon2) for amazon2-linux (latest)
2) Go to the downloaded folders and provide executable permissions
```
cd amazon2/
chmod a+x create-encrypted-ami.sh
```
3) Execute the create-encrypted-ami.sh
```
./create-encrypted-ami.sh
```
4) Provide rackspace account number, aws account number and region to be used:
```
./create-encrypted-ami.sh 
Rackspace Account Number:
981064
AWS Account Number:
805405598173
region:
eu-west-1
```
### Thats it!!! 
It will create a amazon2 instance with encrypted root volume, will create AMI with appropreate tags. 
Once the AMI is complete it will terminte the base image and will provide you the AMI ID to be used for your builds.


-- Deepank Verma



