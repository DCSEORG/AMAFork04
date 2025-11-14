#!/bin/bash

# =============================================================================
# Azure Expense Management System - Master Deployment Script
# =============================================================================
# This script deploys all Azure infrastructure and application code
# Prerequisites: 
#   - Azure CLI installed and logged in (az login)
#   - Subscription context set (az account set --subscription <id>)
# Usage: ./deploy.sh
# =============================================================================

set -e  # Exit on error

# Configuration Variables
RESOURCE_GROUP="ExpenseManagementRG"
LOCATION="uksouth"
APP_NAME="expense-mgmt-app-$RANDOM"
DEPLOYMENT_NAME="expense-mgmt-deployment-$(date +%Y%m%d-%H%M%S)"

echo "=========================================="
echo "Azure Expense Management System Deployment"
echo "=========================================="
echo "Resource Group: $RESOURCE_GROUP"
echo "Location: $LOCATION"
echo "App Name: $APP_NAME"
echo "=========================================="

# Create Resource Group
echo "Creating resource group..."
az group create \
  --name $RESOURCE_GROUP \
  --location $LOCATION \
  --output table

# Deploy App Service Infrastructure
echo "Deploying App Service infrastructure..."
az deployment group create \
  --resource-group $RESOURCE_GROUP \
  --name $DEPLOYMENT_NAME \
  --template-file ./infrastructure/app-service.bicep \
  --parameters appServiceName=$APP_NAME location=$LOCATION \
  --output table

# Deploy Application Code
echo "Deploying application code..."
az webapp deploy \
  --resource-group $RESOURCE_GROUP \
  --name $APP_NAME \
  --src-path ./app.zip \
  --type zip

# Get the App Service URL
APP_URL=$(az webapp show \
  --resource-group $RESOURCE_GROUP \
  --name $APP_NAME \
  --query defaultHostName \
  --output tsv)

echo "=========================================="
echo "Deployment completed successfully!"
echo "=========================================="
echo "App Service Name: $APP_NAME"
echo "App URL: https://$APP_URL"
echo ""
echo "IMPORTANT: Access the application at:"
echo "  https://$APP_URL/Index"
echo ""
echo "Note: It may take a few minutes for the app to be fully available."
echo "=========================================="

