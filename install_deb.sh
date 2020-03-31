#!/bin/bash

if [ "$1" = "" ]; then
	echo "In order to continue, you must specify either latest or the release version for cdt."
	exit 1
elif [ "$1" = "latest" ]; then
	cdt=$(/usr/bin/curl -s https://api.github.com/repos/EOSIO/eosio.cdt/releases/latest | grep "browser_download_url.*deb" | cut -d '"' -f 4)
	cdt_filename=$(/usr/bin/curl -s https://api.github.com/repos/EOSIO/eosio.cdt/releases/latest | grep "name.*deb" | cut -d '"' -f 4)

else
	cdt=$(/usr/bin/curl -s https://api.github.com/repos/EOSIO/eosio.cdt/releases/tags/$1 | grep "browser_download_url.*deb" | cut -d '"' -f 4)
	cdt_filename=$(/usr/bin/curl -s https://api.github.com/repos/EOSIO/eosio.cdt/releases/tags/$1 | grep "name.*deb" | cut -d '"' -f 4)

fi

if [ "$2" = "" ]; then
	echo "In order to continue, you must specify either latest or the release version for eosio."
	exit 1
elif [ "$2" = "latest" ]; then
	eos=$(curl -s https://api.github.com/repos/EOSIO/eos/releases/latest | grep "browser_download_url.*18.04" | cut -d '"' -f 4)
    eos_filename=$(/usr/bin/curl -s https://api.github.com/repos/EOSIO/eos/releases/latest | grep "name.*18.04" | cut -d '"' -f 4)
else 
    eos=$(curl -s https://api.github.com/repos/EOSIO/eos/releases/$2 | grep "browser_download_url.*18.04" | cut -d '"' -f 4)
    eos_filename=$(/usr/bin/curl -s https://api.github.com/repos/EOSIO/eos/releases/$2 | grep "name.*18.04" | cut -d '"' -f 4)
fi

if [ "$cdt" = "" ]; then
	echo "Either $1 is not a valid release, or there is not a published .deb package for the cdt release."
	exit 1
fi

if [ "$eos" = "" ]; then
	echo "Either $2 is not a valid release, or there is not a published .deb package for the eos release."
	exit 1
fi

/usr/bin/wget $eos && /usr/bin/dpkg -i "$eos_filename" && rm -f "$eos_filename"
/usr/bin/wget $cdt && /usr/bin/dpkg -i "$cdt_filename" && rm -f "$cdt_filename"