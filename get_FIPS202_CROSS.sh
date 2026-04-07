#!/bin/bash

# Get a portable implementation of FIPS202 from Codes and Restricted Objects Signature Scheme

# exit on error
set -e

# clean up
rm -rf CROSS-implementation
rm -rf FIPS202

# clone CROSS
git clone https://github.com/CROSS-signature/CROSS-implementation
cd CROSS-implementation
# git checkout fc6b7e7 # march 2026

# extract files
cd ..
mkdir FIPS202
mv CROSS-implementation/Reference_Implementation/include/fips202* FIPS202
mv CROSS-implementation/Reference_Implementation/include/keccak* FIPS202
mv CROSS-implementation/Reference_Implementation/lib/fips202* FIPS202
mv CROSS-implementation/Reference_Implementation/lib/keccak* FIPS202

# clean up
rm -rf CROSS-implementation
cd ..

echo "# done"