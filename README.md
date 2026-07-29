# Introduction
A collection of deployment templates for common testing, validation, and repro scenarios across various Azure services.

# Quick Guide for Deployment Options

## ARM

**Option 1**: Directly deploy the template by clicking the Deploy to Azure button
**Option 2**: In the Azure Portal, search for "Deploy a custom template", and paste the desired template file contents in the editor.

## Bicep

# What's In This Repository?

# Template Scenarios
Below are the templates that are created for various scenarios, categorized by the Logic App resource type. Some templates will deploy non-Logic App resources to help with end-to-end testing.

## Logic App Standard

## Logic App Consumption

# Scenario 1: Logic App Consumption connected to a Logic App Custom Connector

**Scenario1File1.json**

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkaly-d%2FInternalARMTemplates%2Frefs%2Fheads%2Fmain%2FARM%2FLogic%2520App%2520Consumption%2FScenario1File1.json)

<details>
  <summary>What this does/deploys</summary>
  
What this does/deploys:
  - Logic App Custom Connector with 2 actions (1 GET, 1 POST) to invoke Public Endpoint API for testing
  - API Connection to Logic App Custom Connector
  - Logic App Consumption configured with both to invoke Public Endpoint

</details>

<details>
  <summary>View detailed steps here</summary>
  
**Step 1:** Generate unique URL
1. Navigate to this URL to generate a custom endpoint **webhook.site**
2. Your unique URL will look something like: https://webhook.site/abcdefgh-ijkl-mnop-qrst-uvwxyzabcdef.
3. Make a note of the **basePath** which is the '**/**' and '**ID**' from your URL. For example: **/abcdefgh-ijkl-mnop-qrst-uvwxyzabcdef**

**Step 2:** Deploy the above template

⚠️ In the **basePath** parameter, replace the basePath with the value you stored from Step 1.

</details>

***
