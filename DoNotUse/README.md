**Scenario7File1.json**

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaly-d%2FInternalARMTemplates%2Frefs%2Fheads%2Fmain%2FDoNotUse%2FScenario7File1.json)

**Step 1:** Deploy the above template

**What this does/deploys:**
  - Virtual Network + 3 Subnets (Logic App Outbound Subnet, Storage Private Endpoint Subnet, SQL Private Endpoint Subnet)
  - User-Assigned Managed Identity
  - App Service Plan (WS1 SKU)
  - Storage Account (Private Endpoint-enabled)
  - [Grant UAMI permissions on Storage]
  - Logic App Standard (hosted on WS1)
  - [Associates Logic App Standard with VNET/subnet]
  - SQL Server and SQL Database with Entra ID authentication
  - Private Endpoint-related artifacts: DNS Zone, DNS Zone Groups

**Step 2:** Run the following SQL commands to grant your Service Principal access to the database

CREATE USER [Your Logic App Standard Name] FROM EXTERNAL PROVIDER; 

ALTER ROLE db_owner ADD MEMBER [your Logic App Standard Name];




**Step 3:** Run the following SQL commands to enable Change Tracking on your SQL Database and individual tables to allow the Logic App to monitor for changes (required for the trigger)


ALTER DATABASE [Your Database Name]

SET CHANGE_TRACKING = ON


ALTER TABLE [Schema Name].[Your Table Name]

ENABLE CHANGE_TRACKING;




# Scenario 9: Logic App Standard hosted on Private Endpoint-enabled Storage Account with User-Assigned Managed Identity, integrated with a Linux VM


**Scenario9File1.json**

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaly-d%2FInternalARMTemplates%2Frefs%2Fheads%2Fmain%2FDoNotUse%2FScenario9File1.json)

**Step 1:** Deploy the above template


# Scenario 10: Logic App Standard hosted on Private Endpoint-enabled Storage Account with User-Assigned Managed Identity, integrated with a Windows SQL VM and SQL Server/Database


**Scenario10File1.json**

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaly-d%2FInternalARMTemplates%2Frefs%2Fheads%2Fmain%2FDoNotUse%2FScenario10File1.json)

**Step 1:** Deploy the above template



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

