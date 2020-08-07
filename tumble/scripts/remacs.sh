set -e
source $HOME/.cargo/env
./autogen.sh
./configure --with-modules --without-makeinfo --with-x-toolkit=gtk --enable-link-time-optimization --with-threads LIBCLANG_PATH=/opt/rh/llvm-toolset-7/root/lib64/
make LIBCLANG_PATH=/opt/rh/llvm-toolset-7/root/lib64/
make install


