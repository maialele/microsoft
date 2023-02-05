#!/bin/bash
#create
storageAccount="mayastorage01"
containerName="container_A"

# Create a container object
az storage container create \
    --name $containerName \
    --account-name $storageAccount
    --auth-mode login

#upload
az storage blob upload \
    --account-name <storage-account> \
    --container-name <container> \
    --name myFile.txt \
    --file myFile.txt \
    --auth-mode login
#copy
azcopy copy 'https://<source-storage-account-name>.blob.core.windows.net/<container-name>/<blob-path>' \
'https://<destination-storage-account-name>.blob.core.windows.net/<container-name>/<blob-path>'


#login to azure
az login

# Step 2: Set the subscription
az account set --subscription "a8108c2b-496c-424d-8347-ecc8afb6384c"

#create container B
storageAccount="storagemaya02"
containerName="mayacontainer_B"

# Create a container object
az storage container create \
    --name $containerName \
    --account-name $storageAccount
    --auth-mode login

# Step 3: Create 100 blobs in Storage Account A
for i in {1..100}; do 
  echo "Sample Data" > sample_data_$i.txt
  az storage blob upload \
  --account-name storagemaya01 \
  --account-key sstoragemaya01_key \
  --container-name mayacontainer_A \
  --type block --name sample_data_$i.txt \
  --file sample_data_$i.txt
done

# Step 4: Copy the blobs from Storage Account A to Storage Account B
for i in {1..100}; do 
  az storage blob copy start-batch \
  --destination-container container_B \
  --destination-path sample_data_$i.txt \
  --source-container container_A \
  --source-account-name storagemaya01 \
  --source-account-key storagemaya01_key
done
