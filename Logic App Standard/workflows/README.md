This is a Workflow Zip Repository, where multiple wwwroot zip folders, containing varying number of workflow files. Useful if you want a fixed set of workflows deployed quickly to your app. 

All the workflows are idnetical and have just one trigger (When an HTTP request is received), with no actions.

The below CLI commands will deploy only add (or replace workflows with the same name) and touch no other files. So host.json, parameters.json, connections.json, or any other workflows or artifacts in your site's wwwroot repository will remain as is. This is controlled by the _--clean false_ parameter. 


1. Download the zip file with the desired number of workflows
2. On the Portal, open the Cloud Shell
3. Click on _Manage files_ > _Upload_ and select the zip file you just downloaded
4. Run the following commands and replace the bolded fields:

az account set --subscription **<name or id>**
az webapp deploy --resource-group **ResourceGroupName** --name **LogicAppName** --src-path **WorkflowsN**.zip --type=zip --clean false

 
