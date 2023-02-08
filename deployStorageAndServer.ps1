
$resourceGroupName = "mayaResourceGroup"
$location = "francecentral"
$templateFile = "storageTemplate.json"


# Deploy storage
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile $templateFile

$templateFile = "windowsTemplate.json"
# Deploy windows server
$adminUsername = "maya"
$adminPassword = $SERVER_PASSWORD
$dnsLabelPrefix = "mayawinserver01"

New-AzResourceGroup -Name $resourceGroupName -Location "$location"
New-AzResourceGroupDeployment `
    -ResourceGroupName $resourceGroupName `
    -TemplateUri "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/quickstarts/microsoft.compute/vm-simple-windows/azuredeploy.json" `
    -adminUsername $adminUsername `
    -adminPassword $adminPassword `
    -dnsLabelPrefix $dnsLabelPrefix
