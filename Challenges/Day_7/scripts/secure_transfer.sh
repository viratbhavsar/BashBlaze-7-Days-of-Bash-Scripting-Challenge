#!/bin/bash

function secure_transfer() {
    local source=$1
    local destination=$2
    scp $source ubuntu@$destination
}

echo "Transferring file to client1:"
secure_transfer $1 $2