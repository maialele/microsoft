#!/bin/bash
# login to azure
az login

# Set the subscription
az account set --subscription "a8108c2b-496c-424d-8347-ecc8afb6384c"

#create container A
storageAccount="mayastorage01"
containerName="maya_container_A"

# Create a container object
az storage container create \
    --name $containerName \
    --account-name $storageAccount
    --auth-mode login

#create container B
storageAccount="storagemaya02"
containerName="maya_container_B"

# Create a container object
az storage container create \
    --name $containerName \
    --account-name $storageAccount
    --auth-mode login

# Create 100 blobs in Storage Account A
for i in {1..100}; do 
  echo "Sample Data" > sample_data_$i.txt
  az storage blob upload \
  --account-name storagemaya01 \
  --account-key storagemaya01_key \
  --container-name mayacontainer_A \
  --type block --name sample_data_$i.txt \
  --file sample_data_$i.txt
done

# Copy the blobs from Storage Account A to Storage Account B
for i in {1..100}; do 
  az storage blob copy start-batch \
  --destination-container container_B \
  --destination-path sample_data_$i.txt \
  --source-container container_A \
  --source-account-name storagemaya01 \
  --source-account-key storagemaya01_key
done
