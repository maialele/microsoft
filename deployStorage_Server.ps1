
$resourceGroupName = "mayaResourceGroup"
$location = "francecentral"
$templateFile = "storageTemplate.json"

# Create resource group
New-AzResourceGroup -Name $resourceGroupName -Location $location

# Deploy template
New-AzDeployment -Name "deploy-storage-accounts" `
                 -ResourceGroupName $resourceGroupName `
                 -TemplateFile $templateFile `
