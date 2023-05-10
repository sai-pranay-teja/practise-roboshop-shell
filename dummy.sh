aws ec2 run-instances \
    --image-id ami-0b5a2b5b8f2be4ec2 \
    --instance-type t2.micro \
    --security-group-ids sg-036e9bfb37a180657 \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=Random}]" "ResourceType=volume,Tags=[{Key=Name,Value=Random}]" \
    --instance-market-options "MarketType=spot,SpotOptions={SpotInstanceType=persistent,InstanceInterruptionBehavior=stop}" \
    | jq '.Instances[].PublicIpAddress' | sed -e 's/"//g'


PUBLIC_IP=$(aws ec2 describe-instances | jq '.Instances[].PublicIpAddress' | sed -e 's/"//g')

echo $PUBLIC_IP