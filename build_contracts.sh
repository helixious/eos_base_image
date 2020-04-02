#!/bin/bash

if [ ! -d /contracts ]; then
    mkdir -p /contracts;
fi

cdt=$(/usr/bin/curl -s https://api.github.com/repos/EOSIO/eosio.cdt/releases/tags/v1.6.3 | grep "browser_download_url.*deb" | cut -d '"' -f 4)
cdt_filename=$(/usr/bin/curl -s https://api.github.com/repos/EOSIO/eosio.cdt/releases/tags/v1.6.3 | grep "name.*deb" | cut -d '"' -f 4)
/usr/bin/wget $cdt && /usr/bin/dpkg -i "$cdt_filename" && rm -f "$cdt_filename"

cd /
git clone -b release/1.8.x https://github.com/EOSIO/eosio.contracts.git
cd /eosio.contracts
./build.sh -y
cp /eosio.contracts/build/contracts/. /contracts/1.8 -a
rm -rf /eosio.contracts
apt remove eosio.cdt -y

cd /
cdt=$(/usr/bin/curl -s https://api.github.com/repos/EOSIO/eosio.cdt/releases/latest | grep "browser_download_url.*deb" | cut -d '"' -f 4)
cdt_filename=$(/usr/bin/curl -s https://api.github.com/repos/EOSIO/eosio.cdt/releases/latest | grep "name.*deb" | cut -d '"' -f 4)
/usr/bin/wget $cdt && /usr/bin/dpkg -i "$cdt_filename" && rm -f "$cdt_filename"

cd /
git clone https://github.com/EOSIO/eosio.contracts.git
cd eosio.contracts
./build.sh -y
cp /eosio.contracts/build/contracts/. /contracts/latest -a
rm -rf /eosio.contracts
