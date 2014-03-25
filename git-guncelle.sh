#!/bin/bash
# git depolarını Güncelleyen Betik
# 21 - Mart - 2014
# Caylak Penguen
cd $HOME
cd git
ls -1
for i in `ls -1`
do
echo "$i"
cd $i
git fetch
cd ..
done

