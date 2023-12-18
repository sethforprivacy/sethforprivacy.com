---
author: Seth For Privacy
comments: false
date: "2021-05-02T13:50:00-04:00"
summary: This will be a simple guide to get you started with a few more advanced
  options/recommendations at the end, but hopefully will help to simplify the process
  for those of you wanting to get started mining Monero!
draft: false
hidemeta: false
showToc: true
tags:
- Monero
- Mining
- xmrig
title: Mining Monero
weight: 2
---

# Introduction

It's been a long time coming, but one of the things I love about Monero is the ability for it to be mined with "commodity hardware" -- in other words, hardware you already likely have around the house, office, etc.

This will be a simple guide to get you started with a few more advanced options/recommendations at the end, but hopefully will help to simplify the process for those of you wanting to get started mining Monero!

***Note: This guide was previously focused on centralized pool mining, but has been updated to focus on p2pool mining instead. If you specifically need to use a centralized pool for some reason, please see [Legacy pool mining]({{< relref "#legacy-pool-mining" >}}).***

# Why Mine Monero?

You may be asking yourself, "why would I bother mining Monero?" I'll lay out a few potential reasons or motivations for you here, as mining is often viewed as out of reach or only for big players but is quite approachable (especially in Monero!) for smaller miners like us.

### Support the network's security

The first reason is very straightforward -- mining Monero helps to secure the network, protecting yourself and other Monero users from attacks like double-spends, nation-state attacks, and other ways that the consensus of Monero could be affected by malicious actors. Every hash that is done by a good actor (like yourself!) is one more hash that has to be overcome by a malicious attacker to harm the network in any way.

### Earn Monero without KYC

This is something almost uniquely available to Monero due to the implementation of [RandomX](https://www.monerooutreach.org/stories/RandomX.html) as anyone with a PC can easily mine Monero and make a reasonable amount.

No, you likely won't get rich mining Monero, but it's an *excellent* way to earn Monero without having to give up know-your-customer (KYC) information, pay exchange fees, or hassle with a trade of any sort. Simply turn on the mining software as I'll walk you through, sit back, and watch the piconeros roll into your wallet over time!

### Donate to your favorite project

This is an avenue that I consider under-explored in the space, but an awesome way that you can donate to your favorite projects (even if you don't have any Monero to begin with!) is to donate via mining! 

Simply use the donation address of your favorite project (you can find a list of possible options I've compiled [here]({{< ref "/content/posts/foss-donations.md" >}})) and fire up a miner and donate in a permissionless, censorship-resistant, and untraceable manner.

# Downloading your mining software

By far the best mining software available for Monero is [XMRig](https://xmrig.com/), an open-source miner made for mining Monero and other cryptocurrencies that are CPU/GPU minable.

You can download the latest release from the following two locations:

- XMRig's official site:
  - <https://xmrig.com/download>
- XMRig's Github releases page:
  - <https://github.com/xmrig/xmrig/releases>

***NOTE: DO NOT download XMRig from any other source than the two linked above, as it could easily contain malware, mine to the creator's address only, etc.***

Next I would recommend you place the downloaded files (after unzipping/untaring them) in a memorable and accessible location like your desktop.

***NOTE FOR WINDOWS USERS: Windows will likely categorize the above downloads as malware incorrectly and try to remove the files. In order to avoid this be sure to add the folder containing the files themselves as an exception following [this guide from HowToGeek](https://www.howtogeek.com/671233/how-to-add-exclusions-in-windows-defender-on-windows-10/).***

# Running your miner

Now it's finally time to get down to business -- actually running the miner and generating your first hash!

Thankfully, it's quite simple to actually run XMRig, but it does differ a bit depending on your operating system:

## Windows

Simply navigate to the folder where you extracted the `xmrig.exe` binary, right-click, and select "Run as Administrator".

XMRig will automatically use the `config.json` file you edited earlier and will start mining directly to your chosen pool and wallet address immediately!

## Linux/macOS

The easiest way to run XMRig on Linux or macOS is to navigate to the folder you extracted XMRig to, right-click, and select "Open in Terminal" (or similar).

{{< figure src="/mining-monero/open-in-terminal.png" align="center" style="border-radius: 8px;" >}}

Once the terminal opens, simply run `sudo ./xmrig`, enter your user's password, and XMRig will start mining directly to your chosen pool and wallet address immediately!

{{< figure src="/mining-monero/sudo-xmrig.png" align="center" style="border-radius: 8px;" >}}

# Run a p2pool node

In order to mine using p2pool, the best way to help the Monero network and mine, you'll need to be running a p2pool node.

- For more on how to run a p2pool node, see my guide on the topic [here]({{< ref "/content/guides/run-a-p2pool-node.md" >}}).
- For more on why to use p2pool instead of centralized pools, see [here]({{< ref "/content/guides/run-a-p2pool-node.md#why-run-and-mine-on-p2pool-instead-of-a-normal-monero-pool" >}}).

# Connect your miners to p2pool

Once you have `p2pool` up and running, you can easily point any and all of your miners at it using the config below.

To get started, simply copy the below configuration file and paste it into the `config.json` file that was provided with your download of XMRig, overwriting all other text already in the file, while replacing the `127.0.0.1` address with the IP address/DNS address of the `p2pool` node/VPS you're running it on.

{{< figure src="/mining-monero/config.json.png" align="center" style="border-radius: 8px;" >}}

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

# Viewing your mining stats

As there is no standard pool for you to use to check your statistics, you may be wondering how you can see your pool-side hashrate in total, shares found, accumulated approximate reward, etc.

The easiest way to check your statistics is to use a community-run website, [p2pool.observer](https://p2pool.observer/), and enter your payout address to view statistics, shares, payouts, etc.

# Checking payouts

The easiest way to check your payouts is to use a community-run website, [p2pool.observer](https://p2pool.observer/), and enter your payout address to view statistics, shares, payouts, etc.

If you don't want to enter your address into website, simply watch the wallet in your favorite Monero wallet like [Cake Wallet](https://cakewallet.com/) or [Monerujo](https://www.monerujo.io/).

To view general pool statistics for the current mainnet p2pool instance, see <https://p2pool.io/>.

# Advanced options

While the above guide walks through the basics, there are some advanced options I would recommend you investigate if you're a little more tech-savvy.

## Mining over Tor

If you're running a local Tor daemon, you can easily mine over Tor by adding one line (`socks5`) to your `config.json` file as seen below:

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
            "socks5": "127.0.0.1:9050",
            "keepalive": true,
            "nicehash": false
        }
    ]
}
```

# Conclusion

Hopefully this guide has made it a bit simpler for you to get started, and can act as some motivation to do your part and further decentralize the network, all while earning some KYC-free Monero.

As always, if you have any questions from this post or would like more information on a specific aspect of mining, please reach out via [Signal, SimpleX, X, or Nostr]({{< ref "/content/about.md#how-to-contact-me" >}}).

# Legacy pool mining

This section used to be the bulk of this mining guide, but as p2pool is now out and the best recommendation for mining Monero, I've shifted the guide to using that. If you can't run a Monero node for some reason, you can explore using one of these centralized pools instead.

### Alternative miners for Windows/Mac users

The developers of my favorite pool, <https://cryptonote.social>, also made a *very* easy to use miner that is much simpler to configure and run, but is slightly slower at mining than XMRig. You can download that miner if you want to mine at <https://cryptonote.social> below:

- <https://cryptonote.social/tools/monero-cart>

{{< figure src="/mining-monero/MoneroCart.png" align="center" style="border-radius: 8px;" >}}

The link above has tips on how to get started with MoneroCart, so feel free to dive in there if you choose to use that instead of XMRig.

## Choosing a pool

Choosing a pool can be a daunting task for new entrants to mining, but it's important to remember a few things:

- Larger pools *do not* mean you will earn more Monero
- Preventing large pools from nearing 51% of the global hashrate is *extremely* important to network security, and should be a key consideration for those wanting to start mining
- Smaller pools often have vibrant and active communities around them, and can be a much more enjoyable place to get started.

I'll recommend a few of my favorite pools below, but there is a list available of all *known* Monero pools available at <https://miningpoolstats.stream/monero>. This is by no means an exhaustive list and I'm sure there are some other excellent small pools, but I only wanted to share those I have experience with in the past.

***NOTE: To help further decentralize the network, please do not select any pool from the top 5 in the list available at <https://miningpoolstats.stream/monero>. Always use a smaller pool!***

### cryptonote.social

<https://cryptonote.social> is my favorite pool, and the one that I have been mining at for a long time. It has a great admin, solid uptime, and a very unique approach to mining with a leaderboard, great custom tools, and differing approaches to payouts. It is my top recommendation and I'd love to see it continue to grow!

{{< figure src="/mining-monero/cryptonote.social.png" align="center" style="border-radius: 8px;" >}}

### pool.xmr.pt

<https://pool.xmr.pt/> is another great small pool with an active community on Matrix that I have experience mining at. Highly recommend supporting a small pool like this!

{{< figure src="/mining-monero/pool.xmr.pt.png" align="center" style="border-radius: 8px;" >}}

### xmr.pool.gntl.co.uk

<https://xmr.pool.gntl.co.uk/> is a great slightly larger pool with an active community that I have mined at occasionally in the past, and have enjoyed.

{{< figure src="/mining-monero/gntl.co.uk.png" align="center" style="border-radius: 8px;" >}}

## Configuring your mining software

This section will be specific to <https://cryptonote.social> as it's my personal recommendation, but whichever pool you've decided on should have a "Getting Started" section or similar, as you can find below for my 2nd and 3rd pool choice:

- <https://pool.xmr.pt/#/help/getting_started>
- <https://xmr.pool.gntl.co.uk/#/getting_started>

The general process should be the same between any pool, but the specifics for cryptonote.social are below:

1. Create a new sub-address that you will use for mining within your favorite wallet[^1]
2. Select the appropriate pool address and port (i.e. `cryptonote.social:5556`)
3. Select a username (i.e. `sethforprivacydonation`).
4. Set the appropriate extra options like TLS, Tor usage, etc.

Example configurations can be found below, but note that if you simply copy and paste and do not replace the address/username, you will be donating to me :)

If you want to build your own configuration for a different pool, take a look at <https://xmrig.com/wizard> for a guided wizard to help you along the way!

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
            "url": "cryptonote.social:5556",
            "user": "86JzKKyZvtEC98y6zJxCCVfcA3r75XngPBjpYDE6zRR36keNGMHwZomDjMCv1oCYB2j9myiFqEJQF3JtnhKdfX546T91eaY.sethforprivacydonation",
            "pass": "x",
            "tls": true,
            "keepalive": true,
            "nicehash": false
        }
    ]
}
```

```json
{
    "autosave": true,
    "donate-level": 5,
    "cpu": true,
    "opencl": false,
    "cuda": false,
    "pools": [
        {
            "url": "xmr.pool.gntl.co.uk:20009",
            "user": "86JzKKyZvtEC98y6zJxCCVfcA3r75XngPBjpYDE6zRR36keNGMHwZomDjMCv1oCYB2j9myiFqEJQF3JtnhKdfX546T91eaY",
            "keepalive": true,
            "tls": true
        }
    ]
}
```

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
            "url": "pool.xmr.pt:9000",
            "user": "86JzKKyZvtEC98y6zJxCCVfcA3r75XngPBjpYDE6zRR36keNGMHwZomDjMCv1oCYB2j9myiFqEJQF3JtnhKdfX546T91eaY",
            "keepalive": true,
            "tls": true
        }
    ]
}
```

To get started, simply copy the above configuration file for the desired pool and paste it into the `config.json` file that was provided with your download of XMRig, overwriting all other text already in the file.

***Make sure to replace the address and username with your own!***

{{< figure src="/mining-monero/config.json.png" align="center" style="border-radius: 8px;" >}}

[^1]: This will differ between wallets, but the instructions for doing so in the GUI can be found at [here](https://github.com/monero-ecosystem/monero-GUI-guide/blob/da1bf0da4dc9a5268b17ff5c8121aa8013be73eb/en/ch06.md#receive-monero).

Once you've selected a pool and configured XMRig, proceed to [Running your miner]({{< relref "#running-your-miner" >}}) to continue.