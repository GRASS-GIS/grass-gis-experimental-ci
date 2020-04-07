#!/usr/bin/env bash

# The make step requires something like:
# export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$PREFIX/lib"
# further steps additionally require:
# export PATH="$PATH:$PREFIX/bin"

# fail on non-zero return code from a subprocess
set -e

export INSTALL_PREFIX=$1

# GRASS GIS

git clone https://github.com/OSGeo/grass.git --branch master --depth=1

cd grass

for FILE in `find ../patches -name '*.patch'`
do
    echo "Applying patch $FILE"
    patch -p0 < $FILE
done

bash configure.sh
make GDAL_DYNAMIC=
make install
