#!/bin/bash
d=`cat def/meta.def | awk -F, '{printf "\x27%s\x27,\x27%s\x27,\x27%s\x27",$1,$2,$3}'`
cat def/disable_const1.def > sql/disable_const.sql
echo "         $d" >> sql/disable_const.sql
cat def/disable_const2.def >> sql/disable_const.sql
echo "         $d" >> sql/disable_const.sql
cat def/disable_const3.def >> sql/disable_const.sql

cat def/enable_const1.def > sql/enable_const.sql
echo "         $d" >> sql/enable_const.sql
cat def/enable_const2.def >> sql/enable_const.sql
echo "         $d" >> sql/enable_const.sql
cat def/enable_const3.def >> sql/enable_const.sql
