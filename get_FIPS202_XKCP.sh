#!/bin/bash

# Get a portable implementation of FIPS202 from the eXtended Keccak Code Package

# exit on error
set -e

# clean up
rm -rf XKCP
rm -rf FIPS202

# clone XKCP
git clone https://github.com/XKCP/XKCP
cd XKCP
# git checkout 716f007 # march 2026
git submodule update --init

# add build option
file="doc/HOWTO-customize.build"
newline='    <target name="FIPS202-compact" inherits="FIPS202 K1600-compact"/>'
lines=$(wc -l < "$file")
insert_line=$((lines - 1))
awk -v n="$insert_line" -v l="$newline" 'NR==n{print l}1' "$file" > "$file.tmp" && mv "$file.tmp" "$file"

# generate files
rm -rf ./bin
# make FIPS202-compact.pack
make FIPS202-opt64.pack # optimized

# extract them
cd ..
mkdir FIPS202
# mv XKCP/bin/.pack/FIPS202-compact/* FIPS202
mv XKCP/bin/.pack/FIPS202-opt64/* FIPS202 # optimized

# remove unnecessary files
rm -rf FIPS202/SnP-implementations.c
rm -rf FIPS202/SnP-implementations.h

# add "#pragma once" to all header files
for file in FIPS202/*.h; do
    { echo "#pragma once"; echo; cat "$file"; } > temp && mv temp "$file"
done

# remove reference to PlSnP-common.h
sed -i '/#include "PlSnP-common.h"/d' FIPS202/SnP-implementations.c

# clean up
rm -rf XKCP
cd ..

echo "# done"