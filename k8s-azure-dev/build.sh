#!/usr/bin/env bash

# Load vars file if it exists
if [[ -f "vars.sh" ]]; then source vars.sh; fi

# Make sure the required programs are installed
REQUIRED_PROGRAMS=(az ansible)
for PROGRAM in "${REQUIRED_PROGRAMS[@]}"; do
    command -v ${PROGRAM} > /dev/null 2>&1
    if [ $? -ne 0 ]; then
      echo "${PROGRAM} doesn't appear to be installed."
      exit 1
    fi
done

# Login to Azure
az login \
  --username ${AZURE_USERNAME} \
  --password ${AZURE_PASSWORD}


# Create n Ubuntu VMs and wait for them to be up
for VM in $(seq 1 ${TOTAL_VMS}); do
    az vm create \
    --resource-group ${AZURE_RG} \
    --name ${VM_BASENAME}${VM} \
    --image UbuntuLTS \
    --admin-username ${VM_ADMIN} \
    --generate-ssh-keys

# Call Ansible script on master

# Call Ansible script on nodes

