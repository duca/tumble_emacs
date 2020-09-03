#!/bin/bash

# set -e
source /home/dev/.bashrc

cd /home/dev/emacs;
git pull
mkdir build;
./autogen.sh;
cd build;
../configure --with-modules --with-threads --with-x-toolkit=lucid --enable-link-time-optimization --without-makeinfo CFLAGS="-O3 -funroll-all-loops -ftree-vectorize";
make -j4 all
