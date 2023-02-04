$rg = 'mayaResourceGroup'
New-AzResourceGroup -Name $rg -Location northeurope -Force

New-AzResourceGroupDeployment `
    -Name 'storage-linux' `
    -ResourceGroupName $rg `
    -TemplateFile 'storageTemplate.json' 
