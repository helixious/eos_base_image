#!/bin/bash

if [ "$1" = "" ]; then
	echo "In order to continue, you must specify either latest or the release version for cdt."
	exit 1
elif [ "$1" = "latest" ]; then
	cdt=$(/usr/bin/curl -s https://api.github.com/repos/EOSIO/eosio.cdt/releases/latest | grep "browser_download_url.*rpm" | cut -d '"' -f 4)
	cdt_filename=$(/usr/bin/curl -s https://api.github.com/repos/EOSIO/eosio.cdt/releases/latest | grep "name.*rpm" | cut -d '"' -f 4)

else
	cdt=$(/usr/bin/curl -s https://api.github.com/repos/EOSIO/eosio.cdt/releases/tags/$1 | grep "browser_download_url.*rpm" | cut -d '"' -f 4)
	cdt_filename=$(/usr/bin/curl -s https://api.github.com/repos/EOSIO/eosio.cdt/releases/tags/$1 | grep "name.*rpm" | cut -d '"' -f 4)

fi

if [ "$2" = "" ]; then
	echo "In order to continue, you must specify either latest or the release version for eosio."
	exit 1
elif [ "$2" = "latest" ]; then
	eos=$(curl -s https://api.github.com/repos/EOSIO/eos/releases/latest | grep "browser_download_url.*rpm" | cut -d '"' -f 4)
    eos_filename=$(/usr/bin/curl -s https://api.github.com/repos/EOSIO/eos/releases/latest | grep "name.*rpm" | cut -d '"' -f 4)
else 
    eos=$(curl -s https://api.github.com/repos/EOSIO/eos/releases/tags/$2 | grep "browser_download_url.*rpm" | cut -d '"' -f 4)
    eos_filename=$(/usr/bin/curl -s https://api.github.com/repos/EOSIO/eos/releases/tags/$2 | grep "name.*rpm" | cut -d '"' -f 4)
fi

if [ "$3" = "" ]; then
	echo "In order to continue, you must specify either latest or the release version for contracts."
	exit 1
fi


if [ "$cdt" = "" ]; then
	echo "Either $1 is not a valid release, or there is not a published .deb package for the cdt release."
	exit 1
fi

if [ "$eos" = "" ]; then
	echo "Either $2 is not a valid release, or there is not a published .deb package for the eos release."
	exit 1
else
	contract_release="$3"
fi

wget $eos && yum install -y $eos_filename && rm -rf "$eos_filename"
wget $cdt && yum install -y $cdt_filename && rm -rf "$cdt_filename"
# /usr/bin/wget $eos && /usr/bin/dpkg -i "$eos_filename" && rm -f "$eos_filename"
# /usr/bin/wget $cdt && /usr/bin/dpkg -i "$cdt_filename" && rm -f "$cdt_filename"

# sleep 10

cd /contracts
git clone -b $contract_release https://github.com/EOSIO/eosio.contracts.git
cd ./eosio.contracts
sleep 10
./build.sh -y

mkdir /contracts/eosio
cp /eosio.contracts/build/contracts/. /contracts/eosio -a
rm -rf /eosio.contracts-1.8.x/

