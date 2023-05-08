create_all() {
aws ec2 run-instances \
    --image-id ami-0b5a2b5b8f2be4ec2 \
    --instance-type t2.micro \
    --security-group-ids sg-036e9bfb37a180657 \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${component}}]' 'ResourceType=volume,Tags=[{Key=Name,Value=${component}}]" \
    --instance-market-options "MarketType=spot,SpotOptions={SpotInstanceType=persistent,InstanceInterruptionBehavior=stop}"

}


for component in frontend; do
  component=${component}
  create_all
done