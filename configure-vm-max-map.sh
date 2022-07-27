#!/bin/bash
count='262144'
targetFile='/etc/sysctl.conf'
vmMaxMapCount='vm.max_map_count'
if [[ $(grep -r $targetFile -e $vmMaxMapCount | cut -d '=' -f 1 | xargs) != $vmMaxMapCount ]];
then
    echo "$vmMaxMapCount=$count" >> $targetFile
    echo "'$vmMaxMapCount=$count' added in '$targetFile'"
else
    max=$(grep -r $targetFile -e $vmMaxMapCount | cut -d '=' -f 2 | xargs)
    if [[ $max != $count ]];
    then
        sed -i "s/$max/$count/" $targetFile
        echo "'$vmMaxMapCount' modified in '$targetFile'"
    fi
fi