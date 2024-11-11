# Teraform + Azure Event Hub

## First Steps

az login
EVT="envname"
# dev|uat ...etc

AZ_TENANT_ID=$(az account show | jq -r '.tenantId')

# Init
terraform init

## Plan
terraform plan \
  -var "az_tenant_id=${AZ_TENANT_ID}" \
  -var-file=tfvars/${EVT}.tfvars \
  -var-file=tfvars/${EVT}.topics.tfvars

## Apply
terraform apply \
  -var "az_tenant_id=${AZ_TENANT_ID}" \
  -var-file=tfvars/${EVT}.tfvars \
  -var-file=tfvars/${EVT}.topics.tfvars
