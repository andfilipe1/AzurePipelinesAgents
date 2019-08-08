#! /bin/bash

export vaultName="AzDOLive-keyvault"
export keyPrefix="terraform-azdolive"
export TF_VAR_RUN_DATE=$(date +%F)

export ARM_CLIENT_ID=$(az keyvault secret show --vault-name "$vaultName" --name "$keyPrefix-clientid"  --query value -o tsv)
export ARM_CLIENT_SECRET=$(az keyvault secret show --vault-name "$vaultName" --name "$keyPrefix-clientsecret"  --query value -o tsv)
export ARM_SUBSCRIPTION_ID=$(az keyvault secret show --vault-name "$vaultName" --name "$keyPrefix-subscriptionid"  --query value -o tsv)
export ARM_TENANT_ID=$(az keyvault secret show --vault-name "$vaultName" --name "$keyPrefix-tenantid"  --query value -o tsv)
export ARM_ACCESS_KEY=$(az keyvault secret show --vault-name "$vaultName" --name "$keyPrefix-accesskey"  --query value -o tsv)

# ./secret is a bash script, but does not get execution rights when recieved by the build agent.
chmod 755 ./secret


make init

echo "Execute Terraform plan"
make plan

echo "Execute Terraform apply"
make apply
