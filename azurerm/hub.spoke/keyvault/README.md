# Teraform + Azure Azure key vault

## First Steps

az login

AZ_TENANT_ID=$(az account show | jq -r '.tenantId')
KV_OWNER_ID=$(az ad signed-in-user show --query id -o tsv)
EVT="envname"
# dev|uat ...etc

# Init
terraform init

## Plan
terraform plan \
  -var "az_tenant_id=${AZ_TENANT_ID}" \
  -var "kv_owner_object_id=${KV_OWNER_ID}" \
  -var-file=tfvars/${EVT}.tfvars

## Apply
terraform apply \
  -var "az_tenant_id=${AZ_TENANT_ID}" \
  -var "kv_owner_object_id=${KV_OWNER_ID}" \
  -var-file=tfvars/${EVT}.tfvars
