$rg = 'mayaResourceGroup'
New-AzResourceGroup -Name $rg -Location northeurope -Force

New-AzResourceGroupDeployment `
    -Name 'storage' `
    -ResourceGroupName $rg `
    -TemplateFile 'storageTemplate.json' 
    
New-AzResourceGroupDeployment `
    -Name 'linux servier' `
    -ResourceGroupName $rg `
    -TemplateFile 'linuxTemplate.json' 

