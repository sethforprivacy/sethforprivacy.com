+++
title = "Run a Monero Node"
date = 2020-12-31T11:49:13-05:00
author = "Seth Simmons"
authorTwitter = "sethisimmons" #do not include @
cover = ""
tags = ["Monero", "Network", "p2p"]
keywords = ["Monero", "Node", "p2p", "network"]
description = "In this short post I'll detail how to easily run a Monero node using Docker on a Linux server, the most common OS for virtual private servers (VPS)."
summary = "In this short post I'll detail how to easily run a Monero node using Docker on a Linux server, the most common OS for virtual private servers (VPS)."
showFullContent = false
toc = true
draft = false
+++

# Introduction

With the [ongoing network attacks in Monero]({{< ref "/content/posts/moneros-ongoing-network-attack.md" >}}), it's a great time for users to dive into running their [own node](https://www.monerooutreach.org/monero_best_practices/your_own_node.html).

In this short post I'll detail how to easily run a Monero node on a Linux server, the most common OS for virtual private servers (VPS). I would highly recommend running either Debian or Ubuntu for your Linux distribution, and this guide will assume you are running one of those.

I will also assume in this guide that you have purchased and SSH'd into the VPS/host of your choosing, but if you need help with those first steps here are a few good links to follow:

- [Hosting services accepting Monero](https://www.getmonero.org/community/merchants/#hosting)
  - These are some options available for hosting a VPS while paying with Monero, and each come with pro's and con's.
- [Hetzner Dedicated Servers](https://www.hetzner.com/dedicated-rootserver)
  - A solid and cheap dedicated server provider based out of Germany, they do not accept Monero (yet!) but are a great choice for a high-performance node.
- [Simple Linode deployment guide](https://www.pragmaticlinux.com/2020/07/setup-a-minimal-debian-10-buster-server-as-a-linode-vps/)
  - If you use Linode, please consider using [my referral link](https://www.linode.com/?r=c956dbb75d14063251557a0e5003efb5ceacc74d) so we both get free credits.

If you're using your own hardware at home, this guide will still generally apply to you assuming you are running Ubuntu/Debian.

# Recommended hardware

- Full Node
  - 2+ vCPUs/cores
  - 4GB+ RAM
  - 175GB+ SSD
  
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

In this guide I have only given configuration files and Docker commands that expose the p2p port, as that is a key help to the network. Feel free to use one of the configuration files utilizing the `public-node` arg listed below if you'd also like to advertise your restricted RPC port.

You can choose to either [setup a node via systemd and binaries]({{< ref "run-a-monero-node-advanced.md" >}}) or deploy `monerod` as a Docker container below.

Deploying via Docker has a few key benefits, namely a simple and cross-OS compatible install along with automatic updates via [Watchtower](https://containrrr.dev/watchtower/).

*Note: If you'd love to deploy a node but this guide is still a bit too advanced for you, checkout [xmrcannon.net](https://xmrcannon.net/), a great community resource that allows you to pay in Monero to have a node spun up for you.*

# Update and install required packages

First we need to install a few tools we will need later:

```bash
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y ufw
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

*Note: This command downloads a script and runs as root directly from Docker. Please make sure you are comfortable doing this, and be wary of doing this on a personal computer. If you'd like to avoid that, please follow the official docs [here](https://docs.docker.com/engine/install/debian/#install-using-the-repository) to install from the repository.*

# Initial Hardening via UFW

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

# Enable UFW
sudo ufw enable
```

# Download and run monero via Docker

Choose the proper command set below depending on if you want to run a full node or a pruned node and whether you want to advertise your public restricted RPC node to allow other users to sync their wallets using your node or not:

Shoutout to [XMR.to](https://community.xmr.to/) for their great community tools, including the Docker container used in this guide.

An alternative Docker implementation is also available [on Github](https://github.com/lalanza808/docker-monero-node), which even includes native Grafana visualizations. This guide will focus on being extremely simple, so I'll stick to just `monerod` here.

*Note: My recommended commands are automatically expanded below, but feel free to choose one of the other 3 options as needed.*

{{< code language="bash" title="monerod Docker w/o public RPC" id="2" expand="Show" collapse="Hide" isCollapsed="true" >}}
sudo mkdir -p /var/lib/monero/.bitmonero
sudo docker run -d --restart unless-stopped --name="monerod" -p 18089:18089 -p 18080:18080 -v /var/lib/monero/.bitmonero:/monero -e RPC_BIND_PORT=18081 -e P2P_BIND_PORT=18080 xmrto/monero:most_recent_tag --data-dir /monero --rpc-restricted-bind-ip=0.0.0.0 --rpc-restricted-bind-port=18089 --no-igd --no-zmq --enable-dns-blocklist
sudo docker run -d \
    --name watchtower --restart unless-stopped \
    -v /var/run/docker.sock:/var/run/docker.sock \
    containrrr/watchtower
{{< /code >}}

{{< code language="bash" title="monerod Docker w/ public RPC" id="2" expand="Show" collapse="Hide" isCollapsed="false" >}}
sudo mkdir -p /var/lib/monero/.bitmonero
sudo docker run -d --restart unless-stopped --name="monerod" -p 18089:18089 -p 18080:18080 -v /var/lib/monero/.bitmonero:/monero -e RPC_BIND_PORT=18081 -e P2P_BIND_PORT=18080 xmrto/monero:most_recent_tag --data-dir /monero --rpc-restricted-bind-ip=0.0.0.0 --rpc-restricted-bind-port=18089 --public-node --no-igd --no-zmq --enable-dns-blocklist
sudo docker run -d \
    --name watchtower --restart unless-stopped \
    -v /var/run/docker.sock:/var/run/docker.sock \
    containrrr/watchtower
{{< /code >}}

{{< code language="bash" title="monerod Docker w/o public RPC (pruned)" id="2" expand="Show" collapse="Hide" isCollapsed="true" >}}
sudo mkdir -p /var/lib/monero/.bitmonero
sudo docker run -d --restart unless-stopped --name="monerod" -p 18089:18089 -p 18080:18080 -v /var/lib/monero/.bitmonero:/monero -e RPC_BIND_PORT=18081 -e P2P_BIND_PORT=18080 xmrto/monero:most_recent_tag --data-dir /monero --rpc-restricted-bind-ip=0.0.0.0 --rpc-restricted-bind-port=18089 --no-igd --no-zmq --enable-dns-blocklist --prune-blockchain
sudo docker run -d \
    --name watchtower --restart unless-stopped \
    -v /var/run/docker.sock:/var/run/docker.sock \
    containrrr/watchtower
{{< /code >}}

{{< code language="bash" title="monerod Docker w/ public RPC (pruned)" id="2" expand="Show" collapse="Hide" isCollapsed="true" >}}
sudo mkdir -p /var/lib/monero/.bitmonero
sudo docker run -d --restart unless-stopped --name="monerod" -p 18089:18089 -p 18080:18080 -v /var/lib/monero/.bitmonero:/monero -e RPC_BIND_PORT=18081 -e P2P_BIND_PORT=18080 xmrto/monero:most_recent_tag --data-dir /monero --rpc-restricted-bind-ip=0.0.0.0 --rpc-restricted-bind-port=18089 --public-node --no-igd --no-zmq --enable-dns-blocklist --prune-blockchain
sudo docker run -d \
    --name watchtower --restart unless-stopped \
    -v /var/run/docker.sock:/var/run/docker.sock \
    containrrr/watchtower
{{< /code >}}

To watch the logs for `monerod`, simply run:

```bash
sudo docker logs --follow monerod
```


# Updating your Monero node

As we are running Monero in a Docker container and have deployed Watchtower along with it, the node will automatically be restarted with the latest version of `monerod` whenever a new version is tagged in Github.

Nothing else needs to be done manually!

# Sending commands to your node

`monerod` supports sending commands locally, allowing you get additional info on the status of `monerod`, set bandwidth limits, set peer limits, etc.

A full list of commands as of `v0.17.1.8` can be found below, or by running `monerod help`:

{{< code language="help" title="monerod help output" id="5" expand="Show" collapse="Hide" isCollapsed="true" >}}
Monero 'Oxygen Orion' (v0.17.1.8-release)
Commands: 
  alt_chain_info [blockhash]
  apropos <keyword> [<keyword> ...]
  ban [<IP>|@<filename>] [<seconds>]
  banned <address>
  bans
  bc_dyn_stats <last_block_count>
  check_blockchain_pruning
  diff
  exit
  flush_cache [bad-txs] [bad-blocks]
  flush_txpool [<txid>]
  hard_fork_info
  help [<command>]
  hide_hr
  in_peers <max_number>
  is_key_image_spent <key_image>
  limit [<kB/s>]
  limit_down [<kB/s>]
  limit_up [<kB/s>]
  mining_status
  out_peers <max_number>
  output_histogram [@<amount>] <min_count> [<max_count>]
  pop_blocks <nblocks>
  print_bc <begin_height> [<end_height>]
  print_block <block_hash> | <block_height>
  print_cn
  print_coinbase_tx_sum <start_height> [<block_count>]
  print_height
  print_net_stats
  print_pl [white] [gray] [pruned] [publicrpc] [<limit>]
  print_pl_stats
  print_pool
  print_pool_sh
  print_pool_stats
  print_status
  print_tx <transaction_hash> [+hex] [+json]
  prune_blockchain
  relay_tx <txid>
  rpc_payments
  save
  set_bootstrap_daemon (auto | none | host[:port] [username] [password])
  set_log <level>|<{+,-,}categories>
  show_hr
  start_mining <addr> [<threads>|auto] [do_background_mining] [ignore_battery]
  status
  stop_daemon
  stop_mining
  sync_info
  unban <address>
  update (check|download)
  version
{{< /code >}}

When you want to run a command, simply run `sudo docker exec monerod /usr/local/bin/monerod name_of_command` and it will automatically connect to the daemon, run the command, and print the output of that command to the terminal.

A few of my most commonly used commands are:

- `sudo docker exec monerod /usr/local/bin/monerod status`: get a short output on the status of `monerod`, including peer counts (both out and in), block height, sync status, and version
- `sudo docker exec monerod /usr/local/bin/monerod sync_info`: print a list of peers with info on their status and what syncing your node is doing with them
- `sudo docker exec monerod /usr/local/bin/monerod print_net_stats`: print network statistics since `monerod` started, including received and sent traffic total, average rates, and the limits set
- `sudo docker exec monerod /usr/local/bin/monerod update check`: check if an updated version of `monerod` has been released

# Port forwarding

If you decide to use this guide on a device on your home network, you will need to be sure to port forward `18080/tcp` and `18089/tcp` through your router.

A good central site with a lot of guides for specific routers can be found at [portforward.com](https://portforward.com/router.htm). Just make sure to select your proper router make and model, and then open 18080/18089 for TCP only.

# Connecting to your new remote node

This will depend on the wallet you've chosen to use, but usually just entails specifying the IP address of your node (either your home IP address or that of your VPS-provided host).

An example of how to do this in the main desktop wallet [is provided here.](https://www.getmonero.org/resources/user-guides/remote_node_gui.html)

# Using anonymity networks

This guide only walks you through setting up a node over clearnet, which is the standard configuration and the most straightforward to handle.

If you're interested in exploring Tor or i2p configurations for your node, you can take a look at [the official docs on Github](https://github.com/monero-project/monero/blob/master/docs/ANONYMITY_NETWORKS.md) for more info, and I'll hopefully be able to add in those steps here for those interested down the road.


# A few helpful Linux CLI tools

A few of my favorite tools for general Linux CLI usage are below, hopefully they will help you out getting more comfortable with the CLI or keeping a closer eye on your node!

- [Oh My Zsh](https://ohmyz.sh/)
  - A great replacement for bash/sh shells, Oh My Zsh gives much better highlighting, features, and has automatic updates over git
- [vnstat](https://humdi.net/vnstat/)
  - A simple CLI tool to watch and view bandwidth usage numbers
- [htop](https://htop.dev/)
  - Gives a great overall picture of system resource usage by process, and is much more readable than `top`
- [multitail](https://www.vanheusden.com/multitail/)
  - a much more fully-featured way to view logs (especially more than one at a time)

# Conclusion

Hopefully this guide simplified the process of setting up a remote node on a VPS, and many more similar guides should be popping up shortly.

I used the commands and info in this guide to kick off a few new remote nodes on Linode and Hetzner, feel free to utilize them for wallet sync, add them as priority peers, etc:

`node-1.sethsimmons.me:18089` (high-performance node on Hetzner in Frankfurt, Germany)
`node-2.sethsimmons.me:18089` (medium-performance node on Linode in Georgia, USA)

Please reach out via [Twitter, Keybase, or email]({{< ref "/content/about.md#how-to-contact-me" >}}) if you have any questions, think a step needs clarification, or need further help getting up and running.

Thanks!