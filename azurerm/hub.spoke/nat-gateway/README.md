# Teraform + Azure NAT GW 

## First Steps

az login

AZ_TENANT_ID=$(az account show | jq -r '.tenantId')
EVT="envname"
# dev|uat ...etc

# Init
terraform init

## Plan
terraform plan \
  -var "az_tenant_id=${AZ_TENANT_ID}" \
  -var-file=tfvars/${EVT}.tfvars

## Apply
terraform apply \
  -var "az_tenant_id=${AZ_TENANT_ID}" \
  -var-file=tfvars/${EVT}.tfvars
