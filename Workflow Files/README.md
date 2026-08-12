**About**

This is a Workflow Zip Repository, with multiple zip folders, containing pre-templatized workflow artifacts zip files. This mimics the wwwroot directory in your Logic App Standard project's directory: **site/wwwroot**. 

As a general note, the below CLI commands will only add (or replace files with the same name) the files in the zip folder on your Logic App's directory. Any file that is _not_ in the zip folder will remain as is. This is controlled by the _--clean false_ parameter. 

(Since the Logic App resource is getting created as part of this lab, the Logic App will not have any pre-existing files at the time of running this command.)

**Type of Zip files**
1. Workflow**N**.zip
All the workflows are identical and have just one trigger (When an HTTP request is received), with no actions. The N is for whichever number of workflows you want to deploy quickly. Useful for scenarios where you need to deploy many workflows to an app.

2. **scenario**Workflows.zip
This corresponds to the workflows required to complete the end-to-end set up for the scenario-based templates. 

---

**Instructions**

1. Download the appropriate zip file for your scenario
2. On the Azure Portal, open the Cloud Shell
3. Click on _Manage files_ > _Upload_ and select the zip file you just downloaded
4. Run the following commands and replace the bolded fields:

```bash
az account set --subscription SUBSCRIPTION-NAME-OR-ID
az webapp deploy --resource-group RESOURCE-GROUP-NAME --name LOGIC-APP-NAME --src-path FILE-NAME.zip --type=zip --clean false
```

