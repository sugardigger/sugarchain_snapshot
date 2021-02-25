# sugarchain_snapshot

Simple tool for creating and downloading a full blockchain snapshot. The snapshot contains two folders `blocks` and `chainstate`
Make sure that you have enough bandwidth and storage for the full blockchain snapshot (currently over 8Gb).

## download snapshot
grab the sync script
```
wget https://raw.githubusercontent.com/sugardigger/sugarchain_snapshot/main/sugar_sync-unix.sh
```

start sync (make sure the path is direct)
```
./sugar_sync-unix.sh /root/.sugarchain mainnet

# usage:
# ./sugar_sync-unix.sh chain_path network
```
