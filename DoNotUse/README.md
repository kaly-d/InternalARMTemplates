# Scenario 7: Logic App Standard hosted on Private Endpoint-enabled Storage Account with User-Assigned Managed Identity, with SQL

# Scenario 9: Logic App Standard hosted on Private Endpoint-enabled Storage Account with User-Assigned Managed Identity, integrated with a Linux VM

***


<table>
  <tr>
    <th>Deployment File</th>
    <th>Quick Deploy</th>
    <th>What this Deploys</th>
  </tr>
  <tr>
    <td> <a href="https://github.com/kaly-d/InternalARMTemplates/blob/main/ARMApp%20Standard/Scenario2File1.json"> ARM</a> </td>
    <td> <a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaly-d%2FInternalARMTemplates%2Frefs%2Fheads%2Fmain%2FARM%2FLogic%2520App%25202FScenario2File1.json)">
      <img src="https://aka.ms/deploytoazurebutton">
    </a>
    </td>
    <td>
      <details>
        <summary>What this does/deploys</summary>
          <br>- Virtual Network + Subnet
          <br>- User-Assigned Managed Identity
          <br>- App Service Plan (WS1 SKU)
          <br>- Storage Account (Selected networks to VNET/Subnet)
          <br>- [Grant UAMI permissions on Storage]
          <br>- Logic App Standard (hosted on WS1)
          <br>- [Associates Logic App Standard with VNET/subnet]
          <br>- NAT Gateway
          <br>- [Associates NAT Gateway with VNET/Subnet]
          <br>- Deploy a Public IP
          <br>- [Associates NAT Gateway with Public IP]
          <br>- Deploy a Public IP Prefix
          <br>- [Associates NAT Gateway with Public IP Prefix]
      </details>
    </td>
  </tr>
</table>

# Scenario 2: Logic App Consumption with HTTP Trigger

```bash
az account set --subscription SUBSCRIPTION-NAME-OR-ID
terraform init
terraform validate
terraform plan -out=tfplan
```

Enter the parameter names here when prompted.

```bash
terraform apply "tfplan"
```
***

### Scenario 13: Logic App Standard hosted on Private Endpoint-enabled Storage Account with User-Assigned Managed Identity, integrated with a Windows VM hosting MSMQ Server, integrated with Logic App
🔒 | 🗂️

| Deployment File | Quick Deploy |
| :-------------: | :-------------: |
| [ARM](https://github.com/kaly-d/InternalARMTemplates/blob/main/ARM/DoNotUse/Scenario13File1.json)  | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaly-d%2FInternalARMTemplates%2Frefs%2Fheads%2Fmain%2FARM%2FDoNotUse%2FScenario13File1.json)  |


<details>
  <summary>🔎 What's Included In This Deployment</summary>

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

<details>
  <summary>📚 See Additional Deployment Instructions</summary>

#### Step 1: Deploy the above template

#### Step 2: Add/Confirm Bastion Connectivity
1. Review the Network settings of the VM, and ensure there is an allow rule to Bastion/VM. For example:
		**Priority**: 103
		**Name**: Allow-Bastion-To-VM
		**Port**: 22,3389
		**Protocol**: Any
		**Source IP**: 168.63.129.16
		**Destination IP**: 10.0.2.0/24
		**Rule**: Allow

2. Connect to the VM via Bastion (enter your username and password)

#### Step 3: Set up the VM to have the MSMQ Server/Broker services running
1. Install .NET 8
```powershell
$installer = "$env:TEMP\dotnet-hosting-8.0.0-win.exe"
$url = "https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/8.0.0/dotnet-hosting-8.0.0-win.exe"

Write-Host "Downloading ASP.NET Core 8.0.0 Hosting Bundle..."
Invoke-WebRequest -Uri $url -OutFile $installer

Write-Host "Installing ASP.NET Core 8.0.0 Hosting Bundle..."
Start-Process -FilePath $installer `
    -ArgumentList "/install /quiet /norestart" `
    -Wait

Write-Host "Installation complete."
dotnet --list-runtimes
```

2. Install MSMQ
```powershell

```

3. Download and extract broker package
```powershell

```

4. Create a Windows Service and start MSMQ and MSMQBroker
```powershell

```

5. Open firewall port for broker
```powershell

```

6. Check host health
```powershell

```

7. Create a Private Queue
```powershell
```

#### Step 4: Provide access to the subscriber
1. On the VM, navigate to
	Computer Management > Services and Applications > Message Queuing > Private Queues > Queue properties > Security > Add SYSTEM (Check names)
2. Grant
```text
Receive Message
Peek message
Get Properties
```
#### Step 5: Finish setting up the Logic App by deploying the workflows for end-to-end testing
1. On this GitHub repository, navigate to the **Workflows** folder.
2. Download the **msmqWorkflows.zip** file. This contains the workflow zip for this scenario.
3. In the same folder, see the **README.md** for instructions on deploying the zip file to your Logic App, using AZ CLI.

☑️ Once the workflows have been deployed, test your workflows by sending and receiving an MSMQ message.

</details>


***
