**About**
This is a Workflow Zip Repository, with multiple zip folders, containing pre-templatized workflow artifacts zip files. This mimics the wwwroot directory in your Logic App Standard project's directory: **site/wwwroot**. The below CLI commands will deploy only add or replace the files in the zip folder on your Logic App's directory. Any file that is _not_ in the zip folder will remain as is. This is controlled by the _--clean false_ parameter. 

**Type of Zip files**
1. Workflow**N**.zip
All the workflows are identical and have just one trigger (When an HTTP request is received), with no actions. The N is for whichever number of workflows you want to deploy quickly.

2. Scenario**N**File**N**Workflows.zip
This corresponds to the workflows required to complete the end-to-end set up for the scenario-based ARM templates. 

---

**Instructions**

1. Download the zip file with the desired number of workflows
2. On the Portal, open the Cloud Shell
3. Click on _Manage files_ > _Upload_ and select the zip file you just downloaded
4. Run the following commands and replace the bolded fields:

az account set --subscription **Subscription Name or ID**

az webapp deploy --resource-group **ResourceGroupName** --name **LogicAppName** --src-path **WorkflowsN**.zip --type=zip --clean false

 
