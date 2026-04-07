#!/bin/bash

set -e

COPT="\
-march=native \
-O3 \
"

rm -f main.o

for dir in FIPS202*; do
    gcc main.c ${COPT} $dir/*.c -I$dir -o main.o -lcpucycles
    taskset --cpu-list 0 ./main.o
    echo $dir
done
