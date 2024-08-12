set -x
blk=$(curl -s -H "Content-Type: application/json" -X POST --data '{"jsonrpc":"2.0","method":"eth_blockNumber", "params": [], "id": 99}' 127.0.0.1:8545 | jq -r .result)
curl -s -H "Content-Type: application/json" -X POST --data '{"jsonrpc":"2.0","method":"scroll_getBlockTraceByNumberOrHash", "params": ["'$blk'"], "id": 99}' 127.0.0.1:8545 > mainnet_blocks/${blk}.json 
