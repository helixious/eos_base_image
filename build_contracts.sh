#!/bin/bash
installPath=$PWD
mkdir -p /contracts

git clone https://github.com/EOSIO/eosio.contracts.git
cd eosio.contracts
./build.sh -y

cp $installPath/eosio.contracts/build/contracts/. /contracts/eosio.system -a
rm -rf $installPath/eosio.contracts