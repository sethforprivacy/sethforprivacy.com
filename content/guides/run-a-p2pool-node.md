+++
title = "Run and mine on a p2pool Node"
date = 2021-09-08T14:45:00-04:00
author = "Seth"
authorTwitter = "sethforprivacy"
cover = ""
tags = ["Monero", "network", "p2p", "p2pool", "mining", "decentralization"]
keywords = ["Monero", "network", "p2p", "p2pool", "mining", "decentralization"]
description = "This guide will aim to make it very simple and straightforward for you to start and run your own Monero node and p2pool instance for decentralized and fee-less mining of Monero."
summary = "This guide will aim to make it very simple and straightforward for you to start and run your own Monero node and p2pool instance for decentralized and fee-less mining of Monero."
showFullContent = false
toc = true
draft = false
+++

# Introduction

***NOTE: Much of the beginning of this guide is taken from my related guide, ["Run a Monero Node"]({{< ref "/content/guides/run-a-monero-node.md" >}}), but is necessary here as running your own node is usually required for p2pool usage.***

This guide will aim to make it very simple and straightforward for you to start and run your own Monero node and p2pool instance for decentralized and fee-less mining of Monero. p2pool is a huge breakthrough that allows individual miners full control over the mining process, removing trust in pools and pool operators and allowing anyone to mine in a decentralized fashion while keeping payout variance down as opposed to solo mining.

For more information on why you would want to use p2pool instead of a normal pool for mining, please see: [Why run and mine on p2pool instead of a "normal" Monero pool?]({{< relref "#why-run-and-mine-on-p2pool-instead-of-a-normal-monero-pool" >}})

# Pre-requisites

I will assume in this guide that you have purchased and SSH'd into the VPS/host of your choosing, but if you need help with those first steps here are a few good links to follow:

- [Hosting services accepting Monero](https://www.getmonero.org/community/merchants/#hosting)
  - These are some options available for hosting a VPS while paying with Monero, and each come with pro's and con's.
- [Hetzner Dedicated Servers](https://www.hetzner.com/dedicated-rootserver)
  - A solid and cheap dedicated server provider based out of Germany, they do not accept Monero (yet!) but are a great choice for a high-performance node.
- [Simple Linode deployment guide](https://www.pragmaticlinux.com/2020/07/setup-a-minimal-debian-10-buster-server-as-a-linode-vps/)
  - If you use Linode, please consider using [my referral link](https://www.linode.com/?r=c956dbb75d14063251557a0e5003efb5ceacc74d) so we both get free credits.

If you're using your own hardware at home, this guide will still generally apply to you assuming you are running Ubuntu/Debian.

# Recommended hardware
  
- Pruned Node[^1]
  - 2+ vCPUs/cores
  - 4GB+ RAM
  - 75GB+ SSD
  
[^1]: A pruned node allows you to run your own Monero node without requiring as much disk space. Please see [the pruning Moneropedia entry](https://www.getmonero.org/resources/moneropedia/pruning.html) for more info.

# Why run your own Monero node?

The Monero network relies on a distributed web of Monero nodes, each of which validate transactions, propagate transactions to the rest of the network, and helps new nodes easily and quickly synchronize to the current state of the network.

Running a Monero node for yourself not only helps to give you the stronger network-level privacy guarantees, but also helps to increase the decentralization, stability, and speed of the Monero network.

Each node can expose two different services, each of which has a positive impact on the network in a unique way:

- Peer-to-Peer (p2p) port (default 18080): this port allows other nodes on the network to connect to your node to download the blockchain and to send you any transactions they validate that you do not yet have. It also increases overall network privacy, as your node participates in the [Dandelion++](https://www.monerooutreach.org/stories/dandelion.html) propagation of transactions.
- Remote Procedure Call (RPC) port (default 18089 for restricted): Exposing this port (especially with the `public-node` arg) allows other users on the network, especially those using mobile wallets or the GUI wallet in "Simple" mode, to connect to your node to sync their wallets, without needing to run their own full node locally.

You can choose to either [setup a node via systemd and binaries]({{< ref "run-a-monero-node-advanced.md" >}}) or deploy `monerod` as a Docker container below.

Deploying via Docker has a few key benefits, namely a simple and cross-OS compatible install along with automatic updates via [Watchtower](https://containrrr.dev/watchtower/).

# Why run and mine on p2pool instead of a "normal" Monero pool?

Mining on Monero has always been one of the most decentralized PoW networks in the cryptocurrency space, but an issue that has plagued Monero (and all other PoW cryptocurrencies) is that even if miners themselves are numerous and diverse geographically, pools used by those miners are generally very few, geographically similar, and entirely centralized.

The pool operator of a normal mining pool controls the block template produced by all of the miners pointing to it, allowing them to leverage the hashrate for nefarious purposes if they so choose. Normal pools are also custodians of funds as all mined funds are sent first to the pool, and then the pool (hopefully) pays out from those funds to miners according to their work.

Pools and their operators are one of the most vulnerable aspects of Monero mining, but thankfully the Monero community (particularly sech1 [also known as [SChernykh](https://github.com/SChernykh)]) have built out a p2pool implementation, from scratch, with many improvements over past attempts at p2pool on Bitcoin and other blockchains.

Running p2pool allows you to participate in a second blockchain that is used to decentralize the normal pool functionality, while contributing work as a whole to the main Monero network.

For more details on p2pool and why you should use it, see the official Github repository: <https://github.com/SChernykh/p2pool>

# Update and install required packages

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

3. Install Docker Compose:

    ```bash
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    ```

*Note: This command downloads a script and runs as root directly from Docker. Please make sure you are comfortable doing this, and be wary of doing this on a personal computer. If you'd like to avoid that, please follow the official docs [here](https://docs.docker.com/engine/install/debian/#install-using-the-repository) to install from the repository.*

# Initial hardening via UFW

We will want to make sure that the system is hardened in a simple way by making sure that the firewall is locked down to only allow access to the ports necessary for SSH and `monerod`, using UFW.

A great intro to getting started with UFW is available [on DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-setup-a-firewall-with-ufw-on-an-ubuntu-and-debian-cloud-server).

Run the following commands to add some basic UFW rules and enable the firewall:

```bash
# Deny all non-explicitly allowed ports
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow SSH access
sudo ufw allow ssh

# Allow monerod p2p port
sudo ufw allow 18080/tcp

# Allow monerod restricted RPC port
sudo ufw allow 18089/tcp

# Allow p2pool p2p port
sudo ufw allow 37889/tcp

# Allow p2pool stratum port
sudo ufw allow 3333/tcp

# Enable UFW
sudo ufw enable
```

# Download and run monerod and p2pool via Docker

This section will use a simple [Docker Compose](https://docs.docker.com/compose/) configuration file that tells Docker exactly how each part needs to be configured and connected together.

This allows us to simplify down the launch of `monerod` and `p2pool` down to a few simple commands.

If you would like to inspect the source code behind the image used here or build it yourself, please see the below links:

[monerod Docker Hub Images](https://hub.docker.com/r/sethsimmons/simple-monerod)  
[monerod Source Repository](https://github.com/sethsimmons/simple-monerod-docker)  
[p2pool Docker Hub Images](https://hub.docker.com/r/sethsimmons/p2pool)  
[p2pool Source Repository](https://github.com/sethsimmons/p2pool-docker)  

1. Copy and paste the below configuration file wherever you would like on the VPS, for this guide I will use `~/p2pool`:

    ```bash
    vim ~/p2pool/docker-compose.yml
    ```

    {{< code language="docker" title="docker-compose.yml" id="0" expand="Show" collapse="Hide" isCollapsed="false" >}}
    version: '3.5'
    services:
        monerod:
            image: sethsimmons/simple-monerod:p2pool-api-v0.17
            restart: unless-stopped
            container_name: monerod
            volumes:
            - bitmonero:/home/monero
            ports:
            - 18080:18080
            - 18083:18083
            - 18089:18089
            command:
            - "--rpc-restricted-bind-ip=0.0.0.0"
            - "--rpc-restricted-bind-port=18089"
            - "--public-node"
            - "--no-igd"
            - "--enable-dns-blocklist"
            - "--prune-blockchain"
            - "--zmq-pub=tcp://0.0.0.0:18083"
            - "--out-peers=50"
        
        p2pool:
            image: sethsimmons/p2pool:latest
            restart: unless-stopped
            container_name: p2pool
            tty: true
            stdin_open: true
            volumes:
            - p2pool-data:/home/p2pool
            - /dev/hugepages:/dev/hugepages:rw
            ports:
            - 3333:3333
            - 37889:37889
            command: >-
            --wallet "468ydghFfthE3UTc53eF5MP9UyrMcUiAHP5kizVYJsej5XGaXBoAAEzUHCcUF7t3E3RrYAX8Rs1ujhBdcvMpZSbH8qkb55R"
            --stratum "0.0.0.0:3333" --p2p "0.0.0.0:37889"
            --addpeers "65.21.227.114:37889,node.sethforprivacy.com:37889" --host "monerod"

        tor:
            image: goldy/tor-hidden-service:latest
            container_name: tor
            restart: unless-stopped
            links:
                - monerod
                - p2pool
            environment:
                MONEROD_TOR_SERVICE_HOSTS: 18089:monerod:18089
                MONEROD_TOR_SERVICE_VERSION: '3'
                P2POOL_TOR_SERVICE_HOSTS: 3333:p2pool:3333
                P2POOL_TOR_SERVICE_VERSION: '3'
            volumes:
                - tor-keys:/var/lib/tor/hidden_service/

        autoheal:
            image: willfarrell/autoheal:latest
            container_name: autoheal
            restart: unless-stopped
            environment:
                AUTOHEAL_CONTAINER_LABEL: all
            volumes:
                - "/var/run/docker.sock:/var/run/docker.sock"

        watchtower:
            image: containrrr/watchtower:latest
            container_name: watchtower
            restart: unless-stopped
            volumes:
                - "/var/run/docker.sock:/var/run/docker.sock"

    volumes:
        bitmonero:
        tor-keys:
        p2pool-data:

    {{< /code >}}

    ***NOTE: Be sure to replace the Monero address (468y...b55R) with your own, or else you'll be making generous hashrate donations to me!***

    Explanations of the containers used in the above `docker-compose.yml` file:

    `monerod`: The Monero daemon is the process that connects to the Monero blockchain, synchronizes with other nodes on the network, and validates and keeps track of transactions happening in the Monero blockchain.  
    `p2pool`: The p2pool daemon connects to `monerod` for Monero's blockchain data needed for mining, and connects to the p2pool blockchain for synchronization and publishing work you accomplish via mining.  
    `tor`: This is a container that publishes your `monerod` and `p2pool` daemons as Tor Hidden Services if you want to connect to them via Tor directly. Feel free to remove this section if that is not something you're interested in.  
    `autoheal`: This container will attempt to restart the other containers if they fail, hopefully ensuring all services stay up.  
    `watchtower`: This container keeps an eye out for new images for all other running containers, updating them immediately when new images are available. This container will ensure you never need to manually upgrade `monerod` or `p2pool`, and will always be running the latest versions.  

2. Set huge pages for `monerod` and `p2pool`

    ```bash
    sudo sysctl vm.nr_hugepages=3072
    sudo bash -c "echo vm.nr_hugepages=3072 >> /etc/sysctl.conf"
    ```

3. Start `monerod` and allow it to sync fully:

    ```bash
    cd ~/p2pool
    docker-compose up -d monerod
    ```

    `monerod` can take anywhere from 4-6h to a few days to sync fully, depending on your hardware.

    ***If you have any more questions about the `monerod` portion of this, please see my guide at ["Run a Monero Node"]({{< ref "/content/guides/run-a-monero-node.md" >}}).***

4. Replace `--wallet` address with your own in `docker-compose.yml`

    ***NOTE: Be sure to create a new wallet for using with p2pool to preserve your privacy, and only use a "standard" address starting with a 4, subaddresses are not yet supported.***

5. Once `monerod` is fully synced, start up the other services

    ```bash
    cd ~/p2pool
    docker-compose up -d
    ```

6. Watch the logs of p2pool to ensure it started and is synchronizing properly

    ```bash
    cd ~/p2pool
    docker-compose logs --follow p2pool
    ```

    You should see lines like `SideChain verified block`, and after a few minutes of syncing you should see a line like `SideChain new chain tip`.

## If you already run a Monero node

If you already run a node and don't want to migrate to this Docker Compose setup, simply add the flag `--zmq-pub tcp://0.0.0.0:18083` to your `monerod` instance and restart it, forward port `18083/tcp`, and then use the below docker-compose file and replace the `--host` value with the IP or DNS address of your existing node:

```bash
vim ~/p2pool/docker-compose.yml
```

{{< code language="docker" title="docker-compose.yml" id="1" expand="Show" collapse="Hide" isCollapsed="true" >}}
version: '3.5'
services:
    p2pool:
        image: sethsimmons/p2pool:latest
        restart: unless-stopped
        container_name: p2pool
        tty: true
        stdin_open: true
        volumes:
        - p2pool-data:/home/p2pool
        - /dev/hugepages:/dev/hugepages:rw
        ports:
        - 3333:3333
        - 37889:37889
        command: >-
        --wallet "468ydghFfthE3UTc53eF5MP9UyrMcUiAHP5kizVYJsej5XGaXBoAAEzUHCcUF7t3E3RrYAX8Rs1ujhBdcvMpZSbH8qkb55R"
        --stratum "0.0.0.0:3333" --p2p "0.0.0.0:37889"
        --addpeers "65.21.227.114:37889,node.sethforprivacy.com:37889" --host "node.sethforprivacy.com"

    tor:
        image: goldy/tor-hidden-service:latest
        container_name: tor
        restart: unless-stopped
        links:
            - monerod
            - p2pool
        environment:
            MONEROD_TOR_SERVICE_HOSTS: 18089:monerod:18089
            MONEROD_TOR_SERVICE_VERSION: '3'
            P2POOL_TOR_SERVICE_HOSTS: 3333:p2pool:3333
            P2POOL_TOR_SERVICE_VERSION: '3'
        volumes:
            - tor-keys:/var/lib/tor/hidden_service/

    autoheal:
        image: willfarrell/autoheal:latest
        container_name: autoheal
        restart: unless-stopped
        environment:
            AUTOHEAL_CONTAINER_LABEL: all
        volumes:
            - "/var/run/docker.sock:/var/run/docker.sock"

    watchtower:
        image: containrrr/watchtower:latest
        container_name: watchtower
        restart: unless-stopped
        volumes:
            - "/var/run/docker.sock:/var/run/docker.sock"

volumes:
    tor-keys:
    p2pool-data:

{{< /code >}}

***NOTE: Be sure to replace the Monero address (468y...b55R) with your own, or else you'll be making generous hashrate donations to me!***

Once you've created the above file, start at step 4 in the section above.

# Connect your miners to p2pool

Now that `monerod` and `p2pool` are up and running, all that's left is to point your miners over to the new `p2pool` server you just spun up!

To do that on XMRig, simply run the following command while replacing the `127.0.0.1` address with the IP address/DNS address of the `p2pool` node/VPS you're running it on:

```bash
./xmrig -o 127.0.0.1:3333
```

If you want to use a configuration file with XMRig, you can use the below configuration file while replacing the `127.0.0.1` address with the IP address/DNS address of the `p2pool` node/VPS you're running it on:

```json
{
    "autosave": true,
    "donate-level": 5,
    "cpu": true,
    "opencl": false,
    "cuda": false,
    "pools": [
        {
            "coin": "monero",
            "algo": null,
            "url": "127.0.0.1:3333",
            "user": "",
            "pass": "",
            "tls": false,
            "keepalive": true,
            "nicehash": false
        }
    ]
}
```

For more details on miner configuration, see my guide ["Mining Monero"]({{< ref "/content/guides/mining-monero.md" >}}).

# Viewing your mining stats

*Thanks to DataHoarder on Matrix/IRC for the tip on how to do this!*

As there is no standard pool for you to use to check your statistics, you may be wondering how you can see your pool-side hashrate in total, shares found, accumulated approximate reward, etc.

Thankfully there is a command within `p2pool` that allows you to do just this! To check your current statistics, simply attach to the containers console, run `status`, and view the output:

```bash
docker attach p2pool
status
```

You'll see information like this displayed on your screen:

```bash
2021-09-10 13:36:14.9805 SideChain status
Main chain height         = 2446358
Main chain hashrate       = 2.689 GH/s
Side chain height         = 87443
Side chain hashrate       = 50.160 MH/s
Your hashrate (pool-side) = 12.831 KH/s
PPLNS window              = 2160 blocks (+67 uncles, 2 orphans)
Your shares               = 2 blocks (+0 uncles, 0 orphans)
Block reward share        = 0.091% (0.000796295367 XMR)
2021-09-10 13:36:14.9805 StratumServer status
Hashrate (15m est) = 12.046 KH/s
Hashrate (1h  est) = 12.046 KH/s
Hashrate (24h est) = 12.046 KH/s
Total hashes       = 6770128
Shares found       = 5
Average effort     = 40.000%
Current effort     = 1.310%
Connections        = 2 (2 incoming)
2021-09-10 13:36:14.9805 P2PServer status
Connections    = 9 (1 incoming)
Peer list size = 99
```

To disconnect from the console you need to do two keyboard commands in this order:

```
Control + P
Control + Q
```

This signals to the Docker console that you want to disconnect without killing the running `p2pool` process.

# Checking payouts

To see payouts from mining, simply watch the wallet in your favorite Monero wallet like [Cake Wallet](https://cakewallet.com/) or [Monerujo](https://www.monerujo.io/).

To view general pool statistics for the current mainnet testing p2pool instance, see <https://p2pool.io/>.

***NOTE: At the time of this blog post, Cake Wallet is not yet updated to Monero v0.17.2.3 so payouts will not show properly there.***

# Alternative ways to run p2pool

If you don't prefer this approach or would like to build from source yourself, check out the following two approaches:

- Build from source and run the binaries directly: <https://github.com/SChernykh/p2pool#build-instructions>
- Use another Docker Compose setup that builds the images locally, removing any trust in my Docker images: <https://github.com/WeebDataHoarder/p2pool-compose>

There are many ways to get up and running, but I've built out the approach in this guide in an attempt to simplify the process for users. Feel free to use whatever approach you're most comfortable with and that fits threat model!

# Disclaimer

While this software has worked well for me and is good to go for mainnet, it is of course not foolproof and is still in active development. Be aware that bugs may exist and you're *very* early to p2pool usage in general.

I am not responsible for any lost funds or issues you may have with configuration or running of p2pool, but will try to help as much as possible if you do run into issues.

# Conclusion

Hopefully this has been a nice (relatively) simple guide to get you started mining Monero via p2pool! p2pool is an essential tool to removing trust from mining pools and removing the power of potential future regulation, so I'm beyond excited that it is finally possible and works quite well.

If you have specific questions or need some help, please reach out via [Twitter, Threema, Matrix, or email]({{< ref "/content/about.md#how-to-contact-me" >}}).
