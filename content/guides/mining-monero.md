+++
title = "Mining Monero"
date = 2021-05-02T13:50:00-04:00
author = "Seth Simmons"
authorTwitter = "sethisimmons" #do not include @
cover = ""
tags = ["Monero", "Mining", "xmrig"]
keywords = ["Monero", "mining", "xmrig"]
description = "This will be a simple guide to get you started with a few more advanced options/recommendations at the end, but hopefull will help to simplify the process for those of you wanting to get started mining Monero!"
summary = "This will be a simple guide to get you started with a few more advanced options/recommendations at the end, but hopefull will help to simplify the process for those of you wanting to get started mining Monero!"
showFullContent = false
toc = true
draft = false
+++

# Introduction

It's been a long time coming, but one of the things I love about Monero is the ability for it to be mined with "commodity hardware" -- in other words, hardware you already likely have around the house, office, etc.

This will be a simple guide to get you started with a few more advanced options/recommendations at the end, but hopefully will help to simplify the process for those of you wanting to get started mining Monero!

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

### Alternative miners for Windows/Mac users

The developers of my favorite pool, <https://cryptonote.social>, also made a *very* easy to use miner that is much simpler to configure and run, but is slightly slower at mining than XMRig. You can download that miner if you want to mine at <https://cryptonote.social> below:

- <https://cryptonote.social/tools/monero-cart>

{{< figure src="/mining-monero/MoneroCart.png" position="center" style="border-radius: 8px;" >}}

The link above has tips on how to get started with MoneroCart, so feel free to dive in there if you choose to use that instead of XMRig.

# Choosing a pool

Choosing a pool can be a daunting task for new entrants to mining, but it's important to remember a few things:

- Larger pools *do not* mean you will earn more Monero
- Preventing large pools from nearing 51% of the global hashrate is *extremely* important to network security, and should be a key consideration for those wanting to start mining
- Smaller pools often have vibrant and active communities around them, and can be a much more enjoyable place to get started.

I'll recommend a few of my favorite pools below, but there is a list available of all *known* Monero pools available at <https://miningpoolstats.stream/monero>. This is by no means an exhaustive list and I'm sure there are some other excellent small pools, but I only wanted to share those I have experience with in the past.

***NOTE: To help further decentralize the network, please do not select any pool from the top 5 in the list available at <https://miningpoolstats.stream/monero>. Always use a smaller pool!***

### cryptonote.social

<https://cryptonote.social> is my favorite pool, and the one that I have been mining at for a long time. It has a great admin, solid uptime, and a very unique approach to mining with a leaderboard, great custom tools, and differing approaches to payouts. It is my top recommendation and I'd love to see it continue to grow!

{{< figure src="/mining-monero/cryptonote.social.png" position="center" style="border-radius: 8px;" >}}

### pool.xmr.pt

<https://pool.xmr.pt/> is another great small pool with an active community on Matrix that I have experience mining at. Highly recommend supporting a small pool like this!

{{< figure src="/mining-monero/pool.xmr.pt.png" position="center" style="border-radius: 8px;" >}}

### xmr.pool.gntl.co.uk

<https://xmr.pool.gntl.co.uk/> is a great slightly larger pool with an active community that I have mined at occasionally in the past, and have enjoyed.

{{< figure src="/mining-monero/gntl.co.uk.png" position="center" style="border-radius: 8px;" >}}

# Configuring your mining software

This section will be specific to <https://cryptonote.social> as it's my personal recommendation, but whichever pool you've decided on should have a "Getting Started" section or similar, as you can find below for my 2nd and 3rd pool choice:

- <https://pool.xmr.pt/#/help/getting_started>
- <https://xmr.pool.gntl.co.uk/#/getting_started>

The general process should be the same between any pool, but the specifics for cryptonote.social are below:

1. Create a new sub-address that you will use for mining within your favorite wallet[^1]
2. Select the appropriate pool address and port (i.e. `cryptonote.social:5556`)
3. Select a username (i.e. `sethsimmonsdonation`).
4. Set the appropriate extra options like TLS, Tor usage, etc.

Example configurations can be found below, but note that if you simply copy and paste and do not replace the address/username, you will be donating to me :)

If you want to build your own configuration for a different pool, take a look at <https://xmrig.com/wizard> for a guided wizard to help you along the way!

{{< code language="json" title="cryptonote.social w/ TLS" id="0" expand="Show" collapse="Hide" isCollapsed="false" >}}
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
            "user": "86JzKKyZvtEC98y6zJxCCVfcA3r75XngPBjpYDE6zRR36keNGMHwZomDjMCv1oCYB2j9myiFqEJQF3JtnhKdfX546T91eaY.sethsimmonsdonation",
            "pass": "x",
            "tls": true,
            "keepalive": true,
            "nicehash": false
        }
    ]
}
{{< /code >}}

{{< code language="json" title="gntl.co.uk w/ TLS" id="1" expand="Show" collapse="Hide" isCollapsed="true" >}}
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
{{< /code >}}

{{< code language="json" title="pool.xmr.pt w/ TLS" id="3" expand="Show" collapse="Hide" isCollapsed="true" >}}
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
{{< /code >}}

To get started, simply copy the above configuration file for the desired pool and paste it into the `config.json` file that was provided with your download of XMRig, overwriting all other text already in the file.

***Make sure to replace the address and username with your own!***

{{< figure src="/mining-monero/config.json.png" position="center" style="border-radius: 8px;" >}}

[^1]: This will differ between wallets, but the instructions for doing so in the GUI can be found at [here](https://github.com/monero-ecosystem/monero-GUI-guide/blob/da1bf0da4dc9a5268b17ff5c8121aa8013be73eb/en/ch06.md#receive-monero).

# Running your miner

Now it's finally time to get down to business -- actually running the miner and generating your first hash!

Thankfully, it's quite simple to actually run XMRig, but it does differ a bit depending on your operating system:

## Windows

Simply navigate to the folder where you extracted the `xmrig.exe` binary, right-click, and select "Run as Administrator".

XMRig will automatically use the `config.json` file you edited earlier and will start mining directly to your chosen pool and wallet address immediately!

## Linux/macOS

The easiest way to run XMRig on Linux or macOS is to navigate to the folder you extracted XMRig to, right-click, and select "Open in Terminal" (or similar).

{{< figure src="/mining-monero/open-in-terminal.png" position="center" style="border-radius: 8px;" >}}

Once the terminal opens, simply run `sudo ./xmrig`, enter your user's password, and XMRig will start mining directly to your chosen pool and wallet address immediately!

{{< figure src="/mining-monero/sudo-xmrig.png" position="center" style="border-radius: 8px;" >}}

# Watching your rewards

This will differ a bit per pool, but for cryptonote.social you will want to go to the dashboard and enter the username you selected previously like shown below:

{{< figure src="/mining-monero/leaderboard.png" position="center" style="border-radius: 8px;" >}}

That's it! Now you can watch the Monero roll into your address (or the address you're donating to!) as you exchange electricity for cold, hard, Monero.

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
            "url": "cryptonote.social:5556",
            "user": "86JzKKyZvtEC98y6zJxCCVfcA3r75XngPBjpYDE6zRR36keNGMHwZomDjMCv1oCYB2j9myiFqEJQF3JtnhKdfX546T91eaY.sethsimmonsdonation",
            "pass": "x",
            "tls": true,
            "keepalive": true,
            "socks5": "127.0.0.1:9050",
            "nicehash": false
        }
    ]
}
```

## Self-select

Another great option available to anyone running their own node is to enable [self-select](https://xmrig.com/docs/extensions/self-select), which allows you to utilize your own node to generate block templates, removing any power from the pool to censor or create bad block templates. If you already have a node running, simply add the `self-select` line as seen below:

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
            "user": "86JzKKyZvtEC98y6zJxCCVfcA3r75XngPBjpYDE6zRR36keNGMHwZomDjMCv1oCYB2j9myiFqEJQF3JtnhKdfX546T91eaY.sethsimmonsdonation",
            "pass": "x",
            "tls": true,
            "keepalive": true,
            "socks5": "127.0.0.1:9050",
            "self-select": "node-1.sethsimmons.me:18089"
            "nicehash": false
        }
    ]
}
```

Simply replace the node address with your own, and enjoy a little bit more decentralized network!

If you're not yet running a node but would like to, check out one of my guides below:

- [Run a Monero node]({{< ref "/content/guides/run-a-monero-node.md" >}})
- [Run a Monero node (Advanced)]({{< ref "/content/guides/run-a-monero-node-advanced.md" >}})

# Conclusion

Hopefully this guide has made it a bit simpler for you to get started, and can act as some motivation to do your part and further decentralize the network, all while earning some KYC-free Monero.

As always, if you have any questions from this post or would like more information on a specific aspect of mining, please reach out via [Twitter, Matrix, or email]({{< ref "/content/about.md#how-to-contact-me" >}}).
