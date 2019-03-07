#!/bin/bash
DATADIR="./blockchain"

if [ ! -d $DATADIR ]; then
  mkdir -p $DATADIR;
fi

. ./keys.conf 

echo $NAME
nodeos \
--signature-provider $PUBKEY=KEY:$PRIVKEY \
--plugin eosio::producer_plugin \
--plugin eosio::chain_api_plugin \
--plugin eosio::http_plugin \
--plugin eosio::history_api_plugin \
--data-dir $DATADIR"/data" \
--blocks-dir $DATADIR"/blocks" \
--config-dir $DATADIR"/config" \
--producer-name $NAME \
--http-server-address 0.0.0.0:8888 \
--p2p-listen-endpoint 0.0.0.0:9010 \
--access-control-allow-origin=* \
--contracts-console \
--http-validate-host=false \
--verbose-http-errors \
--enable-stale-production \
--p2p-peer-address 54.39.23.130:9010 \
--p2p-peer-address 192.99.154.55:9010 \
--p2p-peer-address 51.38.70.208:9010 \
>> $DATADIR"/nodeos.log" 2>&1 & \
echo $! > $DATADIR"/eosd.pid"
echo "Press cntrl-c to stop watching the log, you can view it later with tail -f blockchain/nodeos.log"
tail -f $DATADIR"/nodeos.log"
