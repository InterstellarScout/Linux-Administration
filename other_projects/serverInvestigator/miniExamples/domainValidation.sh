#!/bin/bash
#Usage bash domainValidation.sh {domain}
host $1 2>&1 > /dev/null
    if [ $? -eq 0 ]
    then
        echo "$h is a FQDN"
    else
        echo "$h is not a FQDN"
    fi