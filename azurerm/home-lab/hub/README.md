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

ORGANISATION="wherever"
DEPARTMENT="home"
PROJECT="lab"
ENVIRONMENT="hub"
SUBSCRIPTION_ID=$(az account show | jq -r '.id')
CLIENT_ID=$(az ad sp list --display-name sp-terraform-cli \
    | jq -r '.[].servicePrincipalNames[0]')
CLIENT_SECRET=$(az keyvault secret show --vault-name kv-home-where-ever \
    --query value -o tsv --name Provisioning-Client-Secret)
TENANT_ID=$(az account show | jq -r '.tenantId')
TF_STORAGE_ACCOUNT_NAME="st${ENVIRONMENT}{$PROJECT}${DEPARTMENT}${ORGANISATION}01"
TF_STORAGE_ACCOUNT_RGRP="rg-${ENVIRONMENT}-${PROJECT}-${DEPARTMENT}-${ORGANISATION}"
#MANAGEMENT_KV="kv-${ENVIRONMENT}-${PROJECT}-${DEPARTMENT}-${ORGANISATION}"
#MANAGEMENT_RG="rg-${ENVIRONMENT}-${PROJECT}-${DEPARTMENT}-${ORGANISATION}"
CONTAINER_NAME="tfstate-${ENVIRONMENT}-${PROJECT}-${DEPARTMENT}-${ORGANISATION}"
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
  -var-file="../tfvars-shared/${ENVIRONMENT}.tfvars" \
  -var-file="tfvars/${ENVIRONMENT}.tfvars" \
  -var="tenant_id=${TENANT_ID}" \
  -var="subscription_id=${SUBSCRIPTION_ID}" \
  -var="storage_account=$TF_STORAGE_ACCOUNT_NAME" \
  -out ${ENVIRONMENT}.pipeline.tfplan

## Apply
terraform apply ${ENVIRONMENT}.pipeline.tfplan
#terraform apply \
#  -var "az_tenant_id=${AZ_TENANT_ID}" \
#  -var-file=tfvars/${ENVIRONMENT}.tfvars \
#  -var-file="../tfvars/${ENVIRONMENT}.tfvars" \
