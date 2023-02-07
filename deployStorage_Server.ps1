
$resourceGroupName = "mayaResourceGroup"
$location = "francecentral"
$templateFile = "storageTemplate.json"

# Deploy storage
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile $templateFile

$templateFile = "linuxTemplate.json"
# Deploy linux server
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile $templateFile
