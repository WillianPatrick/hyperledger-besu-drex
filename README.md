# hyperledger-besu-drex
Contents to install:
    - Hyperledger Besu Nodes
        - bootnode
        - validator 1
        - validator 2
        - member 1
        - member 2
    - Extensions
        - Prometheus (LOGs)
        - Blockscout (Block Explorer)
        - Grafana (Metrics)
    - Dependences
        - Postgres (on blockscout)


Prerequisites:
    - Docker

Run scripts
1 - Generate Node Keys
    - Creates nodeid, public and private keys
    - Tree
      - keys
        - nodename
    - Command:
        ./1-generate-node-keys.ps1

2 - Up docker compose
    - Creates docker containers for nodes and extensions services
    - Tree
      - data
        - nodes
            - nodename
    - Command:
        docker compose -f ".\2-docker-compose-besu-nodes.yaml" up -d --build

