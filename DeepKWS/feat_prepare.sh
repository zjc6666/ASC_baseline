#!/bin/bash
# Copyright 2020 Audio, Speech and Language Processing Group (ASLP@NPU), Northwestern Polytechnical University \
# (Authors: Zhanheng Yang)
data_dir=$1
prepare_pwd=$2

echo "start prepare"
echo $data_dir
echo $prepare_pwd

find $data_dir -name '*.npy' -print | xargs echo "" > $prepare_pwd/feat.scp.temp
OLD_IFS="$IFS"
IFS=" "
cat $prepare_pwd/feat.scp.temp | while read line
do
arr=($line);
IFS="$OLD_IFS"
for s in ${arr[@]};
do
        name=${s##*/}
        echo ${name%.*} ${s} >> $prepare_pwd/feat.scp_temp2;
done
done
rm $prepare_pwd/feat.scp.temp

sort -k 1 $prepare_pwd/feat.scp_temp2 > $prepare_pwd/feats.scp
rm $prepare_pwd/feat.scp_temp2
