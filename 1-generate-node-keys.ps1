# Function to generate keys using Besu in Docker
function generate_keys($node_dir) {
    New-Item -Path "data/nodes/${node_dir}" -ItemType Directory -Force | Out-Null
    New-Item -Path "keys/${node_dir}" -ItemType Directory -Force | Out-Null
    Write-Host "Generating keys for ${node_dir}..."
    docker run --rm -v ${PWD}/config:/opt/besu/config -v ${PWD}/data/nodes/${node_dir}/:/opt/besu/data hyperledger/besu:latest operator generate-blockchain-config --config-file=/opt/besu/config/qbftConfigFile.json --to=/opt/besu/data --private-key-file-name=key

    $first_folder = (Get-ChildItem -Path "${PWD}/data/nodes/${node_dir}/keys" | Select-Object -First 1).Name
    if ($first_folder) {
        Move-Item -Path "${PWD}/data/nodes/${node_dir}/keys/${first_folder}/*" -Destination "${PWD}/keys/${node_dir}"

        Write-Host "Keys generated for $node_dir."

            $key_pub_file = "${PWD}/keys/${node_dir}/key.pub"
            if (Test-Path $key_pub_file) {
                $node_id = (Get-Content $key_pub_file | ForEach-Object { $_ -replace '^0x' })
                Write-Host "Node ID for $node_dir : $node_id"
                $node_id | Set-Content "${PWD}/keys/${node_dir}/nodeid"
                Copy-Item -Path "${PWD}/data/nodes/${node_dir}/genesis.json" -Destination "${PWD}/config/"
                Remove-Item -Path "${PWD}/data/nodes/${node_dir}" -Recurse
                Write-Host "Removing temp files from $node_dir"
            } else {
                Write-Host "Error: Could not find $key_pub_file."
                exit 1
            }

        if ($node_dir -eq "bootnode") {
            $script:node_end_ip = 10
            generate_configfile($node_id);
        }
        else {
            $script:node_end_ip++
        }

        $script:nodes += "`"enode://${node_id}@172.16.239.${script:node_end_ip}:30303`","
        $script:static_nodes += "`"enode://${node_id}@172.16.239.${script:node_end_ip}:30303`","
    } else {
        Write-Host "Error: Key generation for $node_dir failed."
        exit 1
    }
}


function generate_configfile($node_id) {
# Initial config.toml content
@"
genesis-file="/config/genesis.json"
node-private-key-file="/opt/besu/keys/key"
logging="INFO"
data-path="/opt/besu/data"
host-allowlist=["*"]
min-gas-price=0

# rpc
rpc-http-enabled=true
rpc-http-host="0.0.0.0"
rpc-http-port=8545
rpc-http-cors-origins=["*"]

# ws
rpc-ws-enabled=true
rpc-ws-host="0.0.0.0"
rpc-ws-port=8546

# graphql
graphql-http-enabled=true
graphql-http-host="0.0.0.0"
graphql-http-port=8547
graphql-http-cors-origins=["*"]

# metrics
metrics-enabled=true
metrics-host="0.0.0.0"
metrics-port=9545

# permissions
permissions-nodes-config-file-enabled=true
permissions-nodes-config-file="/config/permissions_config.toml"

# bootnodes
bootnodes=["enode://${node_id}@172.16.239.10:30303"]


# Discovery at boot is set to a list of static files, but will also discover new nodes should they be added
# static nodes
static-nodes-file="/config/static-nodes.json"
discovery-enabled=true
"@ | Out-File "./config/config.toml"
}

function generate_permissions_config($nodes) {
    if ($nodes.Length -gt 0) {
        $nodes = $nodes -join "`n    " -replace ",`$", ""
    }
    @"
nodes-allowlist=[
    $nodes
]
"@ | Out-File "./config/permissions_config.toml"
}
function generate_static_config($static_nodes) {
    if ($static_nodes.Length -gt 0) {
        $static_nodes = $static_nodes -join "`n    " -replace ",`$", ""
    }
    @"
[
    $static_nodes
]
"@ | Out-File "./config/static-nodes.json"
}
    

# Loop to setup each node
Write-Host "Setting up nodes..."
generate_keys "bootnode"
generate_keys "validator1"
generate_keys "validator2"
generate_keys "if1"
generate_keys "if2"

Remove-Item -Path "${PWD}/data/nodes" -Recurse

generate_permissions_config($nodes)
generate_static_config($static_nodes)

Write-Host "Configuration setup complete."
Write-Host "Setup Complete. Configuration files created."