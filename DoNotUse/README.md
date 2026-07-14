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


CREATE USER [your Service Principal Name]
FROM EXTERNAL PROVIDER; 
ALTER ROLE db_datareader ADD MEMBER [your Service Principal Name];
ALTER ROLE db_datawriter ADD MEMBER [your Service Principal Name];

ALTER DATABASE [your database name]
SET CHANGE_TRACKING = ON

ALTER TABLE [dbo].[your table name]
ENABLE CHANGE_TRACKING;

***
