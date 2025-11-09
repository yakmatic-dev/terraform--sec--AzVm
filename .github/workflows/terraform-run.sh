#!/bin/bash
# Usage: ./terraform-run.sh plan
# or: ./terraform-run.sh apply

set -e  # Exit on error

# --- Check for Required Secrets ---
if [ -z "$ARM_SUBSCRIPTION_ID" ]; then
    echo "Error: ARM_SUBSCRIPTION_ID is not set"
    echo "Please set it: export ARM_SUBSCRIPTION_ID='your-subscription-id'"
    exit 1
fi

if [ -z "$BACKEND_STORAGE_ACCOUNT_NAME" ]; then
    echo "Error: BACKEND_STORAGE_ACCOUNT_NAME is not set"
    echo "Please set it: export BACKEND_STORAGE_ACCOUNT_NAME='your-storage-account'"
    exit 1
fi

# --- Terraform Variables ---
export TF_VAR_application="vm"
export TF_VAR_environment="dev"

# --- Backend Configuration ---
export BACKEND_RESOURCE_GROUP_NAME="rg-statefile-${TF_VAR_environment}"
export BACKEND_CONTAINER_NAME="sgcontainer-statefile-${TF_VAR_environment}"
export BACKEND_KEY="vm-${TF_VAR_environment}-key"

# --- Terraform Init ---
echo "Initializing Terraform..."
terraform init \
    -backend-config="resource_group_name=${BACKEND_RESOURCE_GROUP_NAME}" \
    -backend-config="storage_account_name=${BACKEND_STORAGE_ACCOUNT_NAME}" \
    -backend-config="container_name=${BACKEND_CONTAINER_NAME}" \
    -backend-config="key=${BACKEND_KEY}"

# --- Run Terraform Command Passed as Argument ---
echo "Running: terraform $@"
terraform "$@"

# --- Clean Terraform Cache (optional) ---
# Uncomment if you want to clean after each run
# rm -rf .terraform
