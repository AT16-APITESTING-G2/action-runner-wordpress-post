#!/bin/bash

echo "Start Verification"
serviceName="actions.runner.AT16-APITESTING-G2.$3.service"
package=actions-runner-linux-x64-$5.tar.gz


if systemctl --all --type service | grep -q "$serviceName"; then
    echo "There is already this Service: $serviceName."
else
    echo "$serviceName does NOT exist."
    Dir=~/actions-runner
    if [ ! -d "$Dir" ]; then
        mkdir ~/actions-runner
    fi
    cd ~/actions-runner
    if [ ! -e "$package" ] ; then
        echo "Does not exist File"
        curl -o $package -L https://github.com/actions/runner/releases/download/v$5/$package
        echo "$6  $package" | shasum -a 256 -c
        tar xzf ./$package
    fi
    echo "Exist File"
    ./config.sh --unattended --url $1 --token $2 --name $3 --labels $4
    echo "Start install Service $serviceName"
    sudo ./svc.sh install
    sudo ./svc.sh start
fi
