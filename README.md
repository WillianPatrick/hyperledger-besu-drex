# hyperledger-besu-drex

## Contents to Install:

- Hyperledger Besu Nodes
  - bootnode
  - validator 1
  - validator 2
  - member 1
  - member 2
- Extensions
  - Prometheus (Logs)
  - Blockscout (Block Explorer)
  - Grafana (Metrics)
- Dependencies
  - Postgres (on Blockscout)

## Prerequisites:

- Docker

## Run Scripts:

1. Generate Node Keys
   - Creates nodeid, public, and private keys
   - **Tree:**
     ```
     keys
     └── nodename
     ```
   - **Command:**
     ```
     ./1-generate-node-keys.ps1
     ```

    - **Sample generated node keys on struct folders and files**
        ![Sample log generated node keys](/images/generate-keys.png)![Config struct folders generated](/images/config-folders-files.png)![Keys struct folders generated](/images/keys-folders-files.png)!!


2. Up Docker Compose
   - Creates Docker containers for nodes and extension services
   - **Tree:**
     ```
     data
     └── nodes
         └── nodename
     ```
   - **Command:**
     ```
     docker compose -f ".\2-docker-compose-besu-nodes.yaml" up -d --build
     ```
