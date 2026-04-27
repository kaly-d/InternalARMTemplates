**Scenario6File1.json**

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaly-d%2FInternalARMTemplates%2Frefs%2Fheads%2Fmain%2FDoNotUse%2FScenario6File1.json)

What this does/deploys:
  - Virtual Network + Subnet
  - User-Assigned Managed Identity
  - App Service Plan (WS1 SKU)
  - Storage Account (Selected networks to VNET/Subnet)
  - [Grant UAMI permissions on Storage]
  - Logic App Standard (hosted on WS1)
  - [Associates Logic App Standard with VNET/subnet]


***

