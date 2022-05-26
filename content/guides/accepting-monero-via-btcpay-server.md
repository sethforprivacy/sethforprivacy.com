---
title: "Accepting Monero via Btcpay Server"
date: 2022-05-26T13:26:49-04:00
summary: "I've spun up a BTCPay Server instance for my own use and built a guide out of the process, so hopefully this will aid others wanting to accept Monero at their stores, for donations, or any other use-case get up and rolling with BTCPay Server!"
draft: true
hidemeta: false
showToc: true
tags:
---

One of the tasks I've quietly taken on in the Monero community is maintaining support for Monero in BTCPay Server, and I've realized that due to the Bitcoin focus of BTCPay Server the docs are less than ideal for Monero acceptance.

In order to help improve that, I figured I'd spin up a BTCPay Server instance for my own use and build a guide out of the process, so hopefully this will aid others wanting to accept Monero at their stores, for donations, or any other use-case get up and rolling with BTCPay Server!

For this guide I will assume you're running Ubuntu 20.04+ on a local machine or VPS, but much of the guide will easily translate to other popular Linux distributions.

## Recommended hardware

- Pruned Node (the default node type for BTCPay Server[^1]
  - 2+ vCPUs/cores
  - 4GB+ RAM
  - 100GB+ SSD
    - ~25GB are required for the pruned Bitcoin node, and ~50GB for the pruned Monero node
  
[^1]: A pruned node allows you to run your own Monero node without requiring as much disk space. Please see [the pruning Moneropedia entry](https://www.getmonero.org/resources/moneropedia/pruning.html) for more info.

## Why use BTCPay Server to accept Monero?

While there are quite a few options out there for accepting Monero as a merchant, BTCPay Server remains one of the best options for merchants due to it's complete self-sovereignty, the easy acceptance of other cryptocurrencies (like Bitcoin or Lightning), and the ability to simply spin it up.

The wide support for BTCPay Server also leads to it having many well-maintained plugins for common web platforms, and you can even enable awesome features like automatic conversion to Monero from other assets via SideShift or Fixedfloat.

BTCPay Server is still probably the best self-sovereign way to accept payments in Monero as a merchant.

## Initial Hardening via UFW

We will want to make sure that the system is hardened in a simple way by making sure that the firewall is locked down to only allow access to the ports necessary for SSH and BTCPay Server, using UFW.

A great intro to getting started with UFW is available [on DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-setup-a-firewall-with-ufw-on-an-ubuntu-and-debian-cloud-server).

Run the following commands to add some basic UFW rules and enable the firewall:

```bash
# Deny all non-explicitly allowed ports
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow SSH access
sudo ufw allow ssh

# Allow HTTP for LetsEncrypt verification
sudo ufw allow http

# Allow HTTPS for the BTCPay Server UI
sudo ufw allow https

# Enable UFW
sudo ufw enable
```

## Get a domain for your instance

In order to use BTCPay Server, you'll need a custom domain you want to use for the instance.

I recommend purchasing a domain via [Njalla](https://njal.la/) or [1984.is](https://1984.hosting/), pay in Bitcoin/Monero, and then add an entry for the public IP address of your network/VPS with the subdomain you'd like.

I, for instance, use `btcpay.sethforprivacy.com` for hosting mine.

## Prepare for installing BTCPay Server

***For the official documentation, refer to ["Full installation (for technical users)" - docs.btcpayserver.org](https://docs.btcpayserver.org/Docker/#full-installation-for-technical-users)***

Thankfully BTCPay Server makes this step extremely easy and has great documentation, so all you need to do to get the necessary files for BTCPay Server is as follows:

```bash
# Login as root
sudo su -

# Create a folder for BTCPay
mkdir BTCPayServer
cd BTCPayServer

# Clone this repository
git clone https://github.com/btcpayserver/btcpayserver-docker
cd btcpayserver-docker
```

This will create the necessary folders in the home directory of your root user and get you in the correct directory to configure and install BTCPay Server.

## Configuring BTCPay Server with Monero support

This guide will assume you want to accept Bitcoin and Monero (as that is the most common reason for choosing BTCPay Server), but feel free to use the collapsed configuration below if you *just* want to accept Monero.

In order to properly configure BTCPay Server you use something called *environment variables* to set the necessary options before installing and starting the server.

***Be sure to replace `btcpay.EXAMPLE.com` with the domain you setup previously!***

```bash
# Run btcpay-setup.sh with the right parameters
# Set the custom domain you chose to use
export BTCPAY_HOST="btcpay.EXAMPLE.com"

# Use Bitcoin on mainnet
export NBITCOIN_NETWORK="mainnet"

# Enable Bitcoin support
export BTCPAYGEN_CRYPTO1="btc"

# Enable Monero support
export BTCPAYGEN_CRYPTO2="xmr"

# opt-save-storage-xs (opens new window)will keep around 3 months of blocks (prune BTC for 25 GB)
# opt-add-tor enables Tor support for the UI and Bitcoin node
export BTCPAYGEN_ADDITIONAL_FRAGMENTS="opt-save-storage-xs;opt-add-tor"

# Enable automatic HTTPS reverse proxy + SSL certs via Nginx and LetsEncrypt
export BTCPAYGEN_REVERSEPROXY="nginx"

# Allows you to manage the BTCPay Server install from the web UI, update, etc.
export BTCPAY_ENABLE_SSH=true
```

Only Monero support:

{{< collapse >}}

```bash
# Run btcpay-setup.sh with the right parameters
# Set the custom domain you chose to use
export BTCPAY_HOST="btcpay.EXAMPLE.com"

# Enable Monero support
export BTCPAYGEN_CRYPTO1="xmr"

# opt-save-storage-xs (opens new window)will keep around 3 months of blocks (prune BTC for 25 GB)
# opt-add-tor enables Tor support for the UI and Bitcoin node
export BTCPAYGEN_ADDITIONAL_FRAGMENTS="opt-add-tor"

# Enable automatic HTTPS reverse proxy + SSL certs via Nginx and LetsEncrypt
export BTCPAYGEN_REVERSEPROXY="nginx"

# Allows you to manage the BTCPay Server install from the web UI, update, etc.
export BTCPAY_ENABLE_SSH=true
```

{{< /collapse >}}

## Configuring and installing BTCPay Server

This step is incredibly simple, as the script included with the BTCPay Server repo will download and install all of the necessary packages and Docker images you need to run for BTCPay Server.

```bash
. ./btcpay-setup.sh -i
```

This will:

- Install Docker
- Install Docker-Compose
- Make sure BTCPay starts at reboot via upstart or systemd
- Setup environment variables to use BTCPay utilities
- Add BTCPay utilities in /usr/bin
- Start BTCPay Server

Assuming all went well, you should now be able to navigate to your new BTCPay Server at the domain you chose earlier!

## Create an account and a store

The first thing you'll need to do is create an account on your new instance -- be sure to use a secure email and strong password (hopefully via a password manager like Bitwarden!) -- so that you can create stores, manage wallets, etc.

***Follow the official docs to do so here: [Register account - docs.btcpayserver.org](https://docs.btcpayserver.org/RegisterAccount/)***

Once you're logged in, you'll want to go ahead and create a store to manage wallets, invoices, etc. for the given store.

***Follow the official docs to do so here: [Create a store - docs.btcpayserver.org](https://docs.btcpayserver.org/CreateStore/)***

{{< figure src="/accepting-monero-via-btcpay-server/store_created.png" align="center" style="border-radius: 8px;" >}}

## Setup your Bitcoin and Monero wallets

1. Select "Setup a wallet" and select the preferred wallet option to setup your Bitcoin wallet
   1. Follow the official docs to do so here: [Wallet Setup - docs.btcpayserver.org](https://docs.btcpayserver.org/WalletSetup/)
   {{< figure src="/accepting-monero-via-btcpay-server/store_created.png" align="center" style="border-radius: 8px;" >}}
2. Go to "Settings" to configure your Monero wallet
   {{< figure src="/accepting-monero-via-btcpay-server/monero_settings.png" align="center" style="border-radius: 8px;" >}}
3. Select the "Monero" option, and then "Modify" next to the wallet
   {{< figure src="/accepting-monero-via-btcpay-server/modify_monero.png" align="center" style="border-radius: 8px;" >}}
4. Create a new Monero wallet or use an existing one using the Monero desktop wallet or CLI wallet
   1. Download the official Monero desktop wallet here: [Monero GUI Wallet - getmonero.org](https://www.getmonero.org/downloads/#gui)
   2. You'll need the wallet and key files generated to use with BTCPay Server, not just the seed phrase
5. Go to the path where the wallet file and keys are stored
   1. These files are usually stored in your user directory under the "Monero" folder in a "Wallets" folder
6. Upload the Monero wallet file and keys to the respective options in the "Monero" wallet options (along with the wallet password, if desired!), and hit save

Now just wait for the Bitcoin and Monero nodes to sync, and you should be all set!

## Using your BTCPay Server instance

Thankfully the docs for using BTCPay Server are *excellent* and all apply exactly the same way to Monero as to Bitcoin usage:

[User Guide - docs.btcpayserver.org](https://docs.btcpayserver.org/Guide/)

When a user is prompted to pay an invoice, now they can select Monero from the dropdown and pay without any extra hoops or unique back-ends!

If you'd like to see what the payment flow looks like for a simple donation/PoS, you can try it out below (feel free to not send funds and just click through if you'd like!):

{{< btcpayserver >}}

## Conclusion

A huge, huge thank you to the contributors who have made BTCPay Server possible and who continue to improve it, and to those in the space contributing financially to the project to ensure it continues to grow.

Such a powerful payment processor having solid Monero support is a huge win, and I hope more merchants will start to use BTCPay Server for accepting Monero (and Bitcoin!) ASAP.

As always, if you have any questions from this post or would like more information on accepting Monero as a merchant or using BTCPay Server, please reach out via [Signal, Matrix, Threema, or email]({{< ref "/content/about.md#how-to-contact-me" >}}).
