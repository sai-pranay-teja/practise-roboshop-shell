create_all() {
  echo -e "\nset-hostname ${COMPONENT}" >>/tmp/user-data
  PUBLIC_IP=$(aws ec2 run-instances \
    --image-id ami-0b5a2b5b8f2be4ec2 \
    --instance-type t2.micro \
    --security-group-ids sg-036e9bfb37a180657 \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${component}}]" "ResourceType=volume,Tags=[{Key=Name,Value=${component}}]" \
    --instance-market-options "MarketType=spot,SpotOptions={SpotInstanceType=persistent,InstanceInterruptionBehavior=stop}"
    | jq '.Instances[].PublicIpAddress' | sed -e 's/"//g')

# aws ec2 run-instances \
#     --image-id ami-0b5a2b5b8f2be4ec2 \
#     --instance-type t2.micro \
#     --security-group-ids sg-036e9bfb37a180657 \
#     --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${component}}]" "ResourceType=volume,Tags=[{Key=Name,Value=${component}}]" \
#     --instance-market-options "MarketType=spot,SpotOptions={SpotInstanceType=persistent,InstanceInterruptionBehavior=stop}"

}


# for component in frontend cart catalogue mongodb mysql payment rabbitmq redis shipping user; do
#   component=${component}
#   create_all
# done

for component in frontend; do
  component=${component}
  create_all
done