---
title: "Accepting Monero via BTCPay Server"
date: 2022-05-26T13:26:49-04:00
summary: "I've spun up a BTCPay Server instance for my own use and built a guide out of the process, so hopefully this will aid others wanting to accept Monero at their stores, for donations, or any other use-case get up and rolling with BTCPay Server!"
draft: false
showToc: true
tags:
  - Monero
  - Merchants
  - BTCPay Server
  - Node
---

One of the tasks I've taken on in the Monero community is maintaining support for Monero in BTCPay Server, and I've realized that due to the Bitcoin focus of BTCPay Server the docs are less than ideal for Monero acceptance.

In order to help improve that, I figured I'd spin up a BTCPay Server instance for my own use and build a guide out of the process, so hopefully this will aid others wanting to accept Monero at their stores, for donations, or any other use-case get up and rolling with BTCPay Server!

For this guide I will assume you're running Ubuntu 20.04+ on a local machine or VPS, but much of the guide will easily translate to other popular Linux distributions.

***A big thank you for a lot of help to [Mike Olthoff](https://twitter.com/olthoff) of [CoinCards](https://coincards.com/) and for a lot of material pulled from his WIP guide [on Github](https://github.com/astupidmoose/Monero-on-BTCPay/blob/main/README.md)***

## Recommended hardware

- Pruned Node (the default Monero node type for BTCPay Server)[^1]
  - 2+ vCPUs/cores
  - 4GB+ RAM
  - 100GB+ SSD
    - ~25GB are required for the pruned Bitcoin node, and ~50GB for the pruned Monero node
  
[^1]: A pruned node allows you to run your own Monero node without requiring as much disk space. Please see [the pruning Moneropedia entry](https://www.getmonero.org/resources/moneropedia/pruning.html) for more info.

## Why use BTCPay Server to accept Monero?

While there are quite a few options out there for accepting Monero as a merchant, BTCPay Server remains one of the best options for merchants due to it's complete self-sovereignty, the easy acceptance of other cryptocurrencies (like Bitcoin or Lightning), and the ability to simply spin it up.

The wide support for BTCPay Server also leads to it having many well-maintained plugins for common eCommerce platforms and you can even enable awesome additional features like automatic conversion to Monero from other assets via SideShift or Fixedfloat.

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

This guide will assume you want to accept Bitcoin as well as Monero (as that is the most common reason for choosing BTCPay Server over Monero-only payment processors), but feel free to use the collapsed configuration below if you *just* want to accept Monero.

In order to properly configure BTCPay Server you use something called "environment variables" to set the necessary options before installing and starting the server.

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

***If you want to also accept Lightning Network transactions, just add this command to the above:***

`export BTCPAYGEN_LIGHTNING="clightning"`

***To only enable Monero support, click the arrow to expand the configuration below:***

{{< collapse summary="Only Monero support" >}}

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

## Setup your Bitcoin and Monero wallets

### Configure the Bitcoin wallet of choice

***Skip these steps if you're only accepting Monero on your store!***

1. Select "Setup a wallet" and select the preferred wallet option to setup your Bitcoin wallet

 {{< figure src="/accepting-monero-via-btcpay-server/store_created.png" align="center" style="border-radius: 8px;" >}}

***Follow the official docs to do so here: [Wallet Setup - docs.btcpayserver.org](https://docs.btcpayserver.org/WalletSetup/)***

### Create a view-only Monero wallet via Feather Wallet

1. Download Feather Wallet here: [Feather: a free Monero desktop wallet](https://featherwallet.org/)
2. Create a new Monero wallet (skip to step 3 if you have an existing wallet you'd like to use instead)
   1. Choose "Create new wallet"
   {{< figure src="/accepting-monero-via-btcpay-server/create_wallet.png" align="center" style="border-radius: 8px;" >}}
   2. ***SAVE YOUR SEED!***
   {{< figure src="/accepting-monero-via-btcpay-server/seed.png" align="center" style="border-radius: 8px;" >}}
   3. Name your wallet as you see fit
   {{< figure src="/accepting-monero-via-btcpay-server/name_wallet.png" align="center" style="border-radius: 8px;" >}}
   4. Set a strong password for your wallet
   {{< figure src="/accepting-monero-via-btcpay-server/password_wallet.png" align="center" style="border-radius: 8px;" >}}
3. Create a view-only wallet out of the new wallet for use in BTCPay Server
   1. Select "Wallet" and then "View-only" in the top bar
   {{< figure src="/accepting-monero-via-btcpay-server/view_only_dropdown.png" align="center" style="border-radius: 8px;" >}}
   2. Select "Create view-only wallet"
   {{< figure src="/accepting-monero-via-btcpay-server/create_view_only.png" align="center" style="border-radius: 8px;" >}}
   3. Name the view-only wallet as desired and select "Save"
      1. *P.S. - I like to put "view_only" or similar in the wallet to make sure I use the correct files later on*
   {{< figure src="/accepting-monero-via-btcpay-server/name_view_only.png" align="center" style="border-radius: 8px;" >}}
   4. Set a strong password for your view-only wallet
   {{< figure src="/accepting-monero-via-btcpay-server/password_view_only.png" align="center" style="border-radius: 8px;" >}}
   5. Done!
   {{< figure src="/accepting-monero-via-btcpay-server/complete_view_only.png" align="center" style="border-radius: 8px;" >}}
4. Make a note of the location you stored the view-only wallet in, as we'll need to upload those files to BTCPay Server in the next step

### Add the view-only wallet to BTCPay Server

1. Go to "Settings" to configure your Monero wallet
   {{< figure src="/accepting-monero-via-btcpay-server/monero_settings.png" align="center" style="border-radius: 8px;" >}}
2. Select the "Monero" option, and then "Modify" next to the wallet
   {{< figure src="/accepting-monero-via-btcpay-server/modify_monero.png" align="center" style="border-radius: 8px;" >}}
3. Upload the Monero view-only wallet file and keys to the respective options in the "Monero" wallet options (along with the wallet password, if set)
   1. These files are usually stored in your user directory under the "Monero" folder in a "wallets" folder, i.e. `/home/sethforprivacy/Monero/wallets/` 
   {{< figure src="/accepting-monero-via-btcpay-server/upload_monero_wallet_files.png" align="center" style="border-radius: 8px;" >}}
4. Check the "Enable" box, and hit save

Now just wait for the Bitcoin and Monero nodes to sync, and you should be all set!

***P.S. -- if you ever need to replace the Monero wallet with another one, you cannot do it through the UI and must run this command:***

```bash
docker exec -ti btcpayserver_monero_wallet rm /wallet/* && docker restart btcpayserver_monero_wallet
```

***Once you've run that you can then upload new wallet files as you did during the initial setup.*** 

## Using your BTCPay Server instance

Thankfully the docs for using BTCPay Server are *excellent* and all apply exactly the same way to Monero as to Bitcoin usage:

[User Guide - docs.btcpayserver.org](https://docs.btcpayserver.org/Guide/)

When a user is prompted to pay an invoice, now they can select Monero from the dropdown and pay without any extra hoops or unique back-ends! An invoice in Monero looks like this to customers/donors:

{{< figure src="/accepting-monero-via-btcpay-server/monero_invoice.png" align="center" style="border-radius: 8px;" >}}

If you'd like to see what the payment flow looks like for a simple donation/PoS, you can try it out below (feel free to not send funds and just click through if you'd like!):

{{< btcpayserver >}}

## Contributing to Monero support in BTCPay Server

If you'd like to contribute and improve Monero support within BTCPay Server, here are the relevent repositories:

- [btcpayserver-docker](https://github.com/btcpayserver/btcpayserver-docker)
  - Specifically this file: [monero.yaml](https://github.com/btcpayserver/btcpayserver-docker/blob/master/docker-compose-generator/docker-fragments/monero.yml)
  - This file controls the way that the Monero Docker containers are started and managed
- [dockerfile-deps](https://github.com/btcpayserver/dockerfile-deps)
  - Specifically this directory: [Monero](https://github.com/btcpayserver/dockerfile-deps/tree/master/Monero)
  - The two `.Dockerfile` files are what the Monero node and wallet Docker images are built from, and the `notifier.sh` script is used to notify the BTCPay Server process when a transaction is received that satisfies an invoice

Key areas that need improvement:

- You cannot use distinct wallets per store/use, only one per server
  - Removing this limitation would allow for "Uncle Jim" BTCPay Server instances that are hosted by trusted friends/family/community members that other's can leverage for their stores without needing to host BTCPay Server themselves
- You cannot replace/remove the Monero wallet/keys files without a manual deletion of them via CLI
  - Improving this would allow much simpler migration to new wallets, replacing wallets that are no longer wanted, etc.
- Monero acceptance relies *solely* on the Kraken API
  - Allowing alternate APIs to be used, even just as fall-back APIs to gather price data would allow shop owners to continue accepting Monero for payments even if Kraken's API is unavailable

## Conclusion

A huge, huge thank you to the contributors who have made BTCPay Server possible and who continue to improve it, and to those in the space contributing financially to the project to ensure it continues to grow.

Such a powerful payment processor having solid Monero support is a huge win, and I hope more merchants will start to use BTCPay Server for accepting Monero (and Bitcoin!) ASAP.

As always, if you have any questions from this post or would like more information on accepting Monero as a merchant or using BTCPay Server, please reach out via [Signal, Matrix, Threema, or email]({{< ref "/content/about.md#how-to-contact-me" >}}).
