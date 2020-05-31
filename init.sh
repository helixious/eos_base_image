#!/bin/bash

if [[ "$EOS_VERSION" = "" || "$EOS_VERSION" = "latest" ]]; then
    echo "no EOS_VERSION specified, using default: 'latest'"
    eos_url=$(curl -s https://api.github.com/repos/EOSIO/eos/releases/latest | grep "browser_download_url.*rpm" | cut -d '"' -f 4)
    eos_filename=$(/usr/bin/curl -s https://api.github.com/repos/EOSIO/eos/releases/latest | grep "name.*rpm" | cut -d '"' -f 4)
else
    eos_url=$(curl -s https://api.github.com/repos/EOSIO/eos/releases/tags/$EOS_VERSION | grep "browser_download_url.*rpm" | cut -d '"' -f 4)
    eos_filename=$(/usr/bin/curl -s https://api.github.com/repos/EOSIO/eos/releases/tags/$EOS_VERSION | grep "name.*rpm" | cut -d '"' -f 4)
fi

if [[ "$CDT_VERSION" = "" || "$CDT_VERSION" = "latest" ]]; then
    echo "no CDT_VERSION specified, using default: 'latest'"
    cdt_url=$(/usr/bin/curl -s https://api.github.com/repos/EOSIO/eosio.cdt/releases/latest | grep "browser_download_url.*rpm" | cut -d '"' -f 4)
    cdt_filename=$(/usr/bin/curl -s https://api.github.com/repos/EOSIO/eosio.cdt/releases/latest | grep "name.*rpm" | cut -d '"' -f 4)
else
    cdt_url=$(/usr/bin/curl -s https://api.github.com/repos/EOSIO/eosio.cdt/releases/tags/$CDT_VERSION | grep "browser_download_url.*rpm" | cut -d '"' -f 4)
    cdt_filename=$(/usr/bin/curl -s https://api.github.com/repos/EOSIO/eosio.cdt/releases/tags/$CDT_VERSION | grep "name.*rpm" | cut -d '"' -f 4)
fi

rm -rf "$eos_filename" && wget $eos_url && yum install -y $eos_filename && rm -rf "$eos_filename"
rm -rf "$cdt_filename" && wget $cdt_url && yum install -y $cdt_filename && rm -rf "$cdt_filename"

cd /contracts

if [[ "$CONTRACT_VERSION" = "" || "$CONTRACT_VERSION" = "latest" ]]; then
    echo "no CONTRACT_VERSION specified, using default: 'latest'"
    git clone https://github.com/EOSIO/eosio.contracts.git
else
    git clone -b $CONTRACT_VERSION https://github.com/EOSIO/eosio.contracts.git
fi

cd /contracts/eosio.contracts
./build.sh -y

mkdir -p /contracts/eosio
cp /contracts/eosio.contracts/build/contracts/. /contracts/eosio -a
rm -rf /contracts/eosio.contracts/