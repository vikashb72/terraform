# Teraform + Digital Ocean

## First Step

export DO_PAT="the_personal_access_token"
export EVT="Environment i.e dev|prd|uat"

### Ensure that ssh-agent is running and your ssh key is listed
ssh-add -l

## Init
terraform init

## Plan
terraform plan \
  -var "do_token=${DO_PAT}" \
  -var "group_name=${EVT}"

## Apply
terraform apply \
  -var "do_token=${DO_PAT}" \
  -var "group_name=${EVT}"
