#!/bin/sh

PATH=/bin:/sbin:/usr/bin:/usr/sbin
export PATH

INSTALLER_SCRIPT="%%INSTALLER_URL%%"

if [ -n "${INSTALLER_SCRIPT}" ]
then
    INSTALLER_HOST=$(echo "${INSTALLER_SCRIPT}" | awk -F / '{ sub(/.+@/, "", $3); sub(/:.+/, "", $3);  print $3}')
    
    echo -n "Waiting for network to come up..."
    if ping -q -o -c 100 ${INSTALLER_HOST} > /dev/null 2>/dev/null
    then 
    
        if fetch -o /tmp/install.sh ${INSTALLER_SCRIPT}
        then
            cd /tmp
            sh /tmp/install.sh
        else
            echo "ERROR: Failed to fetch ${INSTALLER_SCRIPT}!"
        fi
    
    else
        echo "failed"
    fi
fi

/bin/sh
