ZONE_ID="Z02663713JHB580GK666M"
DOMAIN="Z02663713JHB580GK666M"

create_all() { 
  PUBLIC_IP=$(aws ec2 run-instances \
    --image-id ami-0b5a2b5b8f2be4ec2 \
    --instance-type t2.micro \
    --security-group-ids sg-036e9bfb37a180657 \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]" "ResourceType=volume,Tags=[{Key=Name,Value=${COMPONENT}}]" \
    --instance-market-options "MarketType=spot,SpotOptions={SpotInstanceType=persistent,InstanceInterruptionBehavior=stop}"
    | jq '.Instances[].PublicIpAddress' | sed -e 's/"//g')
  
  set-hostname ${COMPONENT}
  sed -e "s/IPADDRESS/${PRIVATE_IP}/" -e "s/COMPONENT/${COMPONENT}/" -e "s/DOMAIN/${DOMAIN}/" route53.json > /tmp/record.json
  aws route53 change-resource-record-sets --hosted-zone-id ${ZONE_ID} --change-batch file:///tmp/record.json 2>/dev/null

  


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
  COMPONENT=${component}
  create_all
done