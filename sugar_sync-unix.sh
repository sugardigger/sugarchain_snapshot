#!/usr/bin/env bash

# usage: ./sugar_sync-unix.sh ~/.sugarchain

args=("$@")

wget -x -nH -i manifest.txt --no-check-certificate --cut-dirs=1 --directory-prefix=${args[0]}