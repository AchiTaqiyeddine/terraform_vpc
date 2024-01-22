init:
	terraform init

all: validate plan apply
import: 
	default_vpc_id= aws ec2 describe-vpcs --profile shared --region eu-central-1 --filters "Name=isDefault,Values=true" --query "Vpcs[0].VpcId" --output text
	echo ${default_vpc_id}
	#terraform import aws_internet_gateway.gw $default_vpc_id

#plan:
#    terraform validate
#    terraform plan --auto-approve
#
#apply:
#    terraform apply --auto-approve
#
#destroy:
#    terraform destroy -var-file="variables.tfvars"