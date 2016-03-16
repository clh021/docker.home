#!/bin/bash
# leehom Chen clh021@gmail.com
prefix=$(date +%Y%m%d_%H%M%S)
for args in $@
do
    echo "$(date +%Y-%m-%d_%H:%M:%S) $args"
    7za a $prefix.$args.7z $args -pSECRET
done
# mytar folder1 [folder2 [folder3 ...]]