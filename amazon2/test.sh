#!/bin/bash
echo "Rackspace Account Number:"
read rackaccount
echo "AWS Account Number:"
read awsaccount
echo "region:"
read region
eval "$(faws -r $rackaccount env -a $awsaccount)"
# eval "$(faws -r 981064 env -a 805405598173)"
# region="eu-central-1"
terraform plan -var "region=$region" --out tf.plan 
terraform apply tf.plan 
ami_id=`cat terraform.tfstate | jq .modules[].outputs.encrypted_amiid.value | tr -d '"'`
instance_id=`cat terraform.tfstate | jq .modules[].outputs.amazon2_instance_id.value | tr -d '"'`
echo "Terminating Instance"
aws ec2 terminate-instances --instance-ids $instance_id --region $region > /dev/null
echo "Encrypted AMI id is $ami_id"