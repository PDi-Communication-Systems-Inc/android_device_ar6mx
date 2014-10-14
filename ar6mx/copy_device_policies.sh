#!/bin/sh
src_path=/system/etc/
tgt_path=/data/system/
if [ ! -d ${tgt_path} ];
then
mkdir -p ${tgt_path}
fi

if [ ! -f ${tgt_path}/device_policies.xml ];
then
busybox cp ${src_path}/device_policies.xml ${tgt_path}/
busybox chown 1000:1000 ${tgt_path}/device_policies.xml
fi


