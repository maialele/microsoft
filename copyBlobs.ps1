# Login to azure
az login

# Set the subscription
az account set --subscription $SUBSCRIPTION_ID

# Set Variables
storageAccount1="mayastorage001"
container1="mayacontainer001"
storageAccount2="mayastorage002"
container2="mayacontainer002"


# Create a container A
az storage container create \
    --name $container1 \
    --account-name $storageAccount1
    --auth-mode login

# Create a container B
az storage container create \
    --name $container2 \
    --account-name $storageAccount2
    --auth-mode login

# Create 100 blobs in Storage Account A
for ($i=1; $i -le 100; $i++) {
    "Sample Data" | Out-File -FilePath "sample_data_$i.txt"
    az storage blob upload `
        --account-name $storageAccount1 `
        --container-name $container1 `
        --type block `
        --name "sample_data_$i.txt" `
        --file "sample_data_$i.txt"
}

# Copy the blobs from Storage Account A to Storage Account B
azcopy login
for ($i=1; $i -le 100; $i++) {
    azcopy copy "https://$storageAccount1.blob.core.windows.net/$container1/sample_data_$i.txt" `
        "https://$storageAccount2.blob.core.windows.net/$container2/sample_data_$i.txt"
}
