set -e 
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup.sh
chmod +x rustup.sh
./rustup.sh --default-toolchain nightly-2020-01-08 -q -y
source $HOME/.cargo/env
