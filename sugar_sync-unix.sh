#!/usr/bin/env bash

# usage: ./sugar_sync-unix.sh chain_path network
# exmaple: ./sugar_sync-unix.sh ~/.sugarchain mainnet

args=("$@")

chain="${args[0]}"
network="${args[1]}"

if [ -z "$chain" ]
then
  chain="~/.sugarchain"
fi

if [ -z "$network" ]
then
  network="mainnet"
fi

echo "[INFO:] starting ${network} sync into ${chain}"
echo "..."
echo ".."
echo "."

# download network chain
wget -x -nH -i https://raw.githubusercontent.com/sugardigger/sugarchain_snapshot/main/manifest/${args[1]}.txt --no-check-certificate --cut-dirs=1 --directory-prefix=${args[0]}

# remove temp manifest.txt
rm -rf ${args[0]}/sugarchain_snapshot