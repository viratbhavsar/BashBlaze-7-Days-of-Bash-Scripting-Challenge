#!/bin/bash

function remote_execute() {
    local host=$1
    local command=$2
    ssh ubuntu@$host "$command"
}

echo "Executing commands on client $1:"
remote_execute $1 $2 "hostname && uptime && df -h"