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
- Download these [files](amazon2) and execute the script file
### prerequisites:
- terraform
- aws cli
- faws cli 
- jq parser

-- Deepank Verma



