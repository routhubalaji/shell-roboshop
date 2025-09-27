#!bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-03b634c5a017bced3"

for instance in $@
do 

    INSTANCE_ID=$(aws ec2 run-instances --image-id $AMI_ID --instance-type t3.micro --security-group-ids 
    $SG_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" --query 'Instances[0].InstanceId' 
    --output text)

    if [ $instance != "frontend" ]; then
        IP=$(aws ec2 describe-instances --instance-ids i-0482762808b42ce32 --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)
    else
        IP=$(aws ec2 describe-instances --instance-ids i-0a1b2c3d4e5f6g7h8 --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text)
    fi   
     
    echo "Instance $instance is created with ID $INSTANCE_ID and IP $IP"

done