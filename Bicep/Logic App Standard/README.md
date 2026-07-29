## Scenario 1: Logic App Standard hosted on Private Endpoint-enabled Storage Account with User-Assigned Managed Identity, integrated with a Windows VM, and File Share mounted/integrated with Logic App

**Scenario1File1.bicep**

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

### Step 1: Deploy the above template

_az account set --subscription **Subscription Name or ID**_

_az deployment group create --name **DeploymentName** --resource-group **ResourceGroupName** --template-file **FileName**.bicep_


### Step 2: Finish setting up the Logic App by deploying the workflows for end-to-end testing
1. On this GitHub repository, navigate to the **Workflows** folder.
2. Download the **fileshareWorkflows.zip** file. This contains the workflow zip for this scenario.
3. In the same folder, see the **README.md** for instructions on deploying the zip file to your Logic App, using AZ CLI.
4. Once the workflows have been deployed, test your workflows which will list the file in the file share.

</details>

***

## Scenario 2: Logic App Standard hosted on Private Endpoint-enabled Storage Account with User-Assigned Managed Identity, integrated with a Windows VM, and File Share mounted/integrated with Logic App (⚠️ with Auto-Shutdown feature)

**Scenario2File1.json**

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

### Step 1: Deploy the above template

### Step 2: Finish setting up the Logic App by deploying the workflows for end-to-end testing
1. On this GitHub repository, navigate to the **Workflows** folder.
2. Download the **fileshareWorkflows.zip** file. This contains the workflow zip for this scenario.
3. In the same folder, see the **README.md** for instructions on deploying the zip file to your Logic App, using AZ CLI.
4. Once the workflows have been deployed, test your workflows which will list the file in the file share.

</details>

