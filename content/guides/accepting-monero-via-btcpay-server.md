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

{{< notice info >}}
**Update, July 2026:** BTCPay Server has moved all altcoin support -- including Monero -- to a plugin system, with Monero support now maintained by the community in the [btcpayserver-monero-plugin](https://github.com/btcpay-monero/btcpayserver-monero-plugin) repository. This guide has been fully updated (and re-tested end-to-end!) to reflect the new plugin-based approach, which has made accepting Monero via BTCPay Server *dramatically* simpler -- no more manually creating and uploading view-only wallet files!
{{< /notice >}}

For this guide I will assume you're running Ubuntu 24.04+ on a local machine or VPS, but much of the guide will easily translate to other popular Linux distributions.

***A big thank you for a lot of help to [Mike Olthoff](https://x.com/olthoff) of [CoinCards](https://coincards.com/) and for a lot of material pulled from his WIP guide [on Github](https://github.com/astupidmoose/Monero-on-BTCPay/blob/main/README.md)***

## Recommended hardware

- Pruned Node (the default Monero node type for BTCPay Server)[^1]
  - 2+ vCPUs/cores
  - 4GB+ RAM
  - 100GB+ SSD
    - ~25GB are required for the pruned Bitcoin node, and ~50GB for the pruned Monero node
  
[^1]: A pruned node allows you to run your own Monero node without requiring as much disk space. Please see [the pruning Moneropedia entry](https://www.getmonero.org/resources/moneropedia/pruning.html) for more info.

## Why use BTCPay Server to accept Monero?

While there are quite a few options out there for accepting Monero as a merchant, BTCPay Server remains one of the best options for merchants due to it's complete self-sovereignty, the easy acceptance of other cryptocurrencies (like Bitcoin or Lightning), and the ability to simply spin it up.

The wide support for BTCPay Server also leads to it having many well-maintained plugins for common eCommerce platforms and you can even enable awesome additional features like automatic conversion to Monero from other assets via SideShift.

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

While the Monero *plugin* is installed later through the BTCPay Server UI, setting `xmr` as one of your cryptos here is still required -- it's what tells BTCPay Server's Docker deployment to spin up the Monero node and wallet containers that the plugin talks to.

***Be sure to replace `btcpay.EXAMPLE.com` with the domain you setup previously!***

```bash
# Run btcpay-setup.sh with the right parameters
# Set the custom domain you chose to use
export BTCPAY_HOST="btcpay.EXAMPLE.com"

# Use Bitcoin on mainnet
export NBITCOIN_NETWORK="mainnet"

# Enable Bitcoin support
export BTCPAYGEN_CRYPTO1="btc"

# Deploy the Monero node and wallet containers used by the Monero plugin
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

# Deploy the Monero node and wallet containers used by the Monero plugin
export BTCPAYGEN_CRYPTO1="xmr"

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
- Install Docker Compose
- Make sure BTCPay starts at reboot via upstart or systemd
- Setup environment variables to use BTCPay utilities
- Add BTCPay utilities in /usr/bin
- Start BTCPay Server

Assuming all went well, you should now be able to navigate to your new BTCPay Server at the domain you chose earlier!

***Note that both the Bitcoin and Monero nodes will start syncing from scratch in the background, which can take anywhere from several hours to a few days depending on your hardware. You can watch their progress in the "Your nodes are syncing" widget on the BTCPay Server dashboard, and can complete all of the following configuration steps while they sync -- but invoices won't be payable until syncing completes.***

## Create an account and a store

The first thing you'll need to do is create an account on your new instance -- be sure to use a secure email and strong password (hopefully via a password manager like Bitwarden!) -- so that you can create stores, manage wallets, etc.

***Follow the official docs to do so here: [Register account - docs.btcpayserver.org](https://docs.btcpayserver.org/RegisterAccount/)***

Once you're logged in, BTCPay Server will prompt you to create your first store to manage wallets, invoices, etc. Simply set a store name and your preferred default currency and you're on your way.

***Follow the official docs to do so here: [Create a store - docs.btcpayserver.org](https://docs.btcpayserver.org/CreateStore/)***

## Install the Monero plugin

As of BTCPay Server 2.x, all altcoin support -- including Monero -- has moved to community-maintained plugins, so the next step is to install the Monero plugin from within the BTCPay Server UI:

1. Select "Manage Plugins" from the "Server Settings" menu (or the puzzle-piece icon in the top bar)
2. Scroll down (or search) to find the "Monero" plugin by `btcpay-monero` under "Available Plugins"
3. Select "Install"
4. Once you see the "Plugin scheduled to be installed" notice, select "Restart now" in the banner at the top of the page to restart BTCPay Server and activate the plugin

<!-- TODO: screenshot - plugin manager showing the Monero plugin card with Install button -->
<!-- TODO: screenshot - "Restart now" banner after scheduling the plugin install -->

After the restart (give it ~30s), you'll see a new "Monero" entry under the "Wallets" section of your store's sidebar. That's it -- the plugin is installed and connected to the Monero node and wallet containers you deployed earlier.

If you'd like to inspect the source code behind the plugin, it lives here: [btcpay-monero/btcpayserver-monero-plugin](https://github.com/btcpay-monero/btcpayserver-monero-plugin)

## Setup your Bitcoin and Monero wallets

### Configure the Bitcoin wallet of choice

***Skip these steps if you're only accepting Monero on your store!***

1. Select "Setup a wallet" and select the preferred wallet option to setup your Bitcoin wallet

***Follow the official docs to do so here: [Wallet Setup - docs.btcpayserver.org](https://docs.btcpayserver.org/WalletSetup/)***

### Configure your Monero wallet

This is where the new plugin *really* shines. In the past you had to create a view-only wallet in Feather Wallet, export the wallet files, and upload them (along with a password file) to BTCPay Server -- and any mistakes meant `docker cp`-ing files around and fixing permissions by hand.

Now all you need from your Monero wallet of choice is three simple pieces of information:

- Your **primary address** (the address starting with a `4`)
- Your **private view key** (also called the "secret view key")
- Your wallet's **restore height** (the block height your wallet was created at)

Entering these into BTCPay Server gives it *view-only* access to your wallet -- it can generate subaddresses for invoices and watch for incoming payments, but it can never spend your funds, as your seed and spend key never leave your own wallet.

You can grab these details from any proper Monero wallet:

- **Feather Wallet**: `Wallet > Keys...` shows your primary address and secret view key, and `Wallet > Wallet Info` shows your restore height
- **Cake Wallet**: The primary address is shown on the Receive screen, and your private view key is shown under `Settings > Show seed/keys`
- **Monero GUI/CLI**: The `address` and `viewkey` commands print your primary address and secret view key

***NOTE: Be sure to create a dedicated wallet for your store to preserve your privacy and keep accounting simple, and never share your* spend *key or seed with anyone -- BTCPay Server only needs the* view *key!***

Once you have those details in hand:

1. Select "Monero" under the "Wallets" section of your store's sidebar
2. Enter your primary address into "Wallet Primary Address"
3. Enter your private view key into "Wallet Private View Key"
4. Enter your restore height into "Restore Height (Block Height)"
   1. If you just created the wallet, the current block height works perfectly and saves the wallet from scanning the entire chain history
5. Select "Set Wallet Details"

<!-- TODO: screenshot - XMR Settings page with the Set View-Only Wallet Details form -->

You should see "View-only wallet created. The wallet will soon become available." -- the plugin creates and opens the view-only wallet server-side automatically. Once "Wallet RPC available" shows "True", you're almost done:

1. Check the "Enabled" box to enable Monero payments on your store
2. Choose your preferred "Consider the invoice settled when the payment transaction..." speed policy
   1. "At Least One" (one confirmation, ~2 minutes) is a sensible default for most stores; use "At Least Ten" for high-value goods, and only use "Zero Confirmation" if instant settlement matters more to you than the (small) risk of accepting unconfirmed transactions
3. Select "Save"

<!-- TODO: screenshot - Enabled toggle + speed policy on the XMR Settings page -->

Now just wait for the Bitcoin and Monero nodes to sync, and you should be all set!

## Using your BTCPay Server instance

Thankfully the docs for using BTCPay Server are *excellent* and all apply exactly the same way to Monero as to Bitcoin usage:

[User Guide - docs.btcpayserver.org](https://docs.btcpayserver.org/Guide/)

When a user is prompted to pay an invoice, now they can select Monero from the dropdown and pay without any extra hoops or unique back-ends!

<!-- TODO: screenshot - new checkout page showing a Monero invoice with subaddress QR -->

## Contributing to Monero support in BTCPay Server

Monero support in BTCPay Server is now maintained by the community under the `btcpay-monero` organization, and contributions are always welcome. If you'd like to contribute and improve Monero support within BTCPay Server, here are the relevant repositories:

- [btcpayserver-monero-plugin](https://github.com/btcpay-monero/btcpayserver-monero-plugin)
  - The Monero plugin itself -- this controls the front-end, wallet handling, and BTCPay Server interactions with the Monero node and wallet
- [btcpayserver-docker](https://github.com/btcpayserver/btcpayserver-docker)
  - Specifically this file: [monero.yml](https://github.com/btcpayserver/btcpayserver-docker/blob/master/docker-compose-generator/docker-fragments/monero.yml)
  - This file controls the way that the Monero Docker containers are started and managed

Key areas that need improvement:

- The plugin shares a single Monero wallet across all stores on a server
  - Removing this limitation would allow for "Uncle Jim" BTCPay Server instances that are hosted by trusted friends/family/community members that other's can leverage for their stores without needing to host BTCPay Server themselves
- Replacing the Monero wallet still requires a manual deletion of the wallet files via CLI (see [Troubleshooting]({{< relref "#replacing-the-monero-view-only-wallet" >}}) below)
  - Improving this would allow much simpler migration to new wallets directly from the UI

## Troubleshooting

### Invoices fail with "Payment method unavailable"

If creating an invoice fails with `XMR-CHAIN: Payment method unavailable (Node or wallet not available)`, your Monero node simply hasn't finished syncing yet -- the plugin holds off on generating invoices until the node is fully synced and the wallet is available. Check the sync progress in the dashboard widget or your store's Monero settings page, and give it time to finish.

### Replacing the Monero view-only wallet

Occasionally you may want to migrate your store to a new wallet, which unfortunately must still be done manually for now. Note that the wallet setup form only appears in the UI when no wallet currently exists, so you have to remove the existing wallet files first:

```bash
docker exec btcpayserver_monero_wallet rm -f /wallet/wallet /wallet/wallet.keys /wallet/password
docker restart btcpayserver_monero_wallet
```

***NOTE: If the wallet was open when you deleted the files, the wallet RPC daemon can write a stale `wallet` cache file back to disk as it shuts down. Double-check the directory is actually empty and repeat the two commands above if a `wallet` file remains:***

```bash
docker exec btcpayserver_monero_wallet ls /wallet/
```

Once the wallet directory is empty, refresh your store's Monero settings page and the "Set View-Only Wallet Details" form will be back -- just enter your new wallet's details as you did during the initial setup. Your "Enabled" and speed policy settings are preserved, so no need to reconfigure those.

## Conclusion

A huge, huge thank you to the contributors who have made BTCPay Server possible and who continue to improve it, to those who have stepped up to maintain the Monero plugin under the new plugin system, and to those in the space contributing financially to the project to ensure it continues to grow.

Such a powerful payment processor having solid Monero support is a huge win, and I hope more merchants will start to use BTCPay Server for accepting Monero (and Bitcoin!) ASAP.

As always, if you have any questions from this post or would like more information on accepting Monero as a merchant or using BTCPay Server, please reach out via [Signal, SimpleX, X, or Nostr]({{< ref "/about.md#how-to-contact-me" >}}).
