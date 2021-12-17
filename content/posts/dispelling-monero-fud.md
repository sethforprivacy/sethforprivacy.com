+++
title = "Dispelling Monero FUD"
date = 2021-12-17T00:00:00-04:00
author = "Seth"
authorTwitter = "sethforprivacy" #do not include @
cover = ""
tags = ["monero", "privacy", "fud", "bitcoin"]
keywords = ["monero", "privacy", "fud", "bitcoin"]
description = "In this specific post I’ll attempt to walk through the most common FUD around Monero (both valid and invalid) and help to clarify many of these points."
summary = "In this specific post I’ll attempt to walk through the most common FUD around Monero (both valid and invalid) and help to clarify many of these points."
showFullContent = false
toc = true
draft = false
+++

# Introduction

One of the most common issues I deal with as someone passionate about personal privacy is fighting through common fear, uncertainty, and doubt (FUD) that is mentioned by those who don't understand an issue thoroughly, or from people who are maliciously spreading FUD to demean a project or tool they don't want people to use.

While this is a key issue across the privacy space, it's often the worst in the cryptocurrency space due to the in-built incentives in cryptocurrencies that lead to greed and tribalism.

In this specific post I'll attempt to walk through the most common FUD around Monero (both valid and invalid) and help to clarify many of these points. Note that much of the FUD spread has a sliver of truth but does not often tell the full story or approach difficult technical topics with nuance, so I'll try to remedy some of that today by laying out the facts and letting the reader decide if that point of FUD is something that personally concerns them, or not.

All I want out of this post is people to have the chance to make well-informed decisions -- I don't expect to sway anyone or change minds, but hopefully the information container within this post will help to clarify things for you.

Let's walk through the common FUD points one-by-one below.

# You can't audit the Monero supply

### Response

This is probably the most common point of FUD brought against Monero, and is caused by the complexity and nuance involved in understanding how supply audits work in cryptocurrencies.

Monero's supply can be easily audited by anyone running a Monero node, but this process does rely on the soundness of the `monerod` software implementation and the validity of cryptography used in rangeproofs that verify amounts in each transaction without revealing them.

This audit is possible because coinbase transactions (those transactions that are mining rewards in each block including issuance + transaction fees) are intentionally transparent and amounts of these outputs are not obfuscated in any way. Monero users running a node can simply validate these totals on-demand, and all node owners are constantly verifying the amounts in transactions via range proofs.

Unlike Bitcoin, however, Monero users cannot simply do "napkin math" and validate the supply by manually adding up UTXO amounts, as transactions are never known-spent by the network, only by the parties involved in each specific transaction. This does force some added reliance on code/cryptography over Bitcoin, but as-of-yet I know of *no one* validating the Bitcoin supply this way. It does remain a valuable advantage of a transparent cryptocurrency, though it comes at the cost of transactional privacy of every user in the system.

### Resources

- Excellent and nuanced blog post on auditability in cryptocurrencies:
  - <https://web.getmonero.org/2020/01/17/auditability.html>
- Very thorough and detailed talk on the issues surrounding auditability in cryptocurrencies:
  - <https://invidious.sethforprivacy.com/watch?v=meDkx6gRPMg>
- Anyone can easily verify the supply of Monero:
  - <https://nitter.sethforprivacy.com/fluffypony/status/1292032287396306944>
- Audio clip of me sharing about auditability in Bitcoin and Monero:
  - <https://nitter.sethforprivacy.com/DontTraceMeBruh/status/1414602052471332864?s=20>
- [Monero vuln that was not exploited, was detectable](https://www.getmonero.org/2017/05/17/disclosure-of-a-major-bug-in-cryptonote-based-currencies.html)
- [Bitcoin vuln that was exploited, was detectable](https://news.bitcoin.com/bitcoin-history-part-10-the-184-billion-btc-bug/)

# Monero can't scale

### Response

This point of FUD is one that is hard to get to the bottom of as well, as there are lots of other questions that come out of it. I'll focus on transaction size in this one, as that is the most common complaint about Monero.

Monero is, in fact, the most scalable cryptocurrency *when used privately*, and even when compared with default, transparent Bitcoin usage, it's transactions are only ~3-4x the size of Bitcoin transactions today. Monero's transactions were *much* larger in the past, but the Monero community, researchers, and developers have worked hard to improve the efficiency of Bitcoin, bringing transactions down from ~13kb when RingCT was first introduced to ~1.4kb today.

I've written an entire blog post around this topic, so for more on that see the resources below.

### Resources

- [Comparing Private Spends]({{< ref "/content/posts/comparing-private-spends.md" >}})

# Monero has an infinite supply

### Response

This one is very common from the Bitcoin crowd, and is techically true.

However, there is a lot of nuance and intentional design that has gone into the supply dynamics of Monero. Monero implements a "defined supply" of 18.4m coins, and has a tail emission of 0.6XMR per block after the defined supply has been mined.

This means, in effect, that Monero has extremely low inflation that approaches 0% *forever*, and is technically "disinflationary" or "asymptotatically approaching 0% inflation". The inflation rate is currently lower than Bitcoin and gold, and will continue to decrease.

It's *extremely* important to note that Monero's supply is pre-defined, verified and enforced via consensus, and entirely predictable, just like Bitcoin's -- you can know the inflation rate and totaly supply at any point in the future without doubts.

This tail emission enables two key features in Monero

1. A lower bound of network security forever (miners will always be able to rely on 0.6XMR per block, no matter the fee market)
2. A dynamic block size (Monero's blocks can grow/shrink to adapt to short-term increases in usage, with a penalty to mining rewards during these times).

For more on both of these, see the resources below.

### Resources

- Descriptive website with graphs showing the supply dynamics of Monero:
  - <https://monero.supply>
- "Why Monero has a tail emission":
  - <https://localmonero.co/knowledge/monero-tail-emission>
- "How Monero Solved the Block Size Problem That Plagues Bitcoin":
  - <https://localmonero.co/knowledge/dynamic-block-size>
- Inherent risks in not having a defined block reward in perpetuity:
  - <https://www.cs.princeton.edu/~arvindn/publications/mining_CCS.pdf>

# Monero's hard-forks make it centralized

### Response

The key points I would make around this are walked through in detail in the Twitter thread below, but here are some bulletpoints on Monero's hard-forks:

- Monero used to hard-fork every 6mo, but now only hard-forks as-needed for key network upgrades
- Monero's hard-forks enable it to constantly improve and adapt it's privacy protocol (among other things) to stay ahead in the privacy arms race
- Monero's hard-forks always include thorough code review before merging, and if any key parts of consensus code are touched (like with the upcoming Bulletproofs+), the code is audited by multiple 3rd-party auditing groups/companies
- The process of deciding what goes into a hard-fork, when to hard-fork, and what approaches to take *all* happens publicly, either on Github or in IRC/Matrix (mostly through scheduled meetings)
- Monero has yet to have a contentious hard-fork, showing strong community support for every hard-fork so far

### Resources

- Blog post on scheduled upgrades in Monero:
  - <https://www.getmonero.org/2020/09/01/note-scheduled-upgrades.html>
- Long thread by myself on the details around how Monero hard-forks and what they mean for centralization/decentralization:
  - <https://nitter.sethforprivacy.com/sethforprivacy/status/1397543058070200324>

# Monero has no adoption

### Response

Thankfully, this one is quite easy to answer and is growing more incorrect by the day. 

Monero is gaining strong acceptance in both the standard economy among merchants, FOSS projects, etc., but also completely dominates the black and grey-market economies as the preferred method of payment. Monero is consistently one of the most widely supported cryptocurrencies despite no venture capitalist investors, no pre-mine, no dev-tax, no marketing team, and no centralized corporation running things and driving adoption.

All of Monero's adoption is due to grassroots marketing, word-of-mouth, and technical merit due to Monero protecting both sender and receiver privacy so well while keeping fees low.

### Resources

Payments:

- Broad and growing acceptance of Monero with merchants (over 1,200 merchants as of writing):
  - <https://cryptwerk.com/pay-with/xmr/>
- Simple usage of Monero to buy gift cards to most popular online merchants:
  - <https://coincards.com/>
- Using Monero to pay for travel, lodging, etc.
  - <https://www.travala.com/>
- ProxyStore, allowing you to purchase goods and services via Monero:
  - <https://proxysto.re/en/index.html>

Donations:

- [Donating to FOSS Projects and Pro-Privacy Organizations]({{< ref "/content/posts/foss-donations.md" >}})

Evidence:

- Thread detailing some of the many ways that Monero is used around the world:
  - <https://nitter.sethforprivacy.com/sethforprivacy/status/1461045397531549710>

# Monero mining is centralized

### Response

Monero's approach to mining is almost entirely unique in the cryptocurrency world, as it's community has maintained a core ethos of ASIC-resistance from the inception of the project.

Monero aims for ASIC-resistance for two core reasons:

1. Ensure easy access to Monero mining by as many people as possible
2. Increase the security and decentralization of the network by aiding manufacturer and geographical diversity in mining Monero

This goal has been accomplished via a few different mining algorithms in Monero's history, but the current algorithm, RandomX, has successfully prevented ASICs on the Monero network for over two years, despite a bull market and growing usage increasing the allure of mining Monero to ASIC manufacturers. I won't go into the technical details of RandomX here, but feel free to read through the resources below for more details.

While Monero does have drastically less miners and energy used to secure the network compare to Bitcoin or Ethereum, it remains extremely secure and decentralized due to the technical approach in RandomX and the grassroots nature of the community up until now.

### Resources

- Excellent explainer on RandomX:
  - <https://www.monerooutreach.org/stories/RandomX.html>
- A detailed look at why RandomX is so unique:
  - <https://localmonero.co/knowledge/monero-mining-randomx>
- Monero faired extremely well during the ban on mining in China, unlike ASIC-dominated networks:
  - <https://nitter.sethforprivacy.com/sethforprivacy/status/1471103239823183880>
  - <https://nitter.sethforprivacy.com/DouglasTuman/status/1470820539233144836?s=20>
- A look at the economics of 51% attacking Monero
  - <https://nitter.sethforprivacy.com/sethforprivacy/status/1471202444185153540?s=20>

# KYC/AML-regulated exchanges won't support Monero/governments will ban Monero

### Response

This one is a key point of contention for me, as while I see no reason for regulated exchanges to *not* support Monero (in a legal or regulatory sense), I'm not really worried about whether or not centralized exchanges (the Coinbase.com's of the world) choose to list Monero or not. Exchanges like these are an easy point of control and surveillance for malicious entities and nation states while creating immense risk to end-users for data breaches, hacks, and leaks.

Monero *should* be supported everywhere, but the Monero community is committed to building out on/off-ramps that can enable easy access to Monero for people around the world, without disclosing personally identifiable information or putting their own privacy and data at risk.

I'll put some resources below to browse, but for those that specifically would like to see centralized exchanges support Monero, I'd recommend looking at the first entry from Perkins Coie.

### Resources

- "Anti-Money Laundering Regulation of Privacy-Enabling Cryptocurrencies"
  - <https://www.perkinscoie.com/en/news-insights/anti-money-laundering-regulation-of-privacy-enabling-cryptocurrencies.html>
- Short audio clips on why KYC is harmful:
  - <https://invidious.sethforprivacy.com/search?q=opt+out+podcast+kyc+duration%3Ashort+sort%3Adate&page=1>
- A great explainer and guide on avoiding KYC:
  - <https://bitcoiner.guide/nokyconly/>
- An amazing list of KYC-free exchanges, merchants, and more:
  - <https://kycnot.me/>

Excellent decentralized exchanges supporting Monero:

- LocalMonero, an excellent and privacy-preserving way to buy and sell Monero
  - <https://localmonero.co/>
- Haveno, a WIP decentralized and entirely peer-to-peer exchange
  - <https://haveno.exchange/>
- Atomic swaps (WIP)
  - <https://github.com/comit-network/xmr-btc-swap>
  - <https://github.com/farcaster-project/farcaster-node>

# Monero can't support layer-two networks (like Lightning)

### Response

While Monero does lack the complex compute capabilities of Ethereum and the simple scripting ability of Bitcoin, there have already been some fascinating approaches presented by researchers on how to support layer-two networks like Lightning on Monero *without protocol changes* today.

Monero's layer-one scaling (much of which was mentioned previously in this post) also allows for a much longer runway without *needing* a layer-two network, even though layer-two networks could provide both better scaling and more privacy through ephemerality (transactions not being published to a permanent ledger).

For more on the possibility of layer-two networks in Monero, see the resources below.

### Resources

- "PayMo: Payment Channels For Monero"
  - <https://eprint.iacr.org/2020/1441>
- Twitter thread on PayMo by one of the authors:
  - <https://twitter.com/aravind2112/status/1329420254884335617>
- "Sleepy Channels: Bitcoin-Compatible Bi-directional Payment Channels without Watchtowers" (also applies to Monero with PayMo)
  - <https://eprint.iacr.org/2021/1445>

# Conclusion

Hopefully this brief post has given you some good info and resources to come to your own well-informed conclusions, and can help to dispel some of the common myths and FUD surrounding Monero today.

If you have any questions from this post or would like more information on a specific aspect of the post, please reach out via [Twitter, Matrix, Threema, or email]({{< ref "/content/about.md#how-to-contact-me" >}}).
