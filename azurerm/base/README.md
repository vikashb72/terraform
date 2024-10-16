# Teraform + Azure Base Environment Build 

## Introduction

Contans the terraform code to establish the base platform for env components
* Resource Group
* VNet
* Subnet(s)
* Azure KeyVault Name for Storage Account access key

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
