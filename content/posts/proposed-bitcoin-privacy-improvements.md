---
title: "Proposed Bitcoin Privacy Improvements"
date: 2022-05-31T14:24:27-04:00
tags:
  - Bitcoin
  - Lightning Network
  - Privacy
  - BIP
  - BOLT
author: "Seth For Privacy"
description: "A list of Bitcoin proposals and ideas to improve privacy that are still a work in progress, were abandoned or never implemented, or failed to make a noticeable impact."
draft: false
---

[Ragnar Lifthrasir asked for a list of Bitcoin proposals](https://twitter.com/Ragnarly/status/1531667098522382336) and ideas to improve privacy that either are still a work in progress, were abandoned or never implemented, or failed to make an impact, and so here is my attempt at just that.

{{< tweet user="Ragnarly" id="1531667098522382336" >}}

This will by no means be an exhaustive list, and I could use any help I can get keeping it up to date or finding historical proposals that have fallen out of favor. The sections below will be broken down by project or implementation and in order of proposal (where possible).

***Note: While some of these proposals were non-starters or have been abandoned, some are interesting and potentially promising proposals. This is not a "hall of shame list", but rather a chance to learn from past proposals and keep up with new ones as we go along.***

## Bitcoin

### Confidential Transactions

> Status: Never formally proposed for Bitcoin

Confidential Transactions (used in Monero since 2017 and Liquid since 2018) are a technique used to blind the amounts in a transaction in way that is still verifiable and provable without revealing amounts to anyone outside of the transaction participants. Miners, nodes, and external observers can still validate that transactions do not create or destroy funds without knowing the true amounts being transferred.

- [Initial proposal/investigation by Greg Maxwell](https://elementsproject.org/features/confidential-transactions/investigation)
- [Confidential Transactions in Elements](https://elementsproject.org/features/confidential-transactions)
- [Ring Confidential Transactions - article on Monero's RingCT implementation of Confidential Transactions](https://eprint.iacr.org/2015/1098.pdf)
- ["How RingCT Hides Monero Transaction Amounts" - LocalMonero](https://localmonero.co/knowledge/monero-ringct)

### Reusable Payment Codes for Hierarchical Deterministic Wallets - BIP 47

> Status: Unanimously discouraged for implementation

The proposal for reusable payment codes is one of the well-known BIPs due to the adoption and usage of it by [Samourai Wallet](https://samouraiwallet.com/) under the name "[PayNym](https://samouraiwallet.com/paynym)". This proposal is similar to stealth addresses in that a single payment code can be used to derive unlinkable on-chain addresses, but differs in that it does not use different addressing formats on-chain and instead relies on a notification transaction to allow the recipient to find their funds on-chain.

PayNyms, despite being rejected/discouraged in BIP 47 have seen quite widespread usage and have recently been implemented in [Sparrow Wallet](https://sparrowwallet.com/) and even by a Bitcoin mining pool, "[Lincoin](https://lincoin.com/)".

- [Original Payment Code BIP - 47](https://github.com/bitcoin/bips/blob/master/bip-0047.mediawiki)

### Stealth Addresses - BIP 63

> Status: Never accepted as a BIP despite being given a BIP number

Stealth Addresses are a novel concept that allows a receiver to share or publish a single static address that senders can derive one-time addresses from, breaking any cryptographic links to the shared/published address on-chain. While this does add considerable overhead to wallet scan times (all transactions must be scanned to see what is owned by your private keys instead of just validating known addresses) it entirely breaks wallet clustering by addresses along with many other key heuristics.

Stealth Addresses were originally proposed for Bitcoin in 2011 on Bitcoin Talk, but were never adopted. Monero, on the other hand, includes Stealth Addresses as they were a core part of the original Cryptonote protocol that Monero was created from.

- [Original Stealth Address BIP - 63](https://github.com/genjix/bips/blob/master/bip-stealth.mediawiki)
- ["How Monero Stealth Addresses Protect Your Identity" - LocalMonero](https://localmonero.co/knowledge/monero-stealth-addresses)
- ["What is Stealth Address technology and Why Does Monero Use It?" - SerHack](https://serhack.me/articles/what-is-stealth-address-technology-monero/)

### PayJoin - BIP 78

> Status: Draft

PayJoin may also be well-known to the Bitcoin privacy crowd as it has gotten some media and minor adoption despite it's official "Draft" status. PayJoin lets the sender and recipient of a transaction work together to build a combined transaction that includes a UTXO (or more) from both the sender and intended recipient of funds, obfuscating the true nature of the payment on-chain.

A similar protocol has been implemented in [Samourai Wallet](https://samouraiwallet.com/) in 2019 (before the PayJoin proposal BIP), and PayJoin proper was implemented in [BTCPay Server](https://btcpayserver.org/) in [June 2020](https://github.com/btcpayserver/btcpayserver/releases/tag/v1.0.5.0) and [JoinMarket](https://github.com/JoinMarket-Org/joinmarket-clientserver) in [August 2020](https://github.com/JoinMarket-Org/joinmarket-clientserver/releases/tag/v0.7.0). See their docs for more info:

- [Stowaway - Samourai Wallet](https://docs.samourai.io/en/spend-tools#stowaway)
- [BTCPay Server Payjoin Guide - BTCPay Server](https://docs.btcpayserver.org/Payjoin/)
- [PayJoin (aka P2EP) user guide - JoinMarket](https://github.com/JoinMarket-Org/joinmarket-clientserver/blob/master/docs/PAYJOIN.md)

Although implemented in some wallets and tools, PayJoin usage unfortunately remains very sparse today.

- [Initial blog post on PayJoin](https://reyify.com/blog/payjoin)
- [Original PayJoin BIP - 78](https://github.com/bitcoin/bips/blob/master/bip-0078.mediawiki)

### Peer-to-Peer Communication Encryption - BIP 151 and BIP 324

> Status: Original BIP 151 withdrawn, new BIP 324 in draft

Peer-to-peer communication encryption is a large and necessary step forward in securing the p2p network in Bitcoin against common attacks and providing basic privacy to those running a node from their ISP and other basic surveillance, and has been proposed for Bitcoin via BIPs 151 and 324.

To quote the author:

> BIP324 proposes a new Bitcoin P2P protocol, which features transport encryption and slightly lower bandwidth usage.

p2p comms encryption is something that is not commonly done in the cryptocurrency space, but is also being worked on in the Monero community (linked below).

- [BIP 324 website](https://bip324.com/)
- [Original BIP - 151](https://github.com/bitcoin/bips/blob/master/bip-0151.mediawiki)
- [Official BIP - 324](https://gist.github.com/dhruv/5b1275751bc98f3b64bcafce7876b489)
- [Monero's investigation into p2p comms encryption](https://github.com/vtnerd/monero/blob/docs_p2p_e2e/docs/LEVIN_PROTOCOL.md)
  - [Issue around Monero's p2p comms proposal](https://github.com/monero-project/monero/issues/7078)

### Dandelion - BIP 156

> Status: Rejected

Dandelion is an approach to bringing plausible deniability to the Bitcoin peer-to-peer network in a way that prevents others on the network from deterministically tying transactions with the originating node. It does this by selecting a set of nodes to transmit the transaction to in series (one at a time, called the "stem" phase) and then only transmit to the rest of the network after a pre-determined number of nodes have also transmitted the transaction (called the "fluff" phase).

Dandelion++, an iteration that resolves many of the problems with the original Dandelion proposal, was implemented in Monero in 2020.

- [Original Dandelion BIP - 156](https://github.com/bitcoin/bips/blob/master/bip-0156.mediawiki)
- ["Dandelion for Monero" - Monero Outreach](https://www.monerooutreach.org/stories/dandelion.html)
- ["How Dandelion++ Keeps Monero's Transaction Origins Private" - LocalMonero](https://localmonero.co/knowledge/monero-dandelion)

### Taproot - BIP 341

> Status: Draft (but actually not, as it's already deployed in Bitcoin via soft-fork)

Taproot is likely the most well-recognized BIP on this list, and has actually been implemented in Bitcoin despite still being marked as "Draft" in the BIP Github repository.

Taproot is really only on this list as it has so far gone practically unused, but as things can move very slowly towards adoption in Bitcoin (especially when optional, as Taproot usage is) it will likely take several years before Taproot is widely used.

Once Taproot is usable for Lightning Network channel opens it will provide good privacy by hiding the script details in each channel open transaction and making it much harder to find channel opens on-chain in Bitcoin. This privacy does break down in the event of a non-cooperative channel close, however, as the script must be revealed in this case on-chain.

- [Original Taproot BIP - 341](https://github.com/bitcoin/bips/blob/master/bip-0341.mediawiki)

### SNICKER

> Status: Abandoned, never formally proposed for Bitcoin

As I don't know much about SNICKER I won't go into detail on my thoughts, but see the quote below for the summary of what the proposal was meant to do:

> SNICKER (Simple Non-Interactive Coinjoin with Keys for Encryption Reused) is a simple method for allowing the creation of a two party coinjoin without any synchronisation or interaction between the participants. It relies on the idea of reused keys (either reused addresses, or identification of ownership of signed inputs and thus pubkeys in signatures).

As far as I can tell the proposal has been abandoned since 2020.

- [SNICKER proposal gist](https://gist.github.com/AdamISZ/2c13fb5819bd469ca318156e2cf25d79)

### CoinSwap

> Status: WIP, but never formally proposed for Bitcoin

CoinSwap was a popular and oft-discussed proposal in 2020 to allow users to swap UTXOs (and thus their associated history), but was met with strong pushback as it does nothing to remove history or break deterministic links.

See the below quote for a simple summary of CoinSwap

> Coinswap is a protocol that allows two or more users to create a set of transactions that look like independent payments but which actually swap their coins with each other, optionally making a payment in the process.

It seemed that CoinSwap has been abandoned as there was no progress since 2020, but recently Chris Belcher launched an implementation of CoinSwap called [Teleport Transactions](https://github.com/bitcoin-teleport/teleport-transactions).

- [CoinSwap design proposal](https://gist.github.com/chris-belcher/9144bd57a91c194e332fb5ca371d0964)
- [CoinSwap topic on Bitcoinops.org](https://bitcoinops.org/en/topics/coinswap/)

### Silent Payments

> Status: WIP, but never formally proposed for Bitcoin

Silent Payments are all the rage in recent Bitcoin discussion, and are similar in some ways to BIP 47 [mentioned above]({{< relref "#reusable-payment-codes-for-hierarchical-deterministic-wallets---bip-47" >}}).

While they also offer the ability to share or publicize a single static payment code and receive payments that are not linkable on-chain, there remain serious tradeoffs in the approach that make light-wallet usage practically impossible and can require complete re-downloading of the Bitcoin blockchain to find new transactions for any new Silent Addresses.

It will be interesting to see this proposal play out but so far the better option appears to be BIP 47 still.

- [Silent Address proposal gist](https://gist.github.com/RubenSomsen/c43b79517e7cb701ebf77eec6dbb46b8)

## Lightning Network

Please note that most of these proposals are still very much a work in progress have yet to be given a clear yes/no approval. As such the Lightning Network proposals are mainly added below as important developments to follow that potentially offer improved privacy when using the Lightning Network.

As the Lightning Network was originally designed as a tool for scalability and not privacy, many of the core design decision initially chosen are extremely detrimental to user privacy. Many of the proposals below are seeking to remedy those issues and hopefully will be able to do so without harming payment reliability or routing efficiency.

### Route Blinding

> Status: WIP

The current Lightning Network suffers from severe issues centered around receiver privacy, and Route Blinding is one of the key proposals seeking to remedy at least a part of this issue.

To quote the proposal:

> Route blinding is a lightweight technique to provide recipient anonymity by blinding an arbitrary amount of hops at the end of an onion path.

Route blinding is still very much a work in progress but shows promise for allowing a receiver to receive funds without deterministically revealing the final node receiving the funds.

- [Route Blinding proposal](https://github.com/lightning/bolts/blob/9ca59ace8f14d6dd5996f5c934823dd0eca23d1d/proposals/route-blinding.md)
- [Route Blinding BOLT PR](https://github.com/lightning/bolts/pull/765)

### Trampoline Onion Routing

> Status: WIP

While not stricly a privacy improvement, Trampoline Onion Routing can provide better route privacy in some scenarios for the receiver and so is mentioned here. It can also be paired with route blinding to provide even better receive privacy, especially for use-cases where you cannot run a full node or construct entire routes yourself for whatever reason.

The full privacy implications are still under consideration, but it will be an interesting proposal to follow along with.

- [Trampoline Onion Routing proposal](https://github.com/lightning/bolts/blob/038575ac38ced9eee5ace09dd5ec9ba7515cad55/proposals/trampoline.md)
- [Trampoline Onion Routing BOLT documentation PR](https://github.com/lightning/bolts/pull/829)
- [Trampoline Onion Routing BOLT specification PR](https://github.com/lightning/bolts/pull/836)

### Alias SCID

> Status: WIP

One of the critical privacy issues in Lightning today is the fact that nodes have permanent aliases and pubkeys that are used for gossip and channel management, and as such any receipt of payments leaks your nodes alias and pubkey to the sender of the payment.

The key approach to resolving this issue in Lightning is something called "Alias SCID", which allows you to force your peers to only refer to you or your channels by an alias which can be unique to each peer and/or channel.

- [Alias SCID BOLT PR](https://github.com/lightning/bolts/pull/910)

### Offers - BOLT 12

> Status: WIP

BOLT 12 is a combination of many of the other proposed improvements and integrates them into a new and much more flexible invoice type for Lightning, also called an "offer". The implementation of BOLT 12 alongside route blinding and node alias SCIDs would be a big step forward for both privacy and user experience in Lightning, and is somewhat of the current holy grail of proposals.

Be sure to keep an eye on its development if you use or are interested in the Lightning Network as it promises to fix many of the current issues.

- [Website](https://bolt12.org/)
- [Offers BOLT PR](https://github.com/lightning/bolts/pull/798)

## Sidechains

### The Liquid Network

The Liquid Network is a Bitcoin-pegged and federated side-chain for Bitcoin that allows users to peg BTC to redeem it for L-BTC and then be able to transact on the Liquid Network.

Liquid provides moderate privacy improvements over on-chain Bitcoin due to its use of Confidential Transaction and is extremely cheap to transact in.

Users should be very aware that Liquid is a federated model where *custodians hold the keys to your Bitcoin*, and thus your funds are at risk of loss or theft and you should not assume you will always be able to convert back to BTC.

But Liquid remains practically unused even after four years of being in the wild and heavy marketing: <https://liquid.network/>

{{< figure src="/proposed-bitcoin-privacy-improvements/liquid_sadpool.png" align="center" style="border-radius: 8px;" >}}

- [Official website](https://liquid.net/)

### FediMint

FediMint (and the specific initial implementation, minimint) is a relatively new proposal for building a federated Chaumian-blinded eCash as a side-chain to Bitcoin, denominated in Bitcoin. These federated side-chains would be relatively small, interoperable, and would compete on reputation, uptime, and fees.

While it is still very much a work in progress, minimint holds promise for a middle-ground between fully self-sovereign Lightning Network usage (Zeus, Core LN, LND, etc.) and single-custodian Lightning Network usage (Cash App, Strike, etc.) by allowing a trusted federation of custodians to hold funds and manage Lightning node(s) for their users.

{{< figure src="/proposed-bitcoin-privacy-improvements/fedimint.jpeg" align="center" style="border-radius: 8px;" >}}

[Image Credit - @ODELL](https://twitter.com/ODELL/status/1531648367658401792)

Note that the proposal is still fully custodial, but has differing tradeoffs compared to something like [the Liquid Network]({{< relref "#the-liquid-network" >}}).

- [FediMint website](https://fedimint.org/)
- [minimint Github repository](https://github.com/fedimint/minimint)

# Conclusion

If you have any questions from this post or would like more information on a specific aspect, please reach out via [Signal, Matrix, Threema, or email]({{< ref "/content/about.md#how-to-contact-me" >}}).
