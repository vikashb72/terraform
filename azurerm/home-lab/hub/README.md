# Teraform + Azure Hub Environment

## Introduction

Contans the terraform code to establish the hub components
* Resource Group
* VNet
* Subnet(s)
* Storage Account
* Azure KeyVault Name for Storage Account access key

# Enviroments

## Variables
az login

COMPANY_NAME="wherever"
UNIT_NAME="home-lab"
EVT="hub"
SUBSCRIPTION_ID=$(az account show | jq -r '.id')
CLIENT_ID=$(az ad sp list --display-name sp-terraform-cli \
    | jq -r '.[].servicePrincipalNames[0]')
TENANT_ID=$(az account show | jq -r '.tenantId')
TF_STORAGE_ACCOUNT_NAME="sahomelabwherver01cd8q"
TF_STORAGE_ACCOUNT_RGRP="rg-hub-home-lab-wherever"
MANAGEMENT_KV="kv-hub-home-lab-wherever"
MANAGEMENT_RG="rg-hub-home-lab-wherever"
SERVICE_PRINCIPLE_PW="TBD"
CONTAINER_NAME="sc-tfstate-hub-za-hub-home-lab-wherever"
CONTAINER_KEY_NAME="hub.tfstate"

## Setup (if required)
az ad sp create-for-rbac \
  --name "sp-terraform-cli" \
  --role "Contributor" \
  --scopes="/subscriptions/${SUBSCRIPTION_ID}"

# Init
## First run
terraform init

## After storage is created
terraform init -backend-config=storage_account_name=$TF_STORAGE_ACCOUNT_NAME \
    -backend-config=container_name=$CONTAINER_NAME \
    -backend-config=key=$CONTAINER_KEY_NAME \
    -backend-config=resource_group_name=$TF_STORAGE_ACCOUNT_RGRP \
    -backend-config=subscription_id=$SUBSCRIPTION_ID \
    -backend-config=tenant_id=$TENANT_ID \
    -backend-config=client_id=$CLIENT_ID \
    -backend-config=client_secret=$CLIENT_SECRET \
    -reconfigure -upgrade

## Plan
terraform plan \
  -var-file="../tfvars/hub.tfvars" \
  -var-file="tfvars/hub.tfvars" \
  -var="tenant_id=${TENANT_ID}" \
  -var="subscription_id=${SUBSCRIPTION_ID}" \
  -var="storage_account=$TF_STORAGE_ACCOUNT_NAME" \
  -out hub.pipeline.tfplan

## Apply
terraform apply \
  -var "az_tenant_id=${AZ_TENANT_ID}" \
  -var-file=tfvars/hub.tfvars
