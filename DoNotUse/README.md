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

