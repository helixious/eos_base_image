#!/bin/bash
cd /
# basedir=$(dirname "$BASH_SOURCE")

if [ ! -d /contracts ]; then
    mkdir -p /contracts;
fi

cdt_version=v1.6.3
contract_version=release/1.8.x
cdt_url=$(/usr/bin/curl -s https://api.github.com/repos/EOSIO/eosio.cdt/releases/tags/$cdt_version | grep "browser_download_url.*rpm" | cut -d '"' -f 4)
cdt_filename=$(/usr/bin/curl -s https://api.github.com/repos/EOSIO/eosio.cdt/releases/tags/$cdt_version | grep "name.*rpm" | cut -d '"' -f 4)
wget $cdt_url && yum install -y $cdt_filename && rm -rf "$cdt_filename"

cd /
git clone -b "$contract_version" https://github.com/EOSIO/eosio.contracts.git
cd /eosio.contracts
./build.sh -y
cp /eosio.contracts/build/contracts/. /contracts/eosio_1.8 -a
rm -rf /eosio.contracts
# apt remove eosio.cdt -y

cd /
cdt_url=$(/usr/bin/curl -s https://api.github.com/repos/EOSIO/eosio.cdt/releases/latest | grep "browser_download_url.*rpm" | cut -d '"' -f 4)
cdt_filename=$(/usr/bin/curl -s https://api.github.com/repos/EOSIO/eosio.cdt/releases/latest | grep "name.*rpm" | cut -d '"' -f 4)
wget $cdt_url && yum install -y $cdt_filename && rm -rf "$cdt_filename"


cd /
git clone https://github.com/EOSIO/eosio.contracts.git
cd /eosio.contracts
rm -rf build
./build.sh -y
cp /eosio.contracts/build/contracts/. /contracts/eosio_latest -a
rm -rf /eosio.contracts
