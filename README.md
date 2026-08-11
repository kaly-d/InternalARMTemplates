# ☰ Table of Contents

- What's in this Repository?
- [Quick Guide for Deployment Options by Language](#-quick-guide-for-deployment-language-options)
- [Template Scenarios](#-template-scenarios)

# ⚡ Quick Guide for Deployment Options by Language

In this repository, there are ARM and Bicep deployment options for some/all template scenarios.

## 📄 ARM

**Option 1**: Directly deploy the template by clicking the Deploy to Azure button
<br>
**Option 2**: In the Azure Portal, search for "Deploy a custom template", and paste the desired template file contents in the editor.

## 💪 Bicep

1. Download the appropriate template .bicep file for your scenario
2. On the Azure Portal, open the Cloud Shell
3. Click on _Manage files_ > _Upload_ and select the .bicep file you just downloaded
4. Run the following commands and replace the parameter names:

```bash
az account set --subscription SUBSCRIPTION-NAME-OR-ID
az deployment group create --name DEPLOYMENT-NAME --resource-group RESOURCE-GROUP-NAME --template-file FILE-NAME.bicep
```

# 📖 Template Scenarios
Below are the templates that are created for various scenarios, categorized by the Logic App resource type. Some templates will deploy non-Logic App resources to help with end-to-end testing.

## ① Logic App Standard

### Scenario 1: Logic App Standard hosted on VNET-enabled Storage Account with User-Assigned Managed Identity
🧱

| Deployment File | Quick Deploy |
| :-------------: | :-------------: |
| [ARM](https://github.com/kaly-d/InternalARMTemplates/blob/main/ARM/Logic%20App%20Standard/Scenario1File1.json)  | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaly-d%2FInternalARMTemplates%2Frefs%2Fheads%2Fmain%2FARM%2FLogic%2520App%2520Standard%2FScenario1File1.json)  |


<details>
  <summary>What this does/deploys</summary>

- Virtual Network + Subnet
- User-Assigned Managed Identity
- App Service Plan (WS1 SKU)
- Storage Account (Selected networks to VNET/Subnet)
- [Grant UAMI permissions on Storage]
- Logic App Standard (hosted on WS1)
- [Associates Logic App Standard with VNET/subnet]
  
</details>

***

### Scenario 2: Logic App Standard hosted on VNET-enabled Storage Account with User-Assigned Managed Identity, integrated with a NAT Gateway, Public IP, and Public IP Prefix
🧱

| Deployment File | Quick Deploy |
| :-------------: | :-------------: |
| [ARM](https://github.com/kaly-d/InternalARMTemplates/blob/main/ARM/Logic%20App%20Standard/Scenario2File1.json)  | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaly-d%2FInternalARMTemplates%2Frefs%2Fheads%2Fmain%2FARM%2FLogic%2520App%2520Standard%2FScenario2File1.json)  |


<details>
  <summary>What this does/deploys</summary>

  - Virtual Network + Subnet
  - User-Assigned Managed Identity
  - App Service Plan (WS1 SKU)
  - Storage Account (Selected networks to VNET/Subnet)
  - [Grant UAMI permissions on Storage]
  - Logic App Standard (hosted on WS1)
  - [Associates Logic App Standard with VNET/subnet]
  - NAT Gateway
  - [Associates NAT Gateway with VNET/Subnet]
  - Deploy a Public IP
  - [Associates NAT Gateway with Public IP]
  - Deploy a Public IP Prefix
  - [Associates NAT Gateway with Public IP Prefix]

</details>

<details>
  <summary>View detailed steps here</summary>

#### Step 1: Generate unique URL

1. Navigate to this URL to generate a custom endpoint webhook.site
2. Your unique URL will look something like: https://webhook.site/abcdefgh-ijkl-mnop-qrst-uvwxyzabcdef. Make a note of this.

#### Step 2: Deploy the above template

⚠️ In the **endpointURL** parameter, enter the value you stored from Step 1.

#### Step 3: Finish setting up the Logic App

1. On this GitHub repository, navigate to the **Workflows** folder.
2. Download the **natgatewayWorkflows.zip** file. This contains the workflow zip for this scenario.
3. In the same folder, see the **README.md** for instructions on deploying the zip file to your Logic App, using AZ CLI.
4. Once the workflows have been deployed, test your workflows which will send a message to the endpoint URL, and review the IP address used in the request belongs to the IP Prefix associated with the NAT Gateway 

</details>

***

### Scenario 3: Logic App Standard hosted on VNET-enabled Storage Account with User-Assigned Managed Identity, integrated with an SFTP-enabled Storage Account
🧱

| Deployment File | Quick Deploy |
| :-------------: | :-------------: |
| [ARM](https://github.com/kaly-d/InternalARMTemplates/blob/main/ARM/Logic%20App%20Standard/Scenario3File1.json)  | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaly-d%2FInternalARMTemplates%2Frefs%2Fheads%2Fmain%2FARM%2FLogic%2520App%2520Standard%2FScenario3File1.json)  |

<details>
  <summary>What this does/deploys</summary>

  - Virtual Network + Subnet
  - User-Assigned Managed Identity
  - App Service Plan (WS1 SKU)
  - Storage Account (Selected networks to VNET/Subnet)
  - [Grant UAMI permissions on Storage]
  - Logic App Standard (hosted on WS1)
  - [Associates Logic App Standard with VNET/subnet]
  - Storage Account #2 that acts as an SFTP Server

</details>

<details>
  <summary>View detailed steps here</summary>

#### Step 1: Deploy the above template

#### Step 2: Finish setting up the SFTP server on the Storage Account and generating a password for the local user
1. Navigate to Storage Account #2 > Settings > SFTP. On the local user you created, under **Authentication Method**, click on **Configure**.
2. Click on SSH Password > Next > Save.
3. Make a note of the generated password.

#### Step 3: Finish setting up the Logic App, storing the SFTP password, and deploying the workflows for end-to-end testing
1. In the Logic App Standard, navigate to **Environment Variables**, search for the **Sftp_password** app setting and paste the value you copied from **Step 2.**
2. On this GitHub repository, navigate to the **Workflows** folder.
3. Download the **sftpWorkflows.zip** file. This contains the workflow zip for this scenario.
4. In the same folder, see the **README.md** for instructions on deploying the zip file to your Logic App, using AZ CLI.
5. Once the workflows have been deployed, test your workflows which will create and trigger on a file respectively.

</details>

***

### Scenario 4: Logic App Standard hosted on VNET-enabled Storage Account with User-Assigned Managed Identity, integrated with Private Endpoint-enabled Service Bus Namespace
🧱 | 🔒

| Deployment File | Quick Deploy |
| :-------------: | :-------------: |
| [ARM](https://github.com/kaly-d/InternalARMTemplates/blob/main/ARM/Logic%20App%20Standard/Scenario4File1.json)  | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaly-d%2FInternalARMTemplates%2Frefs%2Fheads%2Fmain%2FARM%2FLogic%2520App%2520Standard%2FScenario4File1.json)  |


<details>
  <summary>What this does/deploys</summary>
 
  - Virtual Network + 2 Subnets (1 for Logic App, 1 for Service Bus)
  - User-Assigned Managed Identity
  - App Service Plan (WS1 SKU)
  - Storage Account (Selected networks to VNET/Subnet)
  - [Grant UAMI permissions on Storage]
  - Logic App Standard (hosted on WS1)
  - [Associates Logic App Standard with VNET/subnet]
  - Deploys a Service Bus Namespace and queue, set to Disabled Public Access
  - Deploys a Private Endpoint, Private DNS Zone, and attaches it to the Service Bus subnet.
</details>


<details>
  <summary>View detailed steps here</summary>

#### Step 1: Deploy the above template

#### Step 2: Finish setting up the Logic App

1. On this GitHub repository, navigate to the **Workflows** folder.
2. Download the **servicebusWorkflows.zip** file. This contains the workflow zip for this scenario.
3. In the same folder, see the **README.md** for instructions on deploying the zip file to your Logic App, using AZ CLI.
4. Once the workflows have been deployed, test your workflows which will send a message and trigger on a message respectively.

</details>

***

### Scenario 5: Logic App Standard hosted on Private Endpoint-enabled Storage Account with User-Assigned Managed Identity
🔒

| Deployment File | Quick Deploy |
| :-------------: | :-------------: |
| [ARM](https://github.com/kaly-d/InternalARMTemplates/blob/main/ARM/Logic%20App%20Standard/Scenario5File1.json)  | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaly-d%2FInternalARMTemplates%2Frefs%2Fheads%2Fmain%2FARM%2FLogic%2520App%2520Standard%2FScenario5File1.json)  |


<details>
  <summary>What this does/deploys</summary>

  - Virtual Network + 2 Subnets (1 for Logic App, 1 for Storage)
  - User-Assigned Managed Identity
  - App Service Plan (WS1 SKU)
  - Storage Account (Public Access Disabled)
  - Private DNS Zones for File, Blob, Queue, and Table Services
  - Virtual Network Links for VNET and Private DNS Zones
  - Private Endpoints for File, Blob, Queue, and Table Services
  - Private DNS Zone Groups for File, Blob, Queue, and Table Services
  - [Grant UAMI permissions on Storage]
  - Logic App Standard (hosted on WS1)
  - [Associates Logic App Standard with VNET/subnet]

</details>

***

### Scenario 6: Logic App Standard hosted on Private Endpoint-enabled Storage Account with User-Assigned Managed Identity, integrated with a Windows VM
🔒

| Deployment File | Quick Deploy |
| :-------------: | :-------------: |
| [ARM](https://github.com/kaly-d/InternalARMTemplates/blob/main/ARM/Logic%20App%20Standard/Scenario6File1.json)  | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaly-d%2FInternalARMTemplates%2Frefs%2Fheads%2Fmain%2FARM%2FLogic%2520App%2520Standard%2FScenario6File1.json)  |


<details>
  <summary>What this does/deploys</summary>

  - Virtual Network + 3 Subnets (1 for Logic App, 1 for Storage, 1 for Virtual Machine)
  - User-Assigned Managed Identity
  - Windows Virtual Machine, with Networking-related components (NSG, NIC, Public IP)
  - Azure Bastion (for connecting to Virtual Machine within Azure Portal)
  - App Service Plan (WS1 SKU)
  - Storage Account (Public Access Disabled)
  - Private DNS Zones for File, Blob, Queue, and Table Services
  - Virtual Network Links for VNET and Private DNS Zones
  - Private Endpoints for File, Blob, Queue, and Table Services
  - Private DNS Zone Groups for File, Blob, Queue, and Table Services
  - [Grant UAMI permissions on Storage]
  - Logic App Standard (hosted on WS1)
  - [Associates Logic App Standard with VNET/subnet]

</details>

***

### Scenario 7: Logic App Standard hosted on Private Endpoint-enabled Storage Account with User-Assigned Managed Identity, integrated with an SFTP-enabled Storage Account
🔒

| Deployment File | Quick Deploy |
| :-------------: | :-------------: |
| [ARM](https://github.com/kaly-d/InternalARMTemplates/blob/main/ARM/Logic%20App%20Standard/Scenario7File1.json)  | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaly-d%2FInternalARMTemplates%2Frefs%2Fheads%2Fmain%2FARM%2FLogic%2520App%2520Standard%2FScenario7File1.json)  |


<details>
  <summary>What this does/deploys</summary>

  - Virtual Network + 3 Subnets (1 for Logic App, 2 for Storage)
  - User-Assigned Managed Identity
  - App Service Plan (WS1 SKU)
  - 2 Storage Accounts (Public Access Disabled)
  - Private DNS Zones for File, Blob, Queue, and Table Services
  - Virtual Network Links for VNET and Private DNS Zones
  - Private Endpoints for File, Blob, Queue, and Table Services
  - Private DNS Zone Groups for File, Blob, Queue, and Table Services
  - [Grant UAMI permissions on Storage]
  - Logic App Standard (hosted on WS1)
  - [Associates Logic App Standard with VNET/subnet]
  - Storage Account #2 that acts as an SFTP Server

</details>

<details>
  <summary>View detailed steps here</summary>

#### Step 1: Deploy the above template

#### Step 2: Finish setting up the SFTP server on the Storage Account and generating a password for the local user
1. Navigate to Storage Account #2 > Settings > SFTP. On the local user you created, under **Authentication Method**, click on **Configure**.
2. Click on SSH Password > Next > Save.
3. Make a note of the generated password.

#### Step 3: Finish setting up the Logic App, storing the SFTP password, and deploying the workflows for end-to-end testing
1. In the Logic App Standard, navigate to **Environment Variables**, search for the **Sftp_password** app setting and paste the value you copied from **Step 2.**
2. On this GitHub repository, navigate to the **Workflows** folder.
3. Download the **sftpWorkflows.zip** file. This contains the workflow zip for this scenario.
4. In the same folder, see the **README.md** for instructions on deploying the zip file to your Logic App, using AZ CLI.
5. Once the workflows have been deployed, test your workflows which will create and trigger on a file respectively.

</details>

***

### Scenario 8: Logic App Standard hosted on Private Endpoint-enabled Storage Account with User-Assigned Managed Identity, integrated with Private Endpoint-enabled Service Bus Namespace
🔒

| Deployment File | Quick Deploy |
| :-------------: | :-------------: |
| [ARM](https://github.com/kaly-d/InternalARMTemplates/blob/main/ARM/Logic%20App%20Standard/Scenario8File1.json)  | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaly-d%2FInternalARMTemplates%2Frefs%2Fheads%2Fmain%2FARM%2FLogic%2520App%2520Standard%2FScenario8File1.json)  |


<details>
  <summary>What this does/deploys</summary>

  - Virtual Network + 3 Subnets (1 for Logic App, 1 for Storage, 1 for Service Bus)
  - User-Assigned Managed Identity
  - App Service Plan (WS1 SKU)
  - Storage Account (Public Access Disabled)
  - Private DNS Zones for File, Blob, Queue, and Table Services
  - Virtual Network Links for VNET and Private DNS Zones
  - Private Endpoints for File, Blob, Queue, and Table Services
  - Private DNS Zone Groups for File, Blob, Queue, and Table Services
  - [Grant UAMI permissions on Storage]
  - Logic App Standard (hosted on WS1)
  - [Associates Logic App Standard with VNET/subnet]
  - Deploys a Service Bus Namespace and queue, set to Disabled Public Access
  - Deploys a Private Endpoint, Private DNS Zone, and attaches it to the Service Bus subnet.


</details>

***

### Scenario 9: Logic App Standard hosted on Private Endpoint-enabled Storage Account with User-Assigned Managed Identity, integrated with a Windows VM, and File Share mounted/integrated with Logic App
🔒

| Deployment File | Quick Deploy |
| :-------------: | :-------------: |
| [ARM](https://github.com/kaly-d/InternalARMTemplates/blob/main/ARM/Logic%20App%20Standard/Scenario9File1.json)  | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaly-d%2FInternalARMTemplates%2Frefs%2Fheads%2Fmain%2FARM%2FLogic%2520App%2520Standard%2FScenario9File1.json)  |
| [Bicep](https://github.com/kaly-d/InternalARMTemplates/blob/main/Bicep/Logic%20App%20Standard/Scenario9File1.bicep) | [See Bicep Deploy Instructions](https://github.com/kaly-d/InternalARMTemplates/blob/main/DoNotUse/README1.md#bicep) |

<details>
  <summary>What this does/deploys</summary>

  - Virtual Network + 3 Subnets (1 for Logic App, 1 for Storage, 1 for Virtual Machine)
  - User-Assigned Managed Identity
  - Windows Virtual Machine, with Networking-related components (NSG, NIC, Public IP)
  - Azure Bastion (for connecting to Virtual Machine within Azure Portal)
  - App Service Plan (WS1 SKU)
  - Storage Account (Public Access Disabled)
  - Private DNS Zones for File, Blob, Queue, and Table Services
  - Virtual Network Links for VNET and Private DNS Zones
  - Private Endpoints for File, Blob, Queue, and Table Services
  - Private DNS Zone Groups for File, Blob, Queue, and Table Services
  - [Grant UAMI permissions on Storage]
  - Logic App Standard (hosted on WS1)
  - [Associates Logic App Standard with VNET/subnet]
  - File Share (folder with test file) on the Windows VM with corresponding mount on Logic App

</details>

<details>
  <summary>View detailed steps here</summary>

#### Step 1: Deploy the above template

#### Step 2: Finish setting up the Logic App by deploying the workflows for end-to-end testing
1. On this GitHub repository, navigate to the **Workflows** folder.
2. Download the **fileshareWorkflows.zip** file. This contains the workflow zip for this scenario.
3. In the same folder, see the **README.md** for instructions on deploying the zip file to your Logic App, using AZ CLI.
4. Once the workflows have been deployed, test your workflows which will list the file in the file share.

</details>


***

### Scenario 10: Logic App Standard hosted on Private Endpoint-enabled Storage Account with User-Assigned Managed Identity, integrated with a Windows VM, and File Share mounted/integrated with Logic App (⚠️ with Auto-Shutdown feature)
🔒

| Deployment File | Quick Deploy |
| :-------------: | :-------------: |
| [ARM](https://github.com/kaly-d/InternalARMTemplates/blob/main/ARM/Logic%20App%20Standard/Scenario10File1.json)  | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaly-d%2FInternalARMTemplates%2Frefs%2Fheads%2Fmain%2FARM%2FLogic%2520App%2520Standard%2FScenario10File1.json)  |
| [Bicep](https://github.com/kaly-d/InternalARMTemplates/blob/main/Bicep/Logic%20App%20Standard/Scenario10File1.bicep) | [See Bicep Deploy Instructions](https://github.com/kaly-d/InternalARMTemplates/blob/main/DoNotUse/README1.md#bicep) |

<details>
  <summary>What this does/deploys</summary>

  - Virtual Network + 3 Subnets (1 for Logic App, 1 for Storage, 1 for Virtual Machine)
  - User-Assigned Managed Identity
  - Windows Virtual Machine, with Networking-related components (NSG, NIC, Public IP)
  - Auto-Shutdown of VM feature enabled (shutdown time configurable) 
  - Azure Bastion (for connecting to Virtual Machine within Azure Portal)
  - App Service Plan (WS1 SKU)
  - Storage Account (Public Access Disabled)
  - Private DNS Zones for File, Blob, Queue, and Table Services
  - Virtual Network Links for VNET and Private DNS Zones
  - Private Endpoints for File, Blob, Queue, and Table Services
  - Private DNS Zone Groups for File, Blob, Queue, and Table Services
  - [Grant UAMI permissions on Storage]
  - Logic App Standard (hosted on WS1)
  - [Associates Logic App Standard with VNET/subnet]
  - File Share (folder with test file) on the Windows VM with corresponding mount on Logic App

</details>

<details>
  <summary>View detailed steps here</summary>

#### Step 1: Deploy the above template

#### Step 2: Finish setting up the Logic App by deploying the workflows for end-to-end testing
1. On this GitHub repository, navigate to the **Workflows** folder.
2. Download the **fileshareWorkflows.zip** file. This contains the workflow zip for this scenario.
3. In the same folder, see the **README.md** for instructions on deploying the zip file to your Logic App, using AZ CLI.
4. Once the workflows have been deployed, test your workflows which will list the file in the file share.

</details>


***

### Scenario 11: Logic App Standard hosted on VNET-enabled Storage Account with User-Assigned Managed Identity, integrated with a SQL Server with Public Access set to Selected networks and IPs
🧱

| Deployment File | Quick Deploy |
| :-------------: | :-------------: |
| [ARM](https://github.com/kaly-d/InternalARMTemplates/blob/main/ARM/Logic%20App%20Standard/Scenario11File1.json)  | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaly-d%2FInternalARMTemplates%2Frefs%2Fheads%2Fmain%2FARM%2FLogic%2520App%2520Standard%2FScenario11File1.json)  |


<details>
  <summary>What this does/deploys</summary>

  - Virtual Network + Subnet
  - User-Assigned Managed Identity
  - App Service Plan (WS1 SKU)
  - Storage Account (and whitelists subnets via selected networks to VNET/Subnet)
  - [Grant UAMI permissions on Storage]
  - Logic App Standard (hosted on WS1)
  - [Associates Logic App Standard with VNET/subnet]
  - SQL Server (and whitelists subnets via selected networks to VNET/Subnet)
  - SQL Database (Pre-configured data)

</details>

<details>
  <summary>View detailed steps here</summary>

#### Step 1: Deploy the above template

#### Step 2: Finish setting up the SQL server

1. Navigate to the SQL Server > Networking.
2. Whitelist your Client IP on the SQL Firewall

#### Step 3: Assign the User-Identity permissions on the SQL Database and enable Change Tracking for the Database and Table

1. On the SQL Database, go to **Query editor** and run the following commands.

```SQL
CREATE USER [YOUR-SERVICE-PRINCIPAL-NAME] 
FROM EXTERNAL PROVIDER; 
ALTER ROLE db_datareader ADD MEMBER [YOUR-SERVICE-PRINCIPAL-NAME];
ALTER ROLE db_datawriter ADD MEMBER [YOUR-SERVICE-PRINCIPAL-NAME];
ALTER ROLE db_owner ADD MEMBER [YOUR-SERVICE-PRINCIPAL-NAME];
```

🔗 See here for a list of database roles: [Database Roles](https://learn.microsoft.com/en-us/sql/relational-databases/security/authentication-access/database-level-roles?view=sql-server-ver17#fixed-database-roles)

2. Run the following commands to enable tracking on the database and the table. In this lab, the SQL table is pre-defined since the database is pre-populated. 

```SQL
ALTER DATABASE [YOUR-DATABASE-NAME]
SET CHANGE_TRACKING = ON
```
```SQL
ALTER TABLE [SalesLT].[Customer]
ENABLE CHANGE_TRACKING;
```

#### Step 4: Finish setting up the Logic App and deploying the workflows for end-to-end testing
1. On this GitHub repository, navigate to the **Workflows** folder.
2. Download the **sqlWorkflows.zip** file. This contains the workflow zip for this scenario.
3. In the same folder, see the **README.md** for instructions on deploying the zip file to your Logic App, using AZ CLI.
4. Once the workflows have been deployed, test your workflows which will create and trigger on a SQL Database row respectively. The table and row information is also pre-configured in the workflows, so no additional edits to the workflows are required.

</details>

***

### Scenario 12: Logic App Standard hosted on Private Endpoint-enabled Storage Account with User-Assigned Managed Identity, integrated with a Windows SQL VM and Private Endpoint-enabled SQL Server/Database
🔒

| Deployment File | Quick Deploy |
| :-------------: | :-------------: |
| [ARM](https://github.com/kaly-d/InternalARMTemplates/blob/main/ARM/Logic%20App%20Standard/Scenario12File1.json)  | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaly-d%2FInternalARMTemplates%2Frefs%2Fheads%2Fmain%2FARM%2FLogic%2520App%2520Standard%2FScenario12File1.json)  |


<details>
  <summary>What this does/deploys</summary>

  - Virtual Network + 4 Subnets (1 for Logic App, 1 for Storage, 1 for Virtual Machine, 1 for SQL)
  - User-Assigned Managed Identity
  - Windows Virtual Machine, with Networking-related components (NSG, NIC, Public IP)
  - Azure Bastion (for connecting to Virtual Machine within Azure Portal)
  - App Service Plan (WS1 SKU)
  - Storage Account (Public Access Disabled)
  - Private DNS Zones for File, Blob, Queue, and Table Services
  - Virtual Network Links for VNET and Private DNS Zones
  - Private Endpoints for File, Blob, Queue, and Table Services
  - Private DNS Zone Groups for File, Blob, Queue, and Table Services
  - [Grant UAMI permissions on Storage]
  - Logic App Standard (hosted on WS1)
  - [Associates Logic App Standard with VNET/subnet]
  - SQL Server (with Private Endpoint-related components)
  - SQL Database (Pre-configured data)

</details>

<details>
  <summary>View detailed steps here</summary>

#### Step 1: Deploy the above template

#### Step 2: Finish setting up the Logic App and deploying the workflows for end-to-end testing
1. On this GitHub repository, navigate to the **Workflows** folder.
2. Download the **sqlWorkflows.zip** file. This contains the workflow zip for this scenario.
3. In the same folder, see the **README.md** for instructions on deploying the zip file to your Logic App, using AZ CLI.
4. Once the workflows have been deployed, test your workflows which will create and trigger on a SQL Database row respectively.

</details>

***
## ② Logic App Consumption

### Scenario 1: Logic App Consumption connected to a Logic App Custom Connector
🌐

| Deployment File | Quick Deploy |
| :-------------: | :-------------: |
| [ARM](https://github.com/kaly-d/InternalARMTemplates/blob/main/ARM/Logic%20App%20Consumption/Scenario1File1.json)  | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaly-d%2FInternalARMTemplates%2Frefs%2Fheads%2Fmain%2FARM%2FLogic%2520App%2520Consumption%2FScenario1File1.json)  |

<details>
  <summary>What this does/deploys</summary>
  
What this does/deploys:
  - Logic App Custom Connector with 2 actions (1 GET, 1 POST) to invoke Public Endpoint API for testing
  - API Connection to Logic App Custom Connector
  - Logic App Consumption configured with both to invoke Public Endpoint

</details>

<details>
  <summary>View detailed steps here</summary>
  
#### Step 1: Generate unique URL
1. Navigate to this URL to generate a custom endpoint **webhook.site**
2. Your unique URL will look something like: https://webhook.site/abcdefgh-ijkl-mnop-qrst-uvwxyzabcdef.
3. Make a note of the **basePath** which is the '**/**' and '**ID**' from your URL. For example: **/abcdefgh-ijkl-mnop-qrst-uvwxyzabcdef**

#### Step 2: Deploy the above template

⚠️ In the **basePath** parameter, replace the basePath with the value you stored from Step 1.

</details>

***
