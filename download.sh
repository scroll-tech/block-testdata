set -x

function download() {
    curl -s -H "Content-Type: application/json" -X POST --data '{"jsonrpc":"2.0","method":"scroll_getBlockTraceByNumberOrHash", "params": ["'$(printf '0x%x' $2)'", {"StorageProofFormat": "flatten"}], "id": 99}' 127.0.0.1:8545 | \
    jq .result | \
    jq 'del(.executionResults, .txStorageTraces)' | \
    jq 'del(.coinbase.["nonce", "balance", "keccakCodeHash", "poseidonCodeHash", "codeSize"])' | \
    jq 'del(.header.["parentHash", "sha3Uncles", "stateRoot", "transactionsRoot", "receiptsRoot", "logsBloom", "extraData", "withdrawalsRoot", "blobGasUsed", "excessBlobGas", "parentBeaconBlockRoot"])' | \
    jq 'del(.codes.[].["codeSize", "keccakCodeHash", "hash"])' | \
    jq 'del(.storageTrace.["proofs", "storageProofs", "addressHashes", "storeKeyHashes"])'  > mainnet_blocks/$1/$2.json
}

download $1 $2