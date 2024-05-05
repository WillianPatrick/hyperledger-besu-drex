
# Hyperledger Besu Network Setup

This repository provides scripts and configuration for setting up a Hyperledger Besu network, which includes several node types and monitoring tools.

## Contents to Install:

- **Hyperledger Besu Nodes**
  - bootnode
  - validator 1
  - validator 2
  - member 1
  - member 2
- **Extensions**
  - Prometheus (Logs)
  - Blockscout (Block Explorer)
  - Grafana (Metrics)
- **Dependencies**
  - Postgres (on Blockscout)

## Prerequisites:

- Docker

## Run Scripts:

1. **Generate Node Keys**
   - Creates nodeid, public, and private keys.
   - **Tree:**
     ```
     keys/
     └── nodename/
     ```
   - **Command:**
     ```bash
     ./1-generate-node-keys.ps1
     ```
   - **Sample generated node keys on structure folders and files**
     - ![Sample log generated node keys](/images/generate-keys.png)
     - ![Config structure folders generated](/images/config-folders-files.png)
     - ![Keys structure folders generated](/images/keys-folders-files.png)

2. **Up Docker Compose**
   - Creates Docker containers for nodes and extension services.
   - **Tree:**
     ```
     data/
     └── nodes/
         └── nodename/
     ```
   - **Command:**
     ```bash
     docker-compose -f "./2-docker-compose-besu.yaml" up -d --build
     ```
   - **Sample generated docker compose up**
     - ![Sample log generated up services](/images/docker-compose-up.png)

3. **Services**
   - **Blockscout** on http://localhost:26000/
     - ![Blockscout](/images/service-blockscout.png)
   - **Grafana** on http://localhost:3000/
     - ![Grafana](/images/service-grafana.png)
   - **Prometheus** on http://localhost:9090/
     - ![Prometheus](/images/service-prometheus.png)

## Cleanup and Maintenance

To stop and remove the containers, networks, and associated volumes:
```bash
docker-compose -f "docker-compose-besu.yaml" down -v
```

For further details on specific configurations and advanced adjustments, please consult the [Hyperledger Besu documentation](https://besu.hyperledger.org/).

## Contributing

Contributions are welcome! To contribute, please fork the repository, make your changes, and submit a Pull Request.

## License

This project is licensed under the MIT - see the `LICENSE` file for details.
