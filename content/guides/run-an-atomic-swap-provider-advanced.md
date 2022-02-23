---
author: Seth For Privacy
comments: false
date: "2021-08-24T22:00:00-04:00"
summary: This guide will walk you through how to act as a provider (also known
  as a seller or "automatic swap backend" (ASB)).
draft: false
hidemeta: false
showToc: true
tags:
- Atomic swaps
- Bitcoin
- Monero
title: Run an atomic swap provider (Advanced)
---

# Introduction

***DISCLAIMER -- If you read through this guide and do not have a solid grasp for how the installation works and how the ASB tool works, please first test out the software on testnet, *not* mainnet. This guide is intended for those serious about running an ASB and who understand the implications and are able to handle the cutting edge software itself.***

It's been a long time coming, but it's finally here. You can, *today*, swap Bitcoin <> Monero directly peer-to-peer, over Tor, with no custodian or trusted 3rd-party, no KYC (Know Your Customer) info, nothing. This guide will walk you through how to act as a provider (also known as a seller or "automatic swap backend" [ASB]).

This is the future of cross-chain swaps, and it's possible today.

Atomic swaps open up a wide variety of cross-chain use-cases, but the key thing is that they are trustless, uncensorable, and completely anonymous/pseuodonymous.

For more info on atomic swaps, check out the links below:

- <https://localmonero.co/knowledge/monero-atomic-swaps>
- <https://www.monerooutreach.org/stories/monero-atomic-swaps.html>
- <https://github.com/comit-network/xmr-btc-swap>
- <https://comit.network/blog/2020/10/06/monero-bitcoin/>

# Background

This guide will be an attempt to simplify and distill the things I have learned from running an ASB for testing myself, as well as give a simpler copy-paste format for getting up and running. This initial build out is a bit more advanced, but I am working on a Docker Compose setup that should be much simpler to get started with and keep up to date.

The official guide can be found here, and is enough to get started if you'd rather refer to those docs:

- <https://github.com/comit-network/xmr-btc-swap/blob/master/docs/asb/README.md>

To better understand what the `asb` tool is doing, why you need to run it to sell XMR, and how it interacts with the `swap` tool, read the portion of the official guide below:

- <https://github.com/comit-network/xmr-btc-swap/blob/master/docs/asb/README.md#setup-details>

If you'd like to go deeper into how the protocol works and the specifics around each step in the swap process (which I recommend), you can do so at the below blog post:

- <https://comit.network/blog/2020/10/06/monero-bitcoin>

# Understanding the steps in the swap process

I won't rewrite this out in my guide, as it's well laid out in the COMIT network blog post. I would *highly* suggest getting familiar with the swap process and reading through as much of the doc as you can understand above, but the most relevant section is here:

- <https://comit.network/blog/2020/10/06/monero-bitcoin/#long-story-short>

# Maintaining privacy/anonymity

It's important that you understand that running this tool will allow users on the CLI side to link transaction IDs with an IP address unless you use Tor for all networking. Here are some quick recommendations for protecting your own privacy and/or anonymity while running the tool:

- *Never* run this tool from home unless you are using Tor-only, and not exposing any clearnet addresses
  - If you are running at home, *never* expose the machine running this software to the internet over SSH if at all possible
- Unless you have a specific reason or want to ensure that those without Tor access/without an understanding of Tor can swap with you, only use the `asb` tool behind Tor
- If you need to share logs for any reason, be sure to redact:
  - Swap IDs
  - Transaction IDs
  - IP addresses
- [Run your own Monero node]({{< ref "/content/guides/run-a-monero-node.md" >}})
- If possible, run your own Bitcoin node and [ElectrumX server](https://electrumx-spesmilo.readthedocs.io/en/latest/)
- Use a Bitcoin privacy tool like [Samourai Wallet](https://www.samouraiwallet.com/) to protect your privacy and protect you from tainted Bitcoin after receiving funds from swaps
  - For more on Bitcoin privacy, checkout BitcoinQnA's posts on the topic here: <https://bitcoiner.guide/privacy/>
  - For specifically how to use Samourai Wallet, see his guide here: <https://bitcoiner.guide/privacy/separate/>

# Pre-requisites

This guide will assume the below things are already in place:

- You already have a computer/server in place to host this tool (preferrably a VPS or dedicated server hosted for you)
- You are able to get to a command line on the host you want to use for the tool
- If you want to use DNS, you already have a domain name and are comfortable configuring DNS
- You are either running your own Monero node or have one handy that you trust
  - Anyone is more than welcome to use my [public Monero node]({{< ref "/content/about.md#high-performance-monero-nodes" >}})
- You already have some Monero you are willing to sell via the ASB
- You are comfortable sending and receiving Monero
- You are comfortable handling potentially tainted Bitcoin via a tool like [Samourai Wallet](https://www.samouraiwallet.com/)

# Getting the tools

This guide will also assume you are using Linux, but commands should be similar for macOS and roughly similar for Windows. The first step in getting started is getting all the tools you'll need.

## Automated swap broker (ASB)

1. Create a folder to keep all of our relevant files in

    ```bash
    mkdir ~/asb
    cd ~/asb
    ```

2. Download the latest release of the `asb` tool, i.e. `asb_0.10.0_Linux_x86_64.tar` via your browser
    1. <https://github.com/comit-network/xmr-btc-swap/releases/latest>
    2. Alternatively you can download the tool via the CLI

        ```bash
        wget https://github.com/comit-network/xmr-btc-swap/releases/download/0.10.0/asb_0.10.0_Linux_x86_64.tar
        ```

3. Extract the `asb` binary
    1. Open the Terminal
    2. Run the following commands:

        ```bash
        tar xvf asb_0.10.0_Linux_x86_64.tar
        rm asb_0.10.0_Linux_x86_64.tar
        sudo chmod +x asb
        sudo cp asb /usr/local/bin/
        ```

4. Verify the binary is working properly

    ```bash
    asb --version
    ```

{{< figure src="/run-an-atomic-swap-provider-advanced/asb-version.png" align="center" style="border-radius: 8px;" >}}

## monero-wallet-rpc

1. Download the latest release of the Monero binaries, i.e. `monero-linux-x64-v0.17.2.3.tar.bz2`
    1. <https://github.com/monero-project/monero/releases/latest>
    2. Alternatively you can download the tool via the CLI

        ```bash
        cd ~/asb
        wget https://downloads.getmonero.org/cli/monero-linux-x64-v0.17.2.3.tar.bz2
        ```

2. Extract the `monero-wallet-rpc` binary
    1. Open the Terminal
    2. Run the following commands:

        ```bash
        tar xvf monero-linux-x64-v0.17.2.3.tar.bz2
        sudo chmod +x monero-x86_64-linux-gnu-v0.17.2.3/monero-wallet-rpc
        sudo cp monero-x86_64-linux-gnu-v0.17.2.3/monero-wallet-rpc /usr/local/bin
        rm monero-linux-x64-v0.17.2.3.tar.bz2
        rm -rf monero-x86_64-linux-gnu-v0.17.2.3
        ```

3. Verify the binary is working properly

    ```bash
    monero-wallet-rpc --version
    ```

{{< figure src="/run-an-atomic-swap-provider-advanced/monero-wallet-rpc-version.png" align="center" style="border-radius: 8px;" >}}

## Tor daemon

- If you're on Debian, simply run the following command to install and start Tor

    ```bash
    sudo apt-get install tor
    sudo systemctl enable tor
    sudo systemctl start tor
    ```

- If you're on Ubuntu, use the Tor-provided repository by following their official docs
  - <https://support.torproject.org/apt/tor-deb-repo/>
  - Once you've configured the Tor repository, run the following commands to install and start Tor

    ```bash
    sudo apt install tor deb.torproject.org-keyring
    sudo systemctl enable tor
    sudo systemctl start tor
    ```

- If you're on CentOS/RHEL, use the Tor-provided repository by following their official docs
  - <https://support.torproject.org/rpm/>
  - Once you've configured the Tor repository, run the following commands to install and start Tor

    ```bash
    sudo yum install tor
    sudo systemctl enable tor
    sudo systemctl start tor
    ```

# Initial Hardening via UFW

We will want to make sure that the system is hardened in a simple way by making sure that the firewall is locked down to only allow access to the ports necessary for SSH and `asb`, using UFW.

A great intro to getting started with UFW is available [on Landchad.net](https://landchad.net/ufw).

Run the following commands to add some basic UFW rules and enable the firewall:

```bash
# Deny all non-explicitly allowed ports
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow SSH access
sudo ufw allow ssh

# Allow the default ASB ports (remove the following two lines if running exclusively over Tor, as they are not needed)
sudo ufw allow 9939/tcp
sudo ufw allow 9940/tcp

# Enable UFW
sudo ufw enable
```

# Configuring the tools

## Setting up the asb user and directories

We'll set up a unique user for these two tools and the directories we will need below.

```bash
# Create a system user and group to run asb and monero-wallet-rpc as
sudo addgroup --system asb
sudo adduser --system asb --home /var/lib/asb

# Create necessary directories for the asb tools
sudo mkdir /var/run/asb
sudo mkdir /var/log/asb
sudo mkdir /etc/asb

# Set permissions for new directories
sudo chown asb:asb /var/run/asb
sudo chown asb:asb /var/log/asb
sudo chown -R asb:asb /etc/asb
```

## monero-wallet-rpc systemd config

`monero-wallet-rpc` is what that the `asb` tool will use to connect to the Monero blockchain, manage Monero funds, and sign/send transactions as needed for each swap.

The easiest way to run this automatically with the correct options is to simply copy the contents of the systemd script below and save it to `/etc/systemd/system/monero-wallet-rpc.service` using vim or nano:

```bash
sudo nano /etc/systemd/system/monero-wallet-rpc.service
```

*To escape from the nano shell and save the file, hit `ctrl+x`.*

***NOTE: If you are not running a Monero node on the same host, be sure to replace the `127.0.0.1:18089` daemon-host arg with the appropriate Monero daemon URL, i.e. `node.sethforprivacy.com:18089`.***

```systemd
[Unit]
Description=Monero Wallet RPC (Mainnet)
After=network.target

[Service]
# Process management
####################

Type=forking
PIDFile=/var/run/asb/monero-wallet-rpc.pid
ExecStart=/usr/local/bin/monero-wallet-rpc --pidfile /var/run/asb/monero-wallet-rpc.pid --daemon-host 127.0.0.1:18089 --rpc-bind-port 18083 --disable-rpc-login --wallet-dir /etc/asb --detach --log-file /var/log/asb/monero-wallet-rpc.log
Restart=on-failure
RestartSec=30

# Directory creation and permissions
####################################

# Run as asb:asb
User=asb
Group=asb

# /run/asb
RuntimeDirectory=asb
RuntimeDirectoryMode=0710

# /var/lib/asb
StateDirectory=asb
StateDirectoryMode=0710

# /var/log/asb
LogsDirectory=asb
LogsDirectoryMode=0710

# /etc/asb
ConfigurationDirectory=asb
ConfigurationDirectoryMode=0710

# Hardening measures
####################

# Provide a private /tmp and /var/tmp.
PrivateTmp=true

# Mount /usr, /boot/ and /etc read-only for the process.
ProtectSystem=full

# Deny access to /home, /root and /run/user
ProtectHome=true

# Disallow the process and all of its children to gain
# new privileges through execve().
NoNewPrivileges=true

[Install]
WantedBy=multi-user.target
```

## Automated swap broker (ASB) systemd config

The easiest way to run this automatically with the correct options is to simply copy the contents of the systemd script below and save it to `/etc/systemd/system/asb.service` using vim or nano:

```bash
sudo nano /etc/systemd/system/asb.service
```

*To escape from the nano shell and save the file, hit `ctrl+x`.*

```systemd
[Unit]
Description=Automated swap broker (ASB)
After=network.target monero-wallet-rpc.service

[Service]
# Process management
####################

Type=simple
ExecStart=/usr/local/bin/asb --config /etc/asb/config.toml start
StandardOutput=append:/var/log/asb/asb.log

# Directory creation and permissions
####################################

# Run as asb:asb
User=asb
Group=asb

# /var/log/asb
LogsDirectory=asb
LogsDirectoryMode=0710

# /etc/asb
ConfigurationDirectory=asb
ConfigurationDirectoryMode=0710

# Hardening measures
####################

# Provide a private /tmp and /var/tmp.
PrivateTmp=true

# Mount /usr, /boot/ and /etc read-only for the process.
ProtectSystem=full

# Deny access to /home, /root and /run/user
ProtectHome=true

# Disallow the process and all of its children to gain
# new privileges through execve().
NoNewPrivileges=true

[Install]
WantedBy=multi-user.target
```

## ASB configuration file

This configuration file will dictate how the `asb` tool, so be sure to change parameters as you see fit.

Here are the key parameters you *must* change:

- `external_addresses` should reflect the reachable external addresses
  - If doing a Tor-only ASB, you will need to start the ASB once, copy the `/onion3/` addresses listed there, and add them in like:

    ```conf
    external_addresses = ["/onion3/b4wfknratwn6rcpvpczs5pgtyyafedpcfjqnupr32qdfu63x6odql4id:9939", "/onion3/b4wfknratwn6rcpvpczs5pgtyyafedpcfjqnupr32qdfu63x6odql4id:9940"]
    ```

  - If using IPv4 addresses without DNS, use an entry like:

    ```conf
    external_addresses = ["/ip4/5.9.120.18/tcp/9939", "/ip4/5.9.120.18/tcp/9940/ws"]
    ```

  - If using DNS, use an entry like:

    ```conf
    external_addresses = ["/dns4/swap.sethforprivacy.com/tcp/9939", "/dns4/swap.sethforprivacy.com/tcp/9940/ws"]
    ```

  - If you're comfortable with advanced DNS configs, explore using the `/dnsaddr` format using the docs below
    - <https://github.com/multiformats/multiaddr/blob/master/protocols/DNSADDR.md>

Here are some key parameters you should change:

- `min_buy_btc` should reflect the minimum size in BTC you would like swap participants to be able to offer
- `max_buy_btc` should reflect the maximum size in BTC you would like swap participants to be able to offer
- `ask_spread` should be set to your preferred spread (percentage on top of market price you will charge)
  - `0.05` is equal to 5%, `0.10` is equal to 10%, etc.
- `electrum_rpc_url` if you run your own Electrum server, or have one you trust more than the default

1. Create the configuration for the asb process

    ```bash
        sudo nano /etc/asb/config.toml
    ```

    *To escape from the nano shell and save the file, hit `ctrl+x`.*

    ```ini
    [data]
    dir = "/etc/asb"

    [network]
    listen = ["/ip4/0.0.0.0/tcp/9939", "/ip4/0.0.0.0/tcp/9940/ws"]
    rendezvous_point = "/dnsaddr/swap.sethforprivacy.com/p2p/12D3KooWCULyZKuV9YEkb6BX8FuwajdvktSzmMg4U5ZX2uYZjHeu"
    # Example external_addresses: 
    external_addresses = ["/onion3/example.onion/tcp/9939", "/onion3/example.onion/tcp/9940/ws"]

    [bitcoin]
    electrum_rpc_url = "ssl://electrum.blockstream.info:50002"
    target_block = 3
    network = "Mainnet"

    [monero]
    wallet_rpc_url = "http://127.0.0.1:18083/json_rpc"
    network = "Mainnet"

    [tor]
    control_port = 9051
    socks5_port = 9050

    [maker]
    min_buy_btc = 0.0005
    max_buy_btc = 0.001
    ask_spread = 0.05
    price_ticker_ws_url = "wss://ws.kraken.com/"
    ```

    Other recommended rendezvous nodes that can be used instead of mine int he configuration above:

    ```bash
    /dns4/rendezvous.xmr.radio/tcp/8888/p2p/12D3KooWN3n2MioS515ek6LoUBNwFKxtG2ribRpFkVwJufSr7ro7
    ```

2. Reload `systemd` to enable the new systemd scripts:

    ```bash
    sudo systemctl daemon-reload
    ```

## Tor configuration

In order for the `asb` tool to be able to properly configure the hidden services for itself, you will need to add 3 lines to the Tor config file at `/etc/tor/torrc`, add your newly created user to the `debian-tor` group, and restart `tor`.

1. Edit the Tor config file at `/etc/tor/torrc` using vim or nano to configure Tor to allow `asb` to setup and configure a hidden service:

    ```bash
    sudo nano /etc/tor/torrc
    ```

    *To escape from the nano shell and save the file, hit `ctrl+x`.*

    ```conf
    # Allow asb tool to configure hidden services
    ControlPort 9051
    CookieAuthentication 1
    CookieAuthFileGroupReadable 1
    ```

2. Run the following commands to add `asb` user to the `debian-tor` group and restart `tor`:

    ```bash
    sudo adduser asb debian-tor
    sudo systemctl restart tor
    ```

# Using the tools

## Starting monero-wallet-rpc and asb

In order to start the tools, simply run the appropriate commands below:

1. `monero-wallet-rpc` should always be started first:

    ```bash
    sudo systemctl start monero-wallet-rpc
    ```

2. Then start `asb`:

    ```bash
    sudo systemctl start asb
    ```

## Restarting monero-wallet-rpc and asb

In order to restart the tools, simply run the appropriate commands below:

1. `monero-wallet-rpc` should always be restarted first:

    ```bash
    sudo systemctl restart monero-wallet-rpc
    ```

2. Then restart `asb`:

    ```bash
    sudo systemctl restart asb
    ```

# Fund your Monero wallet

On startup the ASB tool will provide you with a Monero address to use for depositing funds to the Monero wallet.

1. To get the address, run the following command:

    ```bash
    sudo grep monero_address /var/log/asb/asb.log
    ```

2. Make sure to save the address, as once you deposit funds it will no longer be shown.
    To get a QR code for the address natively on your machine, you can run the following command (replacing the address with your own gathered above, of course):

    ```bash
    qrencode "4A4tLy1b2PFFdHHvZubb85enYMroBZ3b3i8AV45gBATb2Kas1jNmVP3BwGq4HhSMwsfuedh2hK6MBMmG8M6KAvGGDVBqLDw" -t ascii -o -
    ```

    If `qrencode` is not installed, you can install it with `sudo apt install qrencode` or `sudo dnf install qrencode`

    If you fail to save the address before depositing funds, you can get it directly from `monero-wallet-rpc` via the following command:

    ```bash
    curl http://127.0.0.1:18083/json_rpc -d '{"jsonrpc":"2.0","id":"0","method":"get_address","params":{"account_index":0,"address_index":[0]}}' -H 'Content-Type: application/json'
    ```

3. Send Monero to the provided address, but remember that this wallet will be hot and not password protected -- you should minimize the amount of Monero in the ASB wallet as much as possible.

# Adding your new ASB to unstoppableswap.net

***NOTE: You can only add IPv4 and DNS address-based ASBs ATM, so if you are doing an onion-only ASB skip this step for now.***

1. Navigate to <https://unstoppableswap.net/>
2. Click on the "Swap provider" box

    {{< figure src="/run-an-atomic-swap-provider-advanced/unstoppable-home.png" align="center" style="border-radius: 8px;" >}}

3. Click "Submit a swap provider"

    {{< figure src="/run-an-atomic-swap-provider-advanced/unstoppable-providers.png" align="center" style="border-radius: 8px;" >}}

4. Enter your external_address and peer ID

    To get your peer ID, simply run the following command:

    ```bash
    sudo grep peer_id /var/log/asb/asb.log
    ```

    {{< figure src="/run-an-atomic-swap-provider-advanced/unstoppable-submit.png" align="center" style="border-radius: 8px;" >}}

5. Click "Submit

# Handling problems during swaps

It's important that you keep an eye on logs, especially during the first few swaps to ensure that your configuration is good to go.

To view logs, simply run the following command:

```bash
sudo tail -f /var/log/asb/asb.log
```

If you see lines beginning with `ERROR` during a failed swap, check for existing issues reported on Github by searching at the below URL:

- <https://github.com/comit-network/xmr-btc-swap/issues>

If there is no open issue for the problem you're experiencing, be sure to open a new one with as much detail as possible, including:

- Version of `asb`
  - Gather by running `asb --version`
- All log lines around the failed swap/issue
  - Be sure to redact IP addresses, swap IDs, etc. as mentioned at the [beginning of this article]({{< ref "#maintaining-privacy-anonymity" >}})!
- What OS and version you're running `asb` on
- Any additional details you can provide around the issue

Most issues can be resolved via a simple [restart of the `asb` tool]({{< ref "#restarting-monero-wallet-rpc-and-asb" >}}), but gather logs before restarting to ensure you can track down the issue later if necessary.

# Withdrawing Bitcoin from the ASB wallet

When swaps complete, the `asb` tool stores the Bitcoin in an internal wallet. Whenever you want to withdraw BTC from that wallet, you will need to stop the `asb` tool, withdraw the BTC, and start the `asb` tool again.

To do so, run the following commands, substituting your Bitcoin address and the preferred amount:

```bash
sudo systemctl stop asb
asb withdraw-btc --address BITCOINADDRESS --amount "0.XX BTC"
sudo systemctl start asb
```

If you'd like to withdraw the entire balance, simply run:

*NOTE: There is currently a bug preventing this command from working, so for now just withdraw the amount via the above set of commands: <https://github.com/comit-network/xmr-btc-swap/issues/662>*

```bash
sudo systemctl stop asb
asb withdraw-btc --address <BITCOINADDRESS>
sudo systemctl start asb
```

# Checking Bitcoin and Monero balances

The easiest way to check the current balances in both wallets is to stop the ASB process and run `asb balance`:

```bash
sudo systemctl stop asb
asb balance
sudo systemctl start asb
```

If you'd like to check the Monero balance without stopping the ASB, you can run:

```bash
curl http://127.0.0.1:18083/json_rpc -d '{"jsonrpc":"2.0","id":"0","method":"get_balance","params":{"account_index":0,"address_indices":[0]}}' -H 'Content-Type: application/json'
```

# Upgrading the tools

Both tools required need to be kept up to date, so to simplify the process here is a quick set of commands to update both.

Just replace the download URL with that of the latest version.

## monero-wallet-rpc

```bash
cd ~/asb
wget https://downloads.getmonero.org/cli/monero-linux-x64-v0.17.2.0.tar.bz2
tar xvf monero-linux-x64-v0.17.2.0.tar.bz2
sudo chmod +x monero-x86_64-linux-gnu-v0.17.2.0/monero-wallet-rpc
sudo mv -f monero-x86_64-linux-gnu-v0.17.2.0/monero-wallet-rpc /usr/local/bin/
rm monero-linux-x64-v0.17.2.0.tar.bz2
rm -rf monero-x86_64-linux-gnu-v0.17.2.0
```

## asb

```bash
cd ~/asb
wget https://github.com/comit-network/xmr-btc-swap/releases/download/0.8.1/asb_0.8.1_Linux_x86_64.tar
tar xvf asb_0.8.1_Linux_x86_64.tar
rm asb_0.8.1_Linux_x86_64.tar
sudo chmod +x asb
sudo mv -f asb /usr/local/bin/
```

# Advanced configuration options

This section is absolutely not necessary to follow when spinning up an ASB, but will contain some advanced options available to you as the ASB owner.

## Using /dnsaddr format for external_address

One of the cool features baked into `libp2p`, the networking base for COMIT atomic swaps, is the ability to use a unified address to describe all possible reachable methods for your ASB with one single address. This allows you to have the ASB reachable via IP, DNS, and Onionv3 while providing users of the swap with a single unified address that allows their client to select the best option for their network configuration and/or Tor usage.

For more details on the spec and configuration available/needed, see the official docs here: <https://github.com/multiformats/multiaddr/blob/master/protocols/DNSADDR.md>

To configure this, you will need to add TXT DNS records for your domain name, one for each address you would like to advertise via the `/dnsaddr` entry.

1. Configure the desired reachability via `listen` and Tor configuration

    Usually this is just the default listen options and enabling the Tor configuration as mentioned previously in this guide.

2. Add TXT records via your domain provider with the host entry of `_dnsaddr` and a record like the below, customizing it based on your Onion address(es) and other preferred reachable endpoints:

    *Note: This example is for Namecheap, but all domain providers should allow similar TXT record customization.*

    {{< figure src="/run-an-atomic-swap-provider-advanced/dnsaddr-entries.png" align="center" style="border-radius: 8px;" >}}

    ```bash
    dnsaddr=/ip4/5.9.120.18/tcp/9939/p2p/12D3KooWCPcfhr6e7V7NHoKWRxZ5zPRr6v5hGrVPhHdsftQk2DXW
    dnsaddr=/ip4/5.9.120.18/tcp/9940/ws/p2p/12D3KooWCPcfhr6e7V7NHoKWRxZ5zPRr6v5hGrVPhHdsftQk2DXW
    dnsaddr=/onion3/b4wfknratwn6rcpvpczs5pgtyyafedpcfjqnupr32qdfu63x6odql4id:9939/p2p/12D3KooWCPcfhr6e7V7NHoKWRxZ5zPRr6v5hGrVPhHdsftQk2DXW
    dnsaddr=/onion3/b4wfknratwn6rcpvpczs5pgtyyafedpcfjqnupr32qdfu63x6odql4id:9940/p2p/12D3KooWCPcfhr6e7V7NHoKWRxZ5zPRr6v5hGrVPhHdsftQk2DXW
    ```

    Each entry must begin with `dnsaddr=` and include the `/p2p/peer_id` post-fix as seen above.

3. Validate the DNS entries work properly via `dig` and `swap` tests

    `dig +short txt _dnsaddr.DOMAIN.NAME` should return similar output to the below:

    ```bash
    dig +short txt _dnsaddr.swap.sethforprivacy.com
    "dnsaddr=/ip4/5.9.120.18/tcp/9939/p2p/12D3KooWCPcfhr6e7V7NHoKWRxZ5zPRr6v5hGrVPhHdsftQk2DXW"
    "dnsaddr=/ip4/5.9.120.18/tcp/9940/ws/p2p/12D3KooWCPcfhr6e7V7NHoKWRxZ5zPRr6v5hGrVPhHdsftQk2DXW"
    "dnsaddr=/onion3/b4wfknratwn6rcpvpczs5pgtyyafedpcfjqnupr32qdfu63x6odql4id:9939/p2p/12D3KooWCPcfhr6e7V7NHoKWRxZ5zPRr6v5hGrVPhHdsftQk2DXW"
    "dnsaddr=/onion3/b4wfknratwn6rcpvpczs5pgtyyafedpcfjqnupr32qdfu63x6odql4id:9940/p2p/12D3KooWCPcfhr6e7V7NHoKWRxZ5zPRr6v5hGrVPhHdsftQk2DXW"
    ```

    Test against your registered rendezvous point and verify the ASB shows as online:

    ```bash
    ./swap list-sellers --rendezvous-point /dnsaddr/swap.sethforprivacy.com/p2p/12D3KooWCULyZKuV9YEkb6BX8FuwajdvktSzmMg4U5ZX2uYZjHeu
    ```

# Disclaimer

While this software has worked well for me and is good to go for mainnet, it is of course not foolproof and is still in active development. Swaps should always end in either a complete swap or both parties getting funds back, but be aware that bugs may exist and you're *very* early to atomic swaps in general.

I am not responsible for any lost funds or issues you may have with handling of Bitcoin/Monero involved in the swaps, but will try to help as much as possible if you do run into issues.

# Conclusion

Hopefully this has been a nice (relatively) simple guide to get you started providing Monero liquidity for those wanting to trustlessly swap Bitcoin for Monero via atomic swaps! Atomic swaps are an essential tool to removing trust from exchanges and removing the power of potential future regulation, so I'm beyond excited that they are finally possible and work quite well.

If you have specific questions or need some help, please reach out via [Signal, Matrix, Threema, or email]({{< ref "/content/about.md#how-to-contact-me" >}}).