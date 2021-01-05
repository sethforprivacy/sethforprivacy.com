+++
title = "Run a Monero Node"
date = 2020-12-31T11:49:13-05:00
author = "Seth Simmons"
authorTwitter = "sethisimmons" #do not include @
cover = ""
tags = ["Monero", "Network", "p2p"]
keywords = ["Monero", "Node", "p2p", "network"]
description = "In this short post I'll detail how to easily run a Monero node on a Linux server, the most common OS for virtual private servers (VPS)."
summary = "In this short post I'll detail how to easily run a Monero node on a Linux server, the most common OS for virtual private servers (VPS)."
showFullContent = false
toc = true
draft = false
+++

# Introduction

With the [ongoing network attacks in Monero]({{< ref "/content/posts/moneros-ongoing-network-attack.md" >}}), it's a great time for users to dive into running their [own node](https://www.monerooutreach.org/monero_best_practices/your_own_node.html).

In this short post I'll detail how to easily run a Monero node on a Linux server, the most common OS for virtual private servers (VPS). I would highly recommend running either Debian or Ubuntu for your Linux distribution, and this guide will assume you are running one of those.

I will also assume in this guide that you have purchased and SSH'd into the VPS/host of your choosing, but if you need help with those first steps here are a few good links to follow:

- [Hosting services accepting Monero](https://www.getmonero.org/community/merchants/#hosting)
  - These are some of the options available for hosting a VPS while paying with Monero, and each come with pro's and con's.
- [Simple Linode deployment guide](https://www.pragmaticlinux.com/2020/07/setup-a-minimal-debian-10-buster-server-as-a-linode-vps/)
  - If you use Linode, consider using [my referral link](https://www.linode.com/?r=c956dbb75d14063251557a0e5003efb5ceacc74d) so we both get free credits.

If you're using your own hardware at home, this guide will still generally apply to you assuming you are running Ubuntu/Debian.

# Recommended hardware

- Full Node
  - 2+ vCPUs/cores
  - 4GB+ RAM
  - 150GB+ SSD
  
- Pruned Node
  - 2+ vCPUs/cores
  - 4GB+ RAM
  - 75GB+ SSD
        

*If you're able to get unlimited bandwidth, be sure to raise the bandwidth limits in the provided configuration files to speed up your initial sync and to provide more bandwidth to the overall Monero network.*

# Why run your own Monero node?

The Monero network relies on a distributed web of Monero nodes, each of which validate transactions, propagate transactions to the rest of the network, and helps new nodes easily and quickly synchronize to the current state of the network.

Running a Monero node for yourself not only helps to give you the stronger network-level privacy guarantees, but also helps to increase the decentralization, stability, and speed of the Monero network.

Each node can expose two different services, each of which has a positive impact on the network in a unique way:

- Peer-to-Peer (p2p) port (default 18080): this port allows other nodes on the network to connect to your node to download the blockchain and to send you any transactions they validate that you do not yet have. It also increases overall network privacy, as your node participates in the [Dandelion++](https://www.monerooutreach.org/stories/dandelion.html) propagation of transactions.
- Remote Procedure Call (RPC) port (default 18089 for restricted): Exposing this port (especially with the `public-node` arg) allows other users on the network, especially those using mobile wallets or the GUI wallet in "Simple" mode, to connect to your node to sync their wallets, without needing to run their own full node locally.

In this guide I have only given configuration files that expose the p2p port, as that is a key help to the network. Feel free to use one of the configuration files utilizing the `public-node` arg listed below if you'd also like to advertise your restricted RPC port.

# Update and install required packages

First we need to install a few tools we will need later:

```bash
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install ufw gpg wget
```

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

# Download and install monerod

Create our system user and directories for Monero configuration, PID, and log files:


```bash
# Create a system user and group to run monerod as
sudo addgroup --system monero
sudo adduser --system monero --home /var/lib/monero

# Create necessary directories for monerod
sudo mkdir /var/run/monero
sudo mkdir /var/log/monero
sudo mkdir /etc/monero

# Create monerod config file
sudo touch /etc/monero/monerod.conf

# Set permissions for new directories
sudo chown monero:monero /var/run/monero
sudo chown monero:monero /var/log/monero
sudo chown -R monero:monero /etc/monero
```

Download and verify the latest CLI binaries using [my gist](https://gist.github.com/sethsimmons/ad5848767d9319520a6905b7111dc021):

```bash
wget https://gist.githubusercontent.com/sethsimmons/ad5848767d9319520a6905b7111dc021/raw/download_monero_binaries.sh
chmod +x download_monero_binaries.sh
./download_monero_binaries.sh
```

Install the latest binaries:

```bash
tar xvf monero-linux-*.tar.bz2
rm monero-linux-*.tar.bz2
sudo cp -r monero-x86_64-linux-gnu-*/* /usr/local/bin/
sudo chown -R monero:monero /usr/local/bin/monero*
```

*Note: Full code from the gist can be found [on Github](https://gist.github.com/sethsimmons/ad5848767d9319520a6905b7111dc021).*

# Install monerod systemd script

Installing `monerod` via a systemd script allows Monero to start automatically on boot, restart on any crash, and log to a given file.

Choose the proper configuration file depending on if you want to run a full node or a pruned node and whether you want to advertise your public restricted RPC node to allow other users to sync their wallets using your node or not:

{{< code language="conf" title="monerod config file" id="0" expand="Show" collapse="Hide" isCollapsed="true" >}}
# /etc/monero/monerod.conf

# Data directory (blockchain db and indices)
data-dir=/var/lib/monero/.bitmonero  # Remember to create the monero user first

# Log file
log-file=/var/log/monero/monerod.log

# P2P full node
# p2p-bind-ip=0.0.0.0            # Bind to all interfaces (the default)
# p2p-bind-port=18080            # Bind to default port

# RPC open node
rpc-restricted-bind-ip=0.0.0.0            # Bind to all interfaces
rpc-restricted-bind-port=18089            # Bind on default port
confirm-external-bind=1        # Open node (confirm)
no-igd=1                       # Disable UPnP port mapping

# ZMQ configuration
no-zmq=1

# Block known-malicious nodes from a DNSBL
enable-dns-blocklist=1

# Set download and upload limits, if desired
# limit-rate-up=128000 # 128000 kB/s == 125MB/s == 1GBit/s; a raise from default 2048 kB/s; contribute more to p2p network
# limit-rate-down=128000 # 128000 kB/s == 125MB/s == 1GBit/s; a raise from default 2048 kB/s; contribute more to p2p network
{{< /code >}}

{{< code language="conf" title="monerod config file w/ public restricted RPC" id="1" expand="Show" collapse="Hide" isCollapsed="true" >}}
# /etc/monero/monerod.conf

# Data directory (blockchain db and indices)
data-dir=/var/lib/monero/.bitmonero  # Remember to create the monero user first

# Log file
log-file=/var/log/monero/monerod.log

# P2P full node
# p2p-bind-ip=0.0.0.0            # Bind to all interfaces (the default)
# p2p-bind-port=18080            # Bind to default port

# RPC open node
public-node=1                             # Advertise the RPC-restricted port over p2p peer lists
rpc-restricted-bind-ip=0.0.0.0            # Bind to all interfaces
rpc-restricted-bind-port=18089            # Bind on default port
confirm-external-bind=1                   # Open node (confirm)
no-igd=1                                  # Disable UPnP port mapping

# ZMQ configuration
no-zmq=1

# Block known-malicious nodes from a DNSBL
enable-dns-blocklist=1

# Set download and upload limits, if desired
# limit-rate-up=128000 # 128000 kB/s == 125MB/s == 1GBit/s; a raise from default 2048 kB/s; contribute more to p2p network
# limit-rate-down=128000 # 128000 kB/s == 125MB/s == 1GBit/s; a raise from default 2048 kB/s; contribute more to p2p network
{{< /code >}}

{{< code language="conf" title="monerod config file (pruned)" id="2" expand="Show" collapse="Hide" isCollapsed="true" >}}
# /etc/monero/monerod.conf

# Data directory (blockchain db and indices)
data-dir=/var/lib/monero/.bitmonero  # Remember to create the monero user first

# Log file
log-file=/var/log/monero/monerod.log

# Pruning
prune-blockchain=1

# P2P full node
# p2p-bind-ip=0.0.0.0            # Bind to all interfaces (the default)
# p2p-bind-port=18080            # Bind to default port

# RPC open node
rpc-restricted-bind-ip=0.0.0.0            # Bind to all interfaces
rpc-restricted-bind-port=18089            # Bind on default port
confirm-external-bind=1        # Open node (confirm)
no-igd=1                       # Disable UPnP port mapping

# ZMQ configuration
no-zmq=1

# Block known-malicious nodes from a DNSBL
enable-dns-blocklist=1

# Set download and upload limits, if desired
# limit-rate-up=128000 # 128000 kB/s == 125MB/s == 1GBit/s; a raise from default 2048 kB/s; contribute more to p2p network
# limit-rate-down=128000 # 128000 kB/s == 125MB/s == 1GBit/s; a raise from default 2048 kB/s; contribute more to p2p network
{{< /code >}}

{{< code language="conf" title="monerod config file w/ public restricted RPC (pruned)" id="3" expand="Show" collapse="Hide" isCollapsed="true" >}}
# /etc/monero/monerod.conf

# Data directory (blockchain db and indices)
data-dir=/var/lib/monero/.bitmonero  # Remember to create the monero user first

# Log file
log-file=/var/log/monero/monerod.log

# Pruning
prune-blockchain=1

# P2P full node
# p2p-bind-ip=0.0.0.0            # Bind to all interfaces (the default)
# p2p-bind-port=18080            # Bind to default port

# RPC open node
public-node=1                             # Advertise the RPC-restricted port over p2p peer lists
rpc-restricted-bind-ip=0.0.0.0            # Bind to all interfaces
rpc-restricted-bind-port=18089            # Bind on default port
confirm-external-bind=1                   # Open node (confirm)
no-igd=1                                  # Disable UPnP port mapping

# ZMQ configuration
no-zmq=1

# Block known-malicious nodes from a DNSBL
enable-dns-blocklist=1

# Set download and upload limits, if desired
# limit-rate-up=128000 # 128000 kB/s == 125MB/s == 1GBit/s; a raise from default 2048 kB/s; contribute more to p2p network
# limit-rate-down=128000 # 128000 kB/s == 125MB/s == 1GBit/s; a raise from default 2048 kB/s; contribute more to p2p network
{{< /code >}}

Now copy and paste the configuration file you want to use:

```bash
sudo nano /etc/monero/monerod.conf
```

*To escape from the nano shell and save the file, hit `ctrl+x`.*

Simply copy the contents of the systemd script below and save it to `/etc/systemd/system/monerod.service` using vim or nano:

{{< code language="systemd" title="monerod systemd script" id="4" expand="Show" collapse="Hide" isCollapsed="false" >}}
[Unit]
Description=Monero Full Node (Mainnet)
After=network.target

[Service]
User=monero
Group=monero
WorkingDirectory=~
RuntimeDirectory=monero

# Clearnet config
Type=forking
PIDFile=/var/run/monero/monerod.pid
ExecStart=/usr/local/bin/monerod --config-file=/etc/monero/monerod.conf --pidfile /var/run/monero/monerod.pid --detach
Restart=always
RestartSec=30

[Install]
WantedBy=multi-user.target
{{< /code >}}

```bash
sudo nano /etc/systemd/system/monerod.service
```

*To escape from the nano shell and save the file, hit `ctrl+x`.*

Then run the following to start `monerod`:
```bash
sudo systemctl daemon-reload
sudo systemctl start monerod
sudo tail -f /var/log/monero/monerod.log
```

You should see `monerod` start up properly there and tell you it is synchronizing with the network!

# Updating your Monero node

Whenever a new version is released, you'll want to update as soon as possible to ensure you have the latest fixes, improvements, and features available.

Download the new binaries:

```bash
cd ~
./download_monero_binaries.sh
```

Install the new binaries and restart `monerod`:

```bash
tar xvf monero-linux-*.tar.bz2
rm monero-linux-*.tar.bz2
sudo systemctl stop monerod
sudo cp -r monero-x86_64-linux-gnu-*/* /usr/local/bin/
sudo chown -R monero:monero /usr/local/bin/monero*
sudo systemctl start monerod
```

That will download the latest binaries, replace the old ones, and restart `monerod` with the latest version!

# Port forwarding

If you decide to use this guide on a device on your home network, you will need to be sure to port forward `18080/tcp` and `18089/tcp` through your router.

A good central site with a lot of guides for specific routers can be found at [portforward.com](https://portforward.com/router.htm). Just make sure to select your proper router make and model, and then open 18080/18089 for TCP only.

# Connecting to your new remote node

This will depend on the wallet you've chosen to use, but usually just entails specifying the IP address of your node (either your home IP address or that of your VPS-provided host).

An example of how to do this in the main desktop wallet [is provided here.](https://www.getmonero.org/resources/user-guides/remote_node_gui.html)

# Using anonymity networks

This guide only walks you through setting up a node over clearnet, which is the standard configuration and the most straightforward to handle.

If you're interested in exploring Tor or i2p configurations for your node, you can take a look at [the official docs on Github](https://github.com/monero-project/monero/blob/master/docs/ANONYMITY_NETWORKS.md) for more info, and I'll hopefully be able to add in those steps here for those interested down the road.

# Sending commands to your node

`monerod` support sending commands locally to the unrestricted RPC via the `monerod` binary when detached, allowing you get additional info on the status of `monerod`, set bandwidth limits, increase peer limits, etc.

A full list of commands as of `v0.17.1.8` can be found below, or by running `monerod help`:

{{< code language="help" title="monerod help output" id="5" expand="Show" collapse="Hide" isCollapsed="false" >}}
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

When you want to run a command, simply run `monerod name_of_command` and it will automatically connect to the daemon, run the command, and print the output of that command to the terminal.

A few of my most commonly used commands are:

- `monerod status`: get a short output on the status of `monerod`, including peer counts (both out and in), block height, sync status, and version
- `monerod sync_info`: print a list of peers with info on their status and what syncing your node is doing with them
- `monerod print_net_stats`: print network statistics since `monerod` started, including received and sent traffic total, average rates, and the limits set
- `monerod update check`: check if an updated version of `monerod` has been released

# Conclusion

Hopefully this guide simplified the process of setting up a remote node on a VPS, and many more similar guides should be popping up shortly.

I used the commands and info in this guide to kick off a new remote node on Linode, feel free to utilize it for wallet sync, add it as a priority peer, etc:

`node.sethsimmons.me:18089`

Please reach out via [Twitter, Keybase, or email]({{< ref "/content/about.md" >}}) if you have any questions, think a step needs clarification, or need further help getting up and running.

Thanks!