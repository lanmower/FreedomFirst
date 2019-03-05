#!/bin/bash
DATADIR="./blockchain"

if [ ! -d $DATADIR ]; then
  mkdir -p $DATADIR;
fi
. ./keys.conf
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
--p2p-peer-address dconnect.live:9010 \
--p2p-peer-address steem.host:9010 \
--p2p-peer-address gostomp.co.za:9010 \
--hard-replay-blockchain \
>> $DATADIR"/nodeos.log" 2>&1 & \
echo $! > $DATADIR"/eosd.pid"
