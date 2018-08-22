#!/bin/bash
OUT_NICE_0=./log_nice_0.log
OUT_NICE_19=./log_nice_19.log

OUT_IONICE_0=./log_ionice_0.log
OUT_IONICE_7=./log_ionice_7.log

nice -n 0 ./test_cpu.sh > ${OUT_NICE_0} 2>&1 &
nice -n 19 ./test_cpu.sh > ${OUT_NICE_19} 2>&1 &

ionice -c2 -n 0 ./test_io.sh > ${OUT_IONICE_0} 2>&1 &
ionice -c2 -n 7 ./test_io1.sh > ${OUT_IONICE_7} 2>&1 &
