# Teraform + Azure Event Hub

## First Steps

az login

AZ_TENANT_ID=$(az account show | jq -r '.tenantId')

# Init
terraform init

## Plan
terraform plan \
  -var "environment=test" \
  -var "az_tenant_id=${AZ_TENANT_ID}"

## Apply
terraform apply \
  -var "environment=test" \
  -var "az_tenant_id=${AZ_TENANT_ID}"
