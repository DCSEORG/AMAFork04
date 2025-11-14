# Expense Management System - Deployment Guide

This repository contains a modernized Azure cloud-native version of the legacy Expense Management System.

## 🎯 What's Included

- **Azure Infrastructure as Code**: Bicep templates for Azure App Service
- **ASP.NET Core Application**: Modern Razor Pages web application
- **Automated Deployment**: Single-command deployment script
- **Pre-built Package**: Ready-to-deploy `app.zip` file

## 📋 Prerequisites

- Azure CLI installed ([Install Guide](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli))
- Active Azure subscription
- Bash shell (Linux, macOS, or WSL on Windows)

## 🚀 Quick Start

### 1. Login to Azure

```bash
az login
az account set --subscription <your-subscription-id>
```

### 2. Deploy Everything

Run the master deployment script:

```bash
./deploy.sh
```

This single command will:
- Create a resource group in UK South
- Deploy Azure App Service with B1 (low-cost development) SKU
- Deploy the application code
- Display the application URL

### 3. Access the Application

After deployment completes, access your application at:

```
https://<your-app-url>/Index
```

⚠️ **IMPORTANT**: Make sure to navigate to `/Index` - the root URL won't show the application.

## 📁 Repository Structure

```
.
├── deploy.sh                          # Master deployment script
├── infrastructure/
│   └── app-service.bicep             # App Service infrastructure
├── ExpenseManagementApp/             # ASP.NET Core application source
│   ├── Models/                       # Data models
│   ├── Pages/                        # Razor Pages
│   └── wwwroot/                      # Static files (CSS, JS)
├── app.zip                           # Pre-built deployment package
└── README-DEPLOYMENT.md              # This file
```

## 🔧 Manual Deployment (Alternative)

If you prefer step-by-step deployment:

### Deploy Infrastructure Only

```bash
RESOURCE_GROUP="ExpenseManagementRG"
LOCATION="uksouth"
APP_NAME="expense-mgmt-app-$RANDOM"

az group create --name $RESOURCE_GROUP --location $LOCATION

az deployment group create \
  --resource-group $RESOURCE_GROUP \
  --template-file ./infrastructure/app-service.bicep \
  --parameters appServiceName=$APP_NAME location=$LOCATION
```

### Deploy Application Code

```bash
az webapp deploy \
  --resource-group $RESOURCE_GROUP \
  --name $APP_NAME \
  --src-path ./app.zip \
  --type zip
```

## 🛠️ Building from Source

To rebuild the application:

```bash
cd ExpenseManagementApp

# Build
dotnet build

# Publish
dotnet publish -c Release -o ./publish

# Create deployment package
cd publish
zip -r ../../app.zip .
cd ../..
```

## 📊 Features

The application includes three main sections matching the legacy system:

1. **Add Expense**: Form to submit new expenses
   - Amount, Date, Category, Description fields
   - Categories: Travel, Food, Office Supplies, Transport

2. **Expenses**: View all expenses with filtering
   - Displays Date, Category, Amount, Status
   - Filter capability

3. **Approve Expenses**: Review and approve pending expenses
   - Shows pending expenses only
   - Approve functionality

**Note**: This is a proof-of-concept. The current version uses dummy data and does not persist to a database.

## 🔒 Azure Best Practices Applied

- ✅ HTTPS only enforcement
- ✅ Minimum TLS 1.2
- ✅ HTTP/2 enabled
- ✅ FTPS disabled
- ✅ Development SKU for cost optimization
- ✅ .NET 8.0 runtime

## 🧹 Cleanup

To delete all resources:

```bash
az group delete --name ExpenseManagementRG --yes --no-wait
```

## 📝 Notes

- The application is configured for a workshop/POC environment
- For production use, additional considerations are needed (authentication, database, monitoring, etc.)
- The B1 SKU is suitable for development/testing but may need scaling for production

## 📚 Learn More

- [Azure App Service Documentation](https://learn.microsoft.com/en-us/azure/app-service/)
- [ASP.NET Core Razor Pages](https://learn.microsoft.com/en-us/aspnet/core/razor-pages/)
- [Azure Bicep Documentation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/)
