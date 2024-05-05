
# Hyperledger Besu Network Setup

This repository contains all necessary scripts and configuration files to deploy a permissioned blockchain network using Hyperledger Besu. This setup includes multiple nodes, monitoring with Prometheus and Grafana, and blockchain data exploration using Blockscout.

## Table of Contents

- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Configuration Files](#configuration-files)
- [Setup Instructions](#setup-instructions)
  - [Generating Node Keys](#generating-node-keys)
  - [Launching the Network](#launching-the-network)
- [Network Architecture](#network-architecture)
- [Contributing](#contributing)
- [License](#license)

## Project Structure

```
├── config/
│   ├── qbftConfigFile.json       # QBFT consensus configuration
├── keys/
│   └── [dynamically generated]   # Node keys storage
├── data/
│   └── nodes/
│       └── [dynamically generated]  # Blockchain data for each node
├── scripts/
│   ├── 1-generate-node-keys.ps1  # Script to generate node keys
│   ├── 2-docker-compose-besu.yaml  # Docker Compose file for network setup
└── images/
    └── [screenshots and diagrams]
```

## Prerequisites

- Docker and Docker Compose
- PowerShell for Windows users

## Configuration Files

### qbftConfigFile.json

This JSON file configures the QBFT (Quorum Byzantine Fault Tolerance) consensus protocol parameters:

- **Chain ID**: 1217
- **Block Period Seconds**: 2
- **Epoch Length**: 30,000
- **Request Timeout Seconds**: 4

Pre-allocates Ether to several accounts for network testing.

## Setup Instructions

### Generating Node Keys

1. Navigate to the `scripts/` directory.
2. Run the PowerShell script to generate keys for nodes:
    ```powershell
    ./1-generate-node-keys.ps1
    ```

This will create keys in the `keys/` directory under each node's subdirectory.

### Launching the Network

1. Ensure all configurations and node keys are in place.
2. Execute the Docker Compose script:
    ```bash
    docker-compose -f "./2-docker-compose-besu.yaml" up -d
    ```

This starts all configured services, including Besu nodes, Prometheus, Grafana, and Blockscout.

## Network Architecture

Describes the roles of different nodes in the network such as validators and members and how they interact with each other using the QBFT consensus mechanism.

## Contributing

We welcome contributions! Please read `CONTRIBUTING.md` for details on our code of conduct, and the process for submitting pull requests to us.

## License

This project is licensed under the Apache License 2.0 - see the `LICENSE` file for details.
