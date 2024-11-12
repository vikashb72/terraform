# Teraform + Azure NAT GW 

## Introduction

Contans the terraform code to establish the base platform for env components
* Resource Group
* VNet
* Subnet(s)
* Azure KeyVault Name for Storage Account access key

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
