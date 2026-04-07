#!/bin/bash

# Get a portable implementation of FIPS202 from PQClean

# exit on error
set -e

# clean up
rm -rf PQCLean
rm -rf FIPS202

# clone PQClean
git clone https://github.com/PQClean/PQClean
cd PQClean
# clone before the FIPS202 implementation was
# transitioned to dynamic memory allocation
# https://github.com/PQClean/PQClean/pull/266
COMMIT="65a6a63^"
git checkout $COMMIT

# extract files
cd ..
mkdir FIPS202
mv PQClean/common/fips202* FIPS202/

# add "#pragma once" to all header files 
for file in FIPS202/*.h; do
    { echo "#pragma once"; echo; cat "$file"; } > temp && mv temp "$file"
done

# add import message to all files
for file in FIPS202/*; do
    { echo "/* Imported from PQClean commit $COMMIT */"; echo; cat "$file"; } > temp && mv temp "$file"
done

# clean up
rm -rf PQClean
cd ..

echo "# done"