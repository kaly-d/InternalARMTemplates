param location string = resourceGroup().location

@description('This will the VNET that is connected to the Logic App\'s Outbound VNET configuration and also the Storage Private Endpoint')
param virtualNetworkName string = 'vnet'
param vnetAddressPrefix string = '10.0.0.0/16'
param logicAppSubnetName string = 'logicAppSubnet'
param logicAppSubnetPrefix string = '10.0.0.0/24'
param storageSubnetName string = 'storageSubnet'
param storageSubnetPrefix string = '10.0.1.0/24'
param vmSubnetName string = 'vmSubnet'
param vmSubnetPrefix string = '10.0.2.0/24'
param logicAppName string


@description('This will be the WS1 App Service Plan hosting the Logic App')
param hostingPlanName string
param storageAccountName string

@description('This will be the User-Assigned Identity that your Logic App will use to authenticate to Storage')
param userAssignedIdentityName string = 'uami'
param vmName string = 'testvm'
param vmSize string = 'Standard_B2ls_v2'
param vmAdminUsername string

@secure()
param vmAdminPassword string
param vmNicName string = 'nic'
param vmNsgName string = 'nsg'
param vmPublicIpName string = 'pip'
param enableAutoShutdown bool = true

@description('24-hour format HHmm when you want to shut down your VM')
param autoShutdownTime string = '1700'

@description('The timezone the auto-shutdown of the VM will follow')
param autoShutdownTimeZone string = 'Pacific Standard Time'

@description('Send a notification before VM auto-shutdown.')
param autoShutdownNotificationEnabled bool = false

@description('Number of minutes before shutdown to send the notification. Ignored when notifications are disabled.')
param autoShutdownNotificationMinutes int = 30
param autoShutdownNotificationLocale string = 'en'
param enableBastion bool = true
param bastionName string = 'vnet-bastion'
param bastionDnsName string = 'bastion-${uniqueString(resourceGroup().id,virtualNetworkName)}'

@allowed([
  'Developer'
])
param bastionSkuName string = 'Developer'
param fileShareName string = 'LogicAppShare'

var uamiResourceId = userAssignedIdentity.id
var subnetResourceId = resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName, logicAppSubnetName)
var serverFarmResourceId = hostingPlan.id
var vmSubnetResourceId = resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName, vmSubnetName)
var vmNicResourceId = vmNic.id
var vmPublicIpResourceId = vmPublicIp.id
var blobUri = 'https://${storageAccountName}.blob.core.windows.net'
var queueUri = 'https://${storageAccountName}.queue.core.windows.net'
var tableUri = 'https://${storageAccountName}.table.core.windows.net'
var privateStorageFileDnsZoneName = 'privatelink.file.${environment().suffixes.storage}'
var privateStorageBlobDnsZoneName = 'privatelink.blob.${environment().suffixes.storage}'
var privateStorageQueueDnsZoneName = 'privatelink.queue.${environment().suffixes.storage}'
var privateStorageTableDnsZoneName = 'privatelink.table.${environment().suffixes.storage}'
var privateEndpointFileStorageName = '${storageAccountName}-file-private-endpoint'
var privateEndpointBlobStorageName = '${storageAccountName}-blob-private-endpoint'
var privateEndpointQueueStorageName = '${storageAccountName}-queue-private-endpoint'
var privateEndpointTableStorageName = '${storageAccountName}-table-private-endpoint'
var virtualNetworkLinksSuffixFileStorageName = '${privateStorageFileDnsZoneName}-link'
var virtualNetworkLinksSuffixBlobStorageName = '${privateStorageBlobDnsZoneName}-link'
var virtualNetworkLinksSuffixQueueStorageName = '${privateStorageQueueDnsZoneName}-link'
var virtualNetworkLinksSuffixTableStorageName = '${privateStorageTableDnsZoneName}-link'
var vnetResourceId = virtualNetwork.id
var fileServerFqdn = '${vmName}.internal.cloudapp.net'


resource hostingPlan 'Microsoft.Web/serverfarms@2024-11-01' = {
  name: hostingPlanName
  location: location

  sku: {
    tier: 'WorkflowStandard'
    name: 'WS1'
  }

  properties: {
    maximumElasticWorkerCount: 20
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2020-07-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: logicAppSubnetName
        properties: {
          addressPrefix: logicAppSubnetPrefix
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          delegations: [
            {
              name: 'delegation'
              properties: {
                serviceName: 'Microsoft.Web/serverfarms'
              }
            }
          ]
        }
      }
      {
        name: storageSubnetName
        properties: {
          addressPrefix: storageSubnetPrefix
          privateLinkServiceNetworkPolicies: 'Enabled'
          privateEndpointNetworkPolicies: 'Disabled'
        }
      }
      {
        name: vmSubnetName
        properties: {
          addressPrefix: vmSubnetPrefix
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          networkSecurityGroup: {
            id: vmNsg.id
          }
        }
      }
    ]
  }
}

resource vmPublicIp 'Microsoft.Network/publicIPAddresses@2024-01-01' = {
  name: vmPublicIpName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource vmNsg 'Microsoft.Network/networkSecurityGroups@2024-01-01' = {
  name: vmNsgName
  location: location
  properties: {
    securityRules: [
      {
        name: 'Allow-RDP'
        properties: {
          priority: 100
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: vmSubnetPrefix
          destinationPortRange: '3389'
        }
      }
      {
        name: 'Allow-LogicApp-To-VM'
        properties: {
          priority: 101
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourceAddressPrefix: logicAppSubnetPrefix
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '443'
        }
      }
      {
        name: 'Allow-Bastion-To-VM'
        properties: {
          priority: 102
          direction: 'Inbound'
          access: 'Allow'
          protocol: '*'
          sourcePortRange: '*'
          sourceAddressPrefix: '168.63.129.16'
          destinationAddressPrefix: vmSubnetPrefix
          destinationPortRanges: [
            '22'
            '3389'
          ]
        }
      }
    ]
  }
}

resource vmNic 'Microsoft.Network/networkInterfaces@2024-01-01' = {
  name: vmNicName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: vmSubnetResourceId
          }
          publicIPAddress: {
            id: vmPublicIpResourceId
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: vmNsg.id
    }
  }
  dependsOn: [
    virtualNetwork
  ]
}

resource vm 'Microsoft.Compute/virtualMachines@2024-07-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-datacenter-azure-edition'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
    }
    osProfile: {
      computerName: vmName
      adminUsername: vmAdminUsername
      adminPassword: vmAdminPassword
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: vmNicResourceId
        }
      ]
    }
    securityProfile: {
      securityType: 'TrustedLaunch'
      uefiSettings: {
        secureBootEnabled: true
        vTpmEnabled: true
      }
    }
  }
}

resource shutdown_computevm_vm 'Microsoft.DevTestLab/schedules@2018-09-15' = if (enableAutoShutdown) {
  name: 'shutdown-computevm-${vmName}'
  location: location
  properties: {
    status: 'Enabled'
    taskType: 'ComputeVmShutdownTask'
    dailyRecurrence: {
      time: autoShutdownTime
    }
    timeZoneId: autoShutdownTimeZone
    notificationSettings: {
      status: (autoShutdownNotificationEnabled ? 'Enabled' : 'Disabled')
      timeInMinutes: autoShutdownNotificationMinutes
      notificationLocale: autoShutdownNotificationLocale
    }
    targetResourceId: vm.id
  }
}

resource bastion 'Microsoft.Network/bastionHosts@2025-07-01' = if (enableBastion) {
  name: bastionName
  location: location
  sku: {
    name: bastionSkuName
  }
  properties: {
    dnsName: '${bastionDnsName}.${location}.bastionglobal.azure.com'
    scaleUnits: 2
    virtualNetwork: {
      id: vnetResourceId
    }
  }
}

resource vmName_CreateFileShare 'Microsoft.Compute/virtualMachines/extensions@2024-03-01' = {
  parent: vm
  name: 'CreateFileShare'
  location: resourceGroup().location
  properties: {
    publisher: 'Microsoft.Compute'
    type: 'CustomScriptExtension'
    typeHandlerVersion: '1.10'
    autoUpgradeMinorVersion: true
    settings: {
      commandToExecute: 'powershell -ExecutionPolicy Bypass -Command "if (!(Test-Path \'C:\\${fileShareName}\')) { New-Item -Path \'C:\\${fileShareName}\' -ItemType Directory -Force }; if (!(Get-SmbShare -Name \'${fileShareName}\' -ErrorAction SilentlyContinue)) { New-SmbShare -Name \'${fileShareName}\' -Path \'C:\\${fileShareName}\' -FullAccess Everyone }; if (!(Test-Path \'C:\\${fileShareName}\\test.txt\')) { New-Item -Path \'C:\\${fileShareName}\\test.txt\' -ItemType File -Force }"'
    }
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
    defaultToOAuthAuthentication: true
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
    }
    publicNetworkAccess: 'Enabled'
  }
  dependsOn: [
    virtualNetwork
  ]
}

resource privateStorageFileDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: privateStorageFileDnsZoneName
  location: 'global'
  dependsOn: [
    virtualNetwork
  ]
}

resource privateStorageBlobDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: privateStorageBlobDnsZoneName
  location: 'global'
  dependsOn: [
    virtualNetwork
  ]
}

resource privateStorageQueueDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: privateStorageQueueDnsZoneName
  location: 'global'
  dependsOn: [
    virtualNetwork
  ]
}

resource privateStorageTableDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: privateStorageTableDnsZoneName
  location: 'global'
  dependsOn: [
    virtualNetwork
  ]
}

resource privateStorageFileDnsZoneName_virtualNetworkLinksSuffixFileStorage 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: privateStorageFileDnsZone
  name: virtualNetworkLinksSuffixFileStorageName
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetwork.id
    }
  }
}

resource privateStorageBlobDnsZoneName_virtualNetworkLinksSuffixBlobStorage 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: privateStorageBlobDnsZone
  name: virtualNetworkLinksSuffixBlobStorageName
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetwork.id
    }
  }
}

resource privateStorageQueueDnsZoneName_virtualNetworkLinksSuffixQueueStorage 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: privateStorageQueueDnsZone
  name: virtualNetworkLinksSuffixQueueStorageName
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetwork.id
    }
  }
}

resource privateStorageTableDnsZoneName_virtualNetworkLinksSuffixTableStorage 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: privateStorageTableDnsZone
  name: virtualNetworkLinksSuffixTableStorageName
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetwork.id
    }
  }
}

resource privateEndpointFileStorage 'Microsoft.Network/privateEndpoints@2020-06-01' = {
  name: privateEndpointFileStorageName
  location: location
  properties: {
    subnet: {
      id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName, storageSubnetName)
    }
    privateLinkServiceConnections: [
      {
        name: 'MyStorageFilePrivateLinkConnection'
        properties: {
          privateLinkServiceId: storageAccount.id
          groupIds: [
            'file'
          ]
        }
      }
    ]
  }
  dependsOn: [
    virtualNetwork
  ]
}

resource privateEndpointBlobStorage 'Microsoft.Network/privateEndpoints@2020-06-01' = {
  name: privateEndpointBlobStorageName
  location: location
  properties: {
    subnet: {
      id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName, storageSubnetName)
    }
    privateLinkServiceConnections: [
      {
        name: 'MyStorageBlobPrivateLinkConnection'
        properties: {
          privateLinkServiceId: storageAccount.id
          groupIds: [
            'blob'
          ]
        }
      }
    ]
  }
  dependsOn: [
    virtualNetwork
  ]
}

resource privateEndpointQueueStorage 'Microsoft.Network/privateEndpoints@2020-06-01' = {
  name: privateEndpointQueueStorageName
  location: location
  properties: {
    subnet: {
      id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName, storageSubnetName)
    }
    privateLinkServiceConnections: [
      {
        name: 'MyStorageQueuePrivateLinkConnection'
        properties: {
          privateLinkServiceId: storageAccount.id
          groupIds: [
            'queue'
          ]
        }
      }
    ]
  }
  dependsOn: [
    virtualNetwork
  ]
}

resource privateEndpointTableStorage 'Microsoft.Network/privateEndpoints@2020-06-01' = {
  name: privateEndpointTableStorageName
  location: location
  properties: {
    subnet: {
      id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName, storageSubnetName)
    }
    privateLinkServiceConnections: [
      {
        name: 'MyStorageTablePrivateLinkConnection'
        properties: {
          privateLinkServiceId: storageAccount.id
          groupIds: [
            'table'
          ]
        }
      }
    ]
  }
  dependsOn: [
    virtualNetwork
  ]
}

resource privateEndpointBlobStorageName_default 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-06-01' = {
  parent: privateEndpointBlobStorage
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'config1'
        properties: {
          privateDnsZoneId: privateStorageBlobDnsZone.id
        }
      }
    ]
  }
}

resource privateEndpointQueueStorageName_default 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-06-01' = {
  parent: privateEndpointQueueStorage
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'config1'
        properties: {
          privateDnsZoneId: privateStorageQueueDnsZone.id
        }
      }
    ]
  }
}

resource privateEndpointTableStorageName_default 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-06-01' = {
  parent: privateEndpointTableStorage
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'config1'
        properties: {
          privateDnsZoneId: privateStorageTableDnsZone.id
        }
      }
    ]
  }
}

resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: userAssignedIdentityName
  location: location
}

resource logicApp 'Microsoft.Web/sites@2025-03-01' = {
  name: logicAppName
  location: location
  kind: 'functionapp,workflowapp'
  identity: {
    type: 'SystemAssigned, UserAssigned'
    userAssignedIdentities: {
      '${uamiResourceId}': {}
    }
  }
  properties: {
    outboundVnetRouting: {
      allTraffic: false
      applicationTraffic: true
      contentShareTraffic: true
      imagePullTraffic: false
      backupRestoreTraffic: false
    }
    siteConfig: {
      appSettings: [
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'dotnet'
        }
        {
          name: 'WEBSITE_NODE_DEFAULT_VERSION'
          value: '~22'
        }
        {
          name: 'AzureWebJobsStorage__credential'
          value: 'managedidentity'
        }
        {
          name: 'AzureWebJobsStorage__blobServiceUri'
          value: blobUri
        }
        {
          name: 'AzureWebJobsStorage__queueServiceUri'
          value: queueUri
        }
        {
          name: 'AzureWebJobsStorage__tableServiceUri'
          value: tableUri
        }
        {
          name: 'AzureWebJobsStorage__managedIdentityResourceId'
          value: uamiResourceId
        }
        {
          name: 'AzureFunctionsJobHost__extensionBundle__id'
          value: 'Microsoft.Azure.Functions.ExtensionBundle.Workflows'
        }
        {
          name: 'AzureFunctionsJobHost__extensionBundle__version'
          value: '[1.*, 2.0.0)'
        }
        {
          name: 'APP_KIND'
          value: 'workflowApp'
        }
        {
          name: 'FUNCTIONS_INPROC_NET8_ENABLED'
          value: '1'
        }
        {
          name: 'LOGIC_APPS_POWERSHELL_VERSION'
          value: json('7.4')
        }
        {
          name: 'FileSystem_mountPath'
          value: 'C:\\mounts\\FileSystem'
        }
        {
          name: 'FileSystem_password'
          value: vmAdminPassword
        }
        {
          name: 'WEBSITE_CONTENTOVERVNET'
          value: '1'
        }
        {
          name: 'WEBSITE_VNET_ROUTE_ALL'
          value: '1'
        }
      ]
      cors: {}
      use32BitWorkerProcess: false
      ftpsState: 'FtpsOnly'
      vnetPrivatePortsCount: 2
      netFrameworkVersion: 'v8.0'
    }
    clientAffinityEnabled: false
    virtualNetworkSubnetId: subnetResourceId
    publicNetworkAccess: 'Enabled'
    httpsOnly: true
    serverFarmId: serverFarmResourceId
  }
  dependsOn: [
    storageAccount

    vm
    vmName_CreateFileShare
  ]
}


resource logicAppName_scm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2022-09-01' = {
  parent: logicApp
  name: 'scm'
  properties: {
    allow: false
  }
}

resource logicAppName_ftp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2022-09-01' = {
  parent: logicApp
  name: 'ftp'
  properties: {
    allow: false
  }
}

resource logicAppName_azureStorageAccounts 'Microsoft.Web/sites/config@2022-03-01' = {
  parent: logicApp
  name: 'azurestorageaccounts'
  properties: {
    'FileSystem-Share': {
      type: 'FileShare'
      accountName: vmAdminUsername
      endpoint: fileServerFqdn
      shareName: fileShareName
      accessKey: vmAdminPassword
      mountPath: '\\mounts\\FileSystem'
      protocol: 'Smb'
    }
  }
  dependsOn: [
    vmName_CreateFileShare
  ]
}


resource id_id_logicAppName_17d1049b_9a84_46fb_8f53_869881c3d3ab 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: storageAccount
  name: guid(subscription().id, resourceGroup().id, logicAppName, '17d1049b-9a84-46fb-8f53-869881c3d3ab')
  properties: {
    roleDefinitionId: subscriptionResourceId(
      'Microsoft.Authorization/roleDefinitions',
      '17d1049b-9a84-46fb-8f53-869881c3d3ab'
    )
    principalId: reference(uamiResourceId, '2018-11-30').principalId
    principalType: 'ServicePrincipal'
  }
}

resource id_id_logicAppName_b7e6dc6d_f1e8_4753_8033_0f276bb0955b 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: storageAccount
  name: guid(subscription().id, resourceGroup().id, logicAppName, 'b7e6dc6d-f1e8-4753-8033-0f276bb0955b')
  properties: {
    roleDefinitionId: subscriptionResourceId(
      'Microsoft.Authorization/roleDefinitions',
      'b7e6dc6d-f1e8-4753-8033-0f276bb0955b'
    )
    principalId: reference(uamiResourceId, '2018-11-30').principalId
    principalType: 'ServicePrincipal'
  }
}

resource id_id_logicAppName_974c5e8b_45b9_4653_ba55_5f855dd0fb88 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: storageAccount
  name: guid(subscription().id, resourceGroup().id, logicAppName, '974c5e8b-45b9-4653-ba55-5f855dd0fb88')
  properties: {
    roleDefinitionId: subscriptionResourceId(
      'Microsoft.Authorization/roleDefinitions',
      '974c5e8b-45b9-4653-ba55-5f855dd0fb88'
    )
    principalId: reference(uamiResourceId, '2018-11-30').principalId
    principalType: 'ServicePrincipal'
  }
}

resource id_id_logicAppName_0a9a7e1f_b9d0_4cc4_a60d_0319b160aaa3 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: storageAccount
  name: guid(subscription().id, resourceGroup().id, logicAppName, '0a9a7e1f-b9d0-4cc4-a60d-0319b160aaa3')
  properties: {
    roleDefinitionId: subscriptionResourceId(
      'Microsoft.Authorization/roleDefinitions',
      '0a9a7e1f-b9d0-4cc4-a60d-0319b160aaa3'
    )
    principalId: reference(uamiResourceId, '2018-11-30').principalId
    principalType: 'ServicePrincipal'
  }
}
