#!/bin/bash

AMI_ID="ami-0a0b0b06dd1636865"   # replace with your AMI ID
INSTANCE_TYPE="t3.micro"
KEY_NAME="my-key"                # replace with your actual key pair name
SEC_GROUP_ID="sg-071a3da57d75b29a8"  # replace with your security group ID

echo "Launching EC2 instance..."
INSTANCE_ID=$(aws ec2 run-instances \
  --image-id "$AMI_ID" \
  --instance-type "$INSTANCE_TYPE" \
  --key-name "$KEY_NAME" \
  --security-group-ids "$SEC_GROUP_ID" \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=MyInstance}]' \
  --query "Instances[0].InstanceId" \
  --output text)

echo "Instance launched with ID: $INSTANCE_ID"

# Check if the instance was actually created
if [ -z "$INSTANCE_ID" ]; then
  echo "❌ Failed to launch EC2 instance. Aborting."
  exit 1
fi

# wait until running and fetch public IP
aws ec2 wait instance-running --instance-ids "$INSTANCE_ID"
PUBLIC_IP=$(aws ec2 describe-instances \
  --instance-ids "$INSTANCE_ID" \
  --query "Reservations[0].Instances[0].PublicIpAddress" \
  --output text)

echo "✅ EC2 is running at: $PUBLIC_IP"

