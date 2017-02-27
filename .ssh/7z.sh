#!/bin/bash
# leehom Chen clh021@gmail.com
prefix=$(date +%Y%m%d_%H%M%S)
for args in $@
do
    echo "$(date +%Y-%m-%d_%H:%M:%S) $args"
    7za a $prefix.$args.7z $args -pSECRET
done
# mytar folder1 [folder2 [folder3 ...]]

批量解压缩
#find . -name "*.js" -exec 7z -pSECRET a {}.7z {} \;
#find . -name "*.js.7z" -exec 7z -pSECRET x {} \;
