**Scenario5File1.json**

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaly-d%2FInternalARMTemplates%2Frefs%2Fheads%2Fmain%2FDoNotUse%2FScenario5File1.json)

**What this does/deploys:**
  - Virtual Network + Subnet
  - User-Assigned Managed Identity
  - App Service Plan (WS1 SKU)
  - Storage Account (Selected networks to VNET/Subnet)
  - [Grant UAMI permissions on Storage]
  - Logic App Standard (hosted on WS1)
  - [Associates Logic App Standard with VNET/subnet]
  - 

CREATE USER [your Service Principal Name] 
FROM EXTERNAL PROVIDER; 
ALTER ROLE db_datareader ADD MEMBER [your Service Principal Name];
ALTER ROLE db_datawriter ADD MEMBER [your Service Principal Name];

ALTER DATABASE [your database name]
SET CHANGE_TRACKING = ON

ALTER TABLE [dbo].[your table name]
ENABLE CHANGE_TRACKING;

***

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


🔗 See here for a list of database roles: [Database Roles](https://learn.microsoft.com/en-us/sql/relational-databases/security/authentication-access/database-level-roles?view=sql-server-ver17#fixed-database-roles)


**Step 3:** Run the following SQL commands to enable Change Tracking on your SQL Database and individual tables to allow the Logic App to monitor for changes (required for the trigger)


ALTER DATABASE [Your Database Name]

SET CHANGE_TRACKING = ON


ALTER TABLE [Schema Name].[Your Table Name]

ENABLE CHANGE_TRACKING;



# Scenario 8: Logic App Standard hosted on Private Endpoint-enabled Storage Account with User-Assigned Managed Identity, integrated with an SFTP-enabled Storage Account


**Scenario9File1.json**

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaly-d%2FInternalARMTemplates%2Frefs%2Fheads%2Fmain%2FDoNotUse%2FScenario8File1.json)

**Step 1:** Deploy the above template





# Scenario 9: Logic App Standard hosted on Private Endpoint-enabled Storage Account with User-Assigned Managed Identity, integrated with a Linux VM


**Scenario9File1.json**

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaly-d%2FInternalARMTemplates%2Frefs%2Fheads%2Fmain%2FDoNotUse%2FScenario9File1.json)

**Step 1:** Deploy the above template
