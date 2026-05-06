# Logic App Standard hosted on VNET-enabled Storage Account with User-Assigned Managed Identity

**Scenario1File1.json**

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaly-d%2FInternalARMTemplates%2Frefs%2Fheads%2Fmain%2FLogic%2520App%2520Standard%2FScenario1File1.json)

What this does/deploys:
  - Virtual Network + Subnet
  - User-Assigned Managed Identity
  - App Service Plan (WS1 SKU)
  - Storage Account (Selected networks to VNET/Subnet)
  - [Grant UAMI permissions on Storage]
  - Logic App Standard (hosted on WS1)
  - [Associates Logic App Standard with VNET/subnet]


***

# Logic App Standard hosted on VNET-enabled Storage Account with User-Assigned Managed Identity, integrated with a NAT Gateway

**Scenario2File1.json**

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaly-d%2FInternalARMTemplates%2Frefs%2Fheads%2Fmain%2FLogic%2520App%2520Standard%2FScenario2File1.json)

What this does/deploys:
  - Virtual Network + Subnet
  - User-Assigned Managed Identity
  - App Service Plan (WS1 SKU)
  - Storage Account (Selected networks to VNET/Subnet)
  - [Grant UAMI permissions on Storage]
  - Logic App Standard (hosted on WS1) 
  - [Associates Logic App Standard with VNET/subnet]
  - NAT Gateway
  - [Associates NAT Gateway with VNET/Subnet]

***

# Logic App Standard hosted on VNET-enabled Storage Account with User-Assigned Managed Identity, integrated with a NAT Gateway and Public IP

**Scenario3File1.json**

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaly-d%2FInternalARMTemplates%2Frefs%2Fheads%2Fmain%2FLogic%2520App%2520Standard%2FScenario3File1.json)

What this does/deploys:
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

***

# Logic App Standard hosted on VNET-enabled Storage Account with User-Assigned Managed Identity, integrated with a NAT Gateway, Public IP, and Public IP Prefix


**Scenario4File1.json**

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaly-d%2FInternalARMTemplates%2Frefs%2Fheads%2Fmain%2FLogic%2520App%2520Standard%2FScenario4File1.json)

What this does/deploys:
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

***

# Logic App Standard hosted on VNET-enabled Storage Account with User-Assigned Managed Identity, integrated with an SFTP-enabled Storage Account


**Scenario5File1.json**

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaly-d%2FInternalARMTemplates%2Frefs%2Fheads%2Fmain%2FLogic%2520App%2520Standard%2FScenario5File1.json)

**Step 1:** Deploy the above template

What this does/deploys:
  - Virtual Network + Subnet
  - User-Assigned Managed Identity
  - App Service Plan (WS1 SKU)
  - Storage Account (Selected networks to VNET/Subnet)
  - [Grant UAMI permissions on Storage]
  - Logic App Standard (hosted on WS1)
  - [Associates Logic App Standard with VNET/subnet]
  - Storage Account #2 that acts as an SFTP Server

**Step 2:** Finish setting up the SFTP server on the Storage Account and generating a password for the local user
1. Navigate to Storage Account #2 > Settings > SFTP. On the local user you created, under **Authentication Method**, click on **Configure**.
2. Click on SSH Password > Next > Save. Copy the generated password.

**Step 3:** Finish setting up the Logic App, storing the SFTP password, and deploying the workflows for end-to-end testing
1. In the Logic App Standard, navigate to **Environment Variables**, search for the **Sftp_password** app setting and paste the value you copied from **Step 2.**
2. On this GitHub repository, navigate to the **Logic App Standard/workflows** folder.
3. Download the **Scenario5File1Workflows.zip** file. This contains the workflow zip for this scenario.
4. In the same folder, see the **README.md** for instructions on deploying the zip file to your Logic App, using AZ CLI.
5. Once the workflows have been deployed, test your workflows which will create and trigger on a file respectively.

***

# Logic App Standard hosted on VNET-enabled Storage Account with User-Assigned Managed Identity, integrated with Private Endpoint-enabled Service Bus Namespace

**Scenario6File1.json**

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaly-d%2FInternalARMTemplates%2Frefs%2Fheads%2Fmain%2FLogic%2520App%2520Standard%2FScenario6File1.json)

**Step 1:** Deploy the above template

What this does/deploys:
  - Virtual Network + 2 Subnets (1 for Logic App, 1 for Service Bus)
  - User-Assigned Managed Identity
  - App Service Plan (WS1 SKU)
  - Storage Account (Selected networks to VNET/Subnet)
  - [Grant UAMI permissions on Storage]
  - Logic App Standard (hosted on WS1)
  - [Associates Logic App Standard with VNET/subnet]
  - Deploys a Service Bus Namespace and queue, set to Disabled Public Access
  - Deploys a Private Endpoint, Private DNS Zone, and attaches it to the Service Bus subnet.

**Step 2:** Finish setting up the Logic App

1. On this GitHub repository, navigate to the **Logic App Standard/workflows** folder.
2. Download the **Scenario6File1Workflows.zip** file. This contains the workflow zip for this scenario.
3. In the same folder, see the **README.md** for instructions on deploying the zip file to your Logic App, using AZ CLI.
4. Once the workflows have been deployed, test your workflows which will send a message and trigger on a message respectively.
