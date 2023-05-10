aws iam create-instance-profile --instance-profile-name Full_access
aws iam add-role-to-instance-profile \
    --instance-profile-name Full_access \
    --role-name Full-access


aws ec2 run-instances \
    --image-id ami-0b5a2b5b8f2be4ec2 \
    --instance-type t2.micro \
    --security-group-ids sg-036e9bfb37a180657 \
    --iam-instance-profile Name="Full_access" \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=Workstation}]" "ResourceType=volume,Tags=[{Key=Name,Value=Workstation}]" \
    --instance-market-options "MarketType=spot,SpotOptions={SpotInstanceType=persistent,InstanceInterruptionBehavior=stop}"


