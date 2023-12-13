---
date: 2023-12-12T14:57:21-05:00
summary: In this guide I will lay out the detailed steps for how you can get started running *your own Bitcoin mining pool.*
draft: true
hidemeta: false
showToc: true
tags:
- Bitcoin
- network
- p2p
- mining
- decentralization
title: Run your own Bitcoin pool
---

In this guide I will lay out the detailed steps for how you can get started running *your own Bitcoin mining pool.* While it can seem incredibly daunting to do something like this, thanks to the work of the fantastic creator of [public-pool](https://github.com/benjamin-wilson/public-pool), [Benjamin Wilson](https://github.com/benjamin-wilson), it's easier than ever today.

I've taken the time to help "Dockerize" the public-pool code to allow you to run it without needing to compile from source. If you want to get into the nitty-gritty details of compilation and go that route, please take a look at the official repo for more info:

- <https://github.com/benjamin-wilson/public-pool>

## Pre-requisites

I will assume in this guide that you have purchased and SSH'd into the VPS/host of your choosing, as well as own a domain name you want to use to send people to the pool web UI and stratum interface.

If you're using your own hardware at home, this guide will still generally apply to you assuming you are running Ubuntu/Debian.

## Recommended hardware
  
- Pruned Node[^1]
  - 2+ vCPUs/cores
  - 4GB+ RAM
  - 75GB+ SSD
  
[^1]: A pruned node allows you to run your own Bitcoin node without requiring as much disk space.

## Why run your own Bitcoin node?

The Bitcoin network relies on a distributed web of Bitcoin nodes, each of which validate transactions, propagate transactions to the rest of the network, and helps new nodes easily and quickly synchronize to the current state of the network.

Running a Bitcoin node for yourself not only helps to give you the stronger network-level privacy guarantees, but also helps to increase the decentralization, stability, and speed of the Bitcoin network.

Each node can expose one powerful service:

- Peer-to-Peer (p2p) port (default 8333): this port allows other nodes on the network to connect to your node to download the blockchain and send you any transactions they validate that you do not yet have.

Deploying via Docker has a few key benefits, namely a simple and cross-OS compatible install along with automatic updates via [Watchtower](https://containrrr.dev/watchtower/).

## Why run and mine on an instance of public-pool instead of a "normal" Bitcoin pool?

One of the critical issues facing the Bitcoin network today is pool centralization and [censorship]({{< ref "../posts/fungibility-graveyard.md#compliant-mining-and-virgin-bitcoin" >}}). At the moment of writing this guide, [two pools control >51% of the network's hashrate](https://hashrateindex.com/hashrate/pools), making censorship and attack trivial if those pools worked together.

{{< figure src="/run-your-own-bitcoin-pool/pools.png" align="center" style="border-radius: 8px;" >}}

One of the most powerful things we can do as Bitcoin miners is **opt out** of the largest pools on the network and choose to point our hashrate at pools that are smaller, respect our views on censorship, etc. While there are some [good small pools](https://lincoin.com/) today, one way that those of us with a little more technical know-how can help is to spin up new pools for our friends, family, and digital communities to further decentralize the hashrate. This is especially powerful for those running mining hardware at home like [BitAxe](https://bitaxe.org/), where the low hashrate makes it unlikely to earn enough Bitcoin for payout on a large pool.

Enter solo mining -- using public-pool anyone can point their miner at a pool and start solo mining on the Bitcoin network in seconds, essentially using their hashrate as a Bitcoin lottery ticket while helping to protect the network at the same time. public-pool is a powerful way to leverage your hashrate ideologically and look past blind, short-term profit and focus on the long-term success of freedom money.

Now let's get started.

## Update and install required packages

1. Install a few tools we will need later:

    ```bash
    sudo apt-get update && sudo apt-get upgrade -y
    sudo apt-get install -y ufw curl
    ```

2. Install Docker:

    ```bash
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
    su - $USER
    ```

*Note: This command downloads a script and runs as root directly from Docker. Please make sure you are comfortable doing this, and be wary of doing this on a personal computer. If you'd like to avoid that, please follow the official docs [here](https://docs.docker.com/engine/install/debian/#install-using-the-repository) to install from the repository.*

## Initial hardening via UFW

We will want to make sure that the system is hardened in a simple way by making sure that the firewall is locked down to only allow access to the ports necessary for SSH, `bitcoind`, and `public-pool` using UFW.

A great intro to getting started with UFW is available [on DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-setup-a-firewall-with-ufw-on-an-ubuntu-and-debian-cloud-server).

Run the following commands to add some basic UFW rules and enable the firewall:

```bash
# Deny all non-explicitly allowed ports
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow SSH access
sudo ufw allow ssh

# Allow HTTP and HTTPS access for Let's Encrypt certificate issuance and pool UI
sudo ufw allow http
sudo ufw allow https

# Allow bitcoind p2p port
sudo ufw allow 8333/tcp

# Allow pool stratum port
sudo ufw allow 3333/tcp

# Enable UFW
sudo ufw enable
```

## Download and run bitcoind and public-pool via Docker

This section will use a simple [Docker Compose](https://docs.docker.com/compose/) configuration file that tells Docker exactly how each part needs to be configured and connected together.

This allows us to simplify down the launch of `bitcoind` and `public-pool` down to a few simple commands.

If you would like to inspect the source code behind the image used here or build it yourself, please see the below links:

- [bitcoind Source Repository](https://github.com/sethforprivacy/docker-bitcoind)
- [public-pool Source Repository](https://github.com/sethforprivacy/public-pool)  
- [public-pool-ui Source Repository](https://github.com/sethforprivacy/public-pool-ui)  

1. Get the necessary files from Github and place them wherever you'd like, for this guide I will use `~/pool`:

    ```bash
    mkdir ~/pool
    cd ~/pool
    git clone https://github.com/sethforprivacy/simple-public-pool.git .
    nano docker-compose.yml
    ```

    Be sure to update the lines with `REPLACE_ME` in them, all of which need you to specify the domain you want to use for your pool.

    These are all the lines that need to be replaced:

    ```yaml
    # Line 16
    # Replace with an email address where Let's Encrypt can reach you to alert you to certificates that are expiring for any reason.
     - "--certificatesresolvers.selfhostedservices.acme.email=REPLACE_ME"
    
    # Line 55
    # Replace REPLACE_ME with the domain you want to use, i.e. pool.sethforprivacy.com
    - "traefik.http.routers.public-pool-api.rule=Host(`REPLACE_ME`) && PathPrefix(`/api`)"

    # Line 65
    # Replace REPLACE_ME with the domain you want to use, i.e. pool.sethforprivacy.com
    - DOMAIN=REPLACE_ME

    # Line 68
    # Replace REPLACE_ME with the domain you want to use, i.e. pool.sethforprivacy.com
    - "traefik.http.routers.public-pool-ui.rule=Host(`REPLACE_ME`)"
    ```

    *To escape from the nano shell and save the file, hit `ctrl+x`, then `y` to save the file.*

    Explanations of the containers used in the above `docker-compose.yml` file:

    1. `bitcoind`: The Bitcoin daemon is the process that connects to the Bitcoin blockchain, synchronizes with other nodes on the network, and validates and keeps track of transactions happening in the Monero blockchain.  
    2. `public-pool`: This is the actual pool process that watches the Bitcoin network via `bitcoind`, builds block templates based on the mempool, and provides those block templates as jobs directly to miners.
    3. `public-pool-ui`: This is the web UI that allows miners to see their statistics, view payouts, and keep track of the overall pool growth and usage.
    4. `watchtower`: This container keeps an eye out for new images for all other running containers, updating them immediately when new images are available. This container will ensure you never need to manually upgrade `bitcoind` or `public-pool`, and will always be running the latest versions.

2. Copy the example `pool.env.example` file

    ```bash
    cd ~/pool
    cp pool.env.example pool.env
    ```

    ***Be sure to edit this file!*** You need to properly set a secure username and password to be used for Bitcoin RPC authentication, which will also be used in the next step's `bitcoin.conf` file. These are the lines that must be edited:

    ```txt
    BITCOIN_RPC_USER=bitcoin
    BITCOIN_RPC_PASSWORD=bitcoin
    ```

    Edit any other variables you'd like, but for most setups you don't need to change anything else here.

3. Copy the example `bitcoin.conf.example` file to `bitcoin.conf` and set variables properly

    ```bash
    cd ~/pool
    cp bitcoin.conf.example bitcoin.conf
    ```

    ***Be sure to edit this file!*** You need to properly set a secure username and password to be used for Bitcoin RPC authentication. These are the lines that must be edited:

    ```txt
    rpcuser=bitcoin
    rpcpassword=bitcoin
    ```

4. Start `bitcoind` and allow it to sync fully:

    ```bash
    cd ~/pool
    docker compose up -d bitcoind
    ```

    `bitcoind` can take anywhere from 4-6h to a few days to sync fully, depending on your hardware.

5. Once `bitcoind` is fully synced, start up the other services

    ```bash
    cd ~/pool
    docker compose up -d
    ```

6. Watch the logs of public-pool to ensure it started and is synchronizing properly

    ```bash
    cd ~/pool
    docker compose logs --follow public-pool
    ```

    You should see lines like `Bitcoin RPC connected` and `Stratum server is listening on port 3333`.

### If you already run a Bitcoin node

If you already run a node and don't want to migrate to this Docker Compose setup, simply add the flag `zmqpubrawblock=tcp://*:3000` to your `bitcoind` instance and restart it, forward port `3000/tcp`, and then use the below Docker Compose file and replace the `--host` value with the IP or DNS address of your existing node:

1. Get the necessary files from Github and place them wherever you'd like, for this guide I will use `~/pool`:

    ```bash
    mkdir ~/pool
    cd ~/pool
    git clone https://github.com/sethforprivacy/simple-public-pool.git
    nano docker-compose-no-bitcoind.yml
    ```

    Be sure to update the lines with `REPLACE_ME` in them, all of which need you to specify the domain you want to use for your pool.

    These are all the lines that need to be replaced:

    ```yaml
    # Line 16
    # Replace with an email address where Let's Encrypt can reach you to alert you to certificates that are expiring for any reason.
     - "--certificatesresolvers.selfhostedservices.acme.email=REPLACE_ME"
    
    # Line 55
    # Replace REPLACE_ME with the domain you want to use, i.e. pool.sethforprivacy.com
    - "traefik.http.routers.public-pool-api.rule=Host(`REPLACE_ME`) && PathPrefix(`/api`)"

    # Line 65
    # Replace REPLACE_ME with the domain you want to use, i.e. pool.sethforprivacy.com
    - DOMAIN=REPLACE_ME

    # Line 68
    # Replace REPLACE_ME with the domain you want to use, i.e. pool.sethforprivacy.com
    - "traefik.http.routers.public-pool-ui.rule=Host(`REPLACE_ME`)"
    ```

    *To escape from the nano shell and save the file, hit `ctrl+x`, then `y` to save the file.*

    Explanations of the containers used in the above `docker-compose-no-bitcoind.yml` file:

    1. `public-pool`: This is the actual pool process that watches the Bitcoin network via `bitcoind`, builds block templates based on the mempool, and provides those block templates as jobs directly to miners.
    2. `public-pool-ui`: This is the web UI that allows miners to see their statistics, view payouts, and keep track of the overall pool growth and usage.
    3. `watchtower`: This container keeps an eye out for new images for all other running containers, updating them immediately when new images are available. This container will ensure you never need to manually upgrade `bitcoind` or `public-pool`, and will always be running the latest versions.

2. Copy the example `pool.env.example` file

    ```bash
    cd ~/pool
    cp pool.env.example pool.env
    ```

    ***Be sure to edit this file!*** You need to properly set a secure username and password to be used for Bitcoin RPC authentication that you already have configured for your existing `bitcoind` instance. These are the lines that must be edited:

    ```txt
    # Line 1
    # Replace "http://bitcoind" with the correct protocol and domain/IP address for your Bitcoin node, i.e. http:node.sethforprivacy.com
    BITCOIN_RPC_URL=http://bitcoind

    # Line 2-3
    # Replace with the proper bitcoind RPC auth credentials
    BITCOIN_RPC_USER=bitcoin
    BITCOIN_RPC_PASSWORD=bitcoin

    # Line 4
    # Replace (if necessary) with the proper RPC port of your bitcoind instance
    BITCOIN_RPC_PORT=8332

    # Line 6
    # Replace "tcp://bitcoind:3000" with the proper address and zmqpubrawblock port of your bitcoind instance, i.e. tcp://node.sethforprivacy.com:3000
    BITCOIN_ZMQ_HOST="tcp://bitcoind:3000"
    ```

    Edit any other variables you'd like, but for most setups you don't need to change anything else here.

3. Start up all services

    ```bash
    cd ~/pool
    docker compose -f docker-compose-no-bitcoind.yml up -d
    ```

4. Watch the logs of public-pool to ensure it started and is synchronizing properly

    ```bash
    cd ~/pool
    docker compose -f docker-compose-no-bitcoind.yml logs --follow public-pool
    ```

    You should see lines like `Bitcoin RPC connected` and `Stratum server is listening on port 3333`.

## Connecting your miners

Now that you have a working pool properly set up, connecting your miners is trivial! Just point them to your specific domain and stratum port, i.e.:

`stratum+tcp://pool.sethforprivacy.com:3333`

Or for miners that don't accept/handle the `stratum+tcp://` prefix:

`pool.sethforprivacy.com:3333`

You should see your miner start getting work immediately, and can watch the worker join the pool in your logs:

```bash
cd ~/pool
docker compose -f docker-compose-no-bitcoind.yml logs --follow public-pool
```

You'll see logs like this for every client that joins:

`public-pool  | New client ID: : 11aaf9cc, ::ffff:24.25.209.99:57060`

## Credit

Please note that **all** credit here belongs to the fantastic creator of [public-pool](https://github.com/benjamin-wilson/public-pool), [Benjamin Wilson](https://github.com/benjamin-wilson). If you appreciate the ability to easily spin up your own pool in a few minutes with 100% FOSS code, please consider taking a moment and sending him a donation for his time! You can find his donation details on the bottom of his pool instance and mine:

<https://web.public-pool.io/#/>

## Conclusion

I hope this guide will help to spawn many more "Uncle Jim" style pools for small communities to be able to easily come together and point their hash at a pool that follows their principles, further decentralizing the Bitcoin network.

If you have specific questions or need some help, please reach out via [Signal, SimpleX, or Nostr]({{< ref "/content/about.md#how-to-contact-me" >}}).
