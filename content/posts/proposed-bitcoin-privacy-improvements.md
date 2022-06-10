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

***Note: While some of these proposals were non-starters or have been abandoned, some are interesting and potentially promising proposals. This is not a "hall of shame", but rather a chance to learn from past proposals and keep up with new ones as we go along.***

## Bitcoin

### Confidential Transactions

> ***Status:*** Never formally proposed for Bitcoin

> ***Pros:*** Drastically improved privacy against amount-based heuristics; enables greatly improved and more flexible app-layer privacy tools for Bitcoin (i.e. unequal output CoinJoins)

> ***Cons:*** Supply auditability becomes more complex (but is still possible) and relies on more advanced cryptography; Transaction sizes and verification times are both significantly increased

Confidential Transactions (used in Monero since 2017 and Liquid since 2018) are a technique used to blind the amounts in a transaction in way that is still verifiable and provable without revealing amounts to anyone outside of the transaction participants. Miners, nodes, and external observers can still validate that transactions do not create or destroy funds without knowing the true amounts being transferred.

- [Initial proposal/investigation by Greg Maxwell](https://elementsproject.org/features/confidential-transactions/investigation)
- [Confidential Transactions in Elements](https://elementsproject.org/features/confidential-transactions)
- [Ring Confidential Transactions - article on Monero's RingCT implementation of Confidential Transactions](https://eprint.iacr.org/2015/1098.pdf)
- ["How RingCT Hides Monero Transaction Amounts" - LocalMonero](https://localmonero.co/knowledge/monero-ringct)

### Reusable Payment Codes for Hierarchical Deterministic Wallets - BIP 47

> ***Status:*** Unanimously discouraged for implementation

> ***Pros:*** Much easier receipt of funds to a static address while preserving privacy; No direct link between payment code and on-chain addresses/transactions (unlike static Bitcoin addresses)

> ***Cons:*** Most versions require a notification transaction to be sent on-chain so that the recipient knows how to look for funds sent to them; Notification transaction can undermine privacy if done incorrectly

The proposal for reusable payment codes is one of the well-known BIPs due to the adoption and usage of it by [Samourai Wallet](https://samouraiwallet.com/) under the name "[PayNym](https://samouraiwallet.com/paynym)". This proposal is similar to stealth addresses in that a single payment code can be used to derive unlinkable on-chain addresses, but differs in that it does not use different addressing formats on-chain and instead relies on a notification transaction to allow the recipient to find their funds on-chain.

PayNyms, despite being rejected/discouraged in BIP 47 have seen quite widespread usage and have recently been implemented in [Sparrow Wallet](https://sparrowwallet.com/) and even by a Bitcoin mining pool, "[Lincoin](https://lincoin.com/)".

A [great summary of the three main reusable payment code schemes has been provided by Ruben Somsen](https://gist.github.com/Kixunil/0ddb3a9cdec33342b97431e438252c0a?permalink_comment_id=4013454#gistcomment-4013454), the author of [Silent Payments]({{< relref "#silent-payments" >}}) in the gist for [Reusable Taproot addresses](#reusable-taproot-addresses).

- [Original Payment Code BIP - 47](https://github.com/bitcoin/bips/blob/master/bip-0047.mediawiki)

### Stealth Addresses - BIP 63

> ***Status:*** Never accepted as a BIP despite being given a BIP number

> ***Pros:*** When enforced, prevents all links between off-chain addresses/pubkeys and on-chain one-time addresses; Breaks all address-based heuristics

> ***Cons:*** Wallets now have to scan all transactions to validate which ones are owned by the user's private keys; Can no longer do simple address-based wallet sync

Stealth Addresses are a novel concept that allows a receiver to share or publish a single static address that senders can derive one-time addresses from, breaking any cryptographic links to the shared/published address on-chain. While this does add considerable overhead to wallet scan times (all transactions must be scanned to see what is owned by your private keys instead of just validating known addresses) it entirely breaks wallet clustering by addresses along with many other key heuristics.

Stealth Addresses were originally proposed for Bitcoin in 2011 on Bitcoin Talk, but were [abandoned as a BIP after `OP_RETURN` was changed](https://www.reddit.com/r/Bitcoin/comments/5xm9bt/comment/dejcjmw/?utm_source=share&utm_medium=web2x&context=3):

> OP_RETURN got changed to 40 bytes at the last minute, preventing my stealth address standard from working, and moved on to work on other things. - u/petertodd

While Dark Wallet did implement stealth addresses for Bitcoin, the wallet never officially launched and was abandoned. Monero, on the other hand, includes Stealth Addresses as they were a core part of the original Cryptonote protocol that Monero was created from.

- [Original Stealth Address BIP - 63](https://github.com/genjix/bips/blob/master/bip-stealth.mediawiki)
- ["How Monero Stealth Addresses Protect Your Identity" - LocalMonero](https://localmonero.co/knowledge/monero-stealth-addresses)
- ["What is Stealth Address technology and Why Does Monero Use It?" - SerHack](https://serhack.me/articles/what-is-stealth-address-technology-monero/)

### PayJoin - BIP 78

> ***Status:*** Draft

> ***Pros:*** Creates transactions that look normal but break common heuristics; Easy to perform when supported by the recipient

> ***Cons:*** Requires hot wallet on the merchant/recipient side, cannot send to simple address etc.; Malicious sender can attempt to force recipient to reveal UTXOs (attack is mitigated if properly implemented)

PayJoin may also be well-known to the Bitcoin privacy crowd as it has gotten some media and minor adoption despite it's official "Draft" status. PayJoin lets the sender and recipient of a transaction work together to build a combined transaction that includes a UTXO (or more) from both the sender and intended recipient of funds, obfuscating the true nature of the payment on-chain.

A similar protocol has been implemented in [Samourai Wallet](https://samouraiwallet.com/) in 2019 as "Stowaway" (before the PayJoin proposal BIP), and PayJoin proper was implemented in [BTCPay Server](https://btcpayserver.org/) in [June 2020](https://github.com/btcpayserver/btcpayserver/releases/tag/v1.0.5.0), [JoinMarket](https://github.com/JoinMarket-Org/joinmarket-clientserver) in [August 2020](https://github.com/JoinMarket-Org/joinmarket-clientserver/releases/tag/v0.7.0), [Blue Wallet](https://bluewallet.io) in [October 2020](https://twitter.com/bluewalletio/status/1313822205286010883), and [Sparrow Wallet](https://sparrowwallet.com/) in [November 2020](https://github.com/sparrowwallet/sparrow/releases/tag/0.9.7). See their docs for more info:

- [Stowaway - Samourai Wallet](https://docs.samourai.io/en/spend-tools#stowaway)
- [BTCPay Server PayJoin Guide - BTCPay Server](https://docs.btcpayserver.org/Payjoin/)
- [PayJoin (aka P2EP) user guide - JoinMarket](https://github.com/JoinMarket-Org/joinmarket-clientserver/blob/master/docs/PAYJOIN.md)
- [Paying to a PayNym - Sparrow Wallet](https://sparrowwallet.com/docs/spending-privately.html#paying-to-a-paynym)

Although implemented in some wallets and tools, PayJoin usage unfortunately seems to remain very sparse today (though it's hard to detect on-chain so might be higher than we realize). Most of the lack of adoption appears to be due to the need to keep hot keys on the merchant side in order to support PayJoin which many merchants are unwilling to do for the advantages PayJoin brings.

- [Initial blog post on PayJoin](https://reyify.com/blog/payjoin)
- [Original PayJoin BIP - 78](https://github.com/bitcoin/bips/blob/master/bip-0078.mediawiki)
- [PayJoin Adoption - Bitcoin Wiki](https://en.bitcoin.it/wiki/PayJoin_adoption)

### Peer-to-Peer Communication Encryption - BIP 151 and BIP 324

> ***Status:*** Original BIP 151 withdrawn, new BIP 324 in draft

> ***Pros:*** Prevents simple snooping by ISPs and mobile carriers; Prevents man-in-the-middle attacks by rogue nodes pretending to be your specified remote node; Can pin known-good nodes to ensure you have healthy nodes as peers

> ***Cons:*** Increased overhead in p2p protocol; New DoS vectors created by the use of encryption; Does not fully prevent deep packet inspection by ISPs etc.

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

> ***Status:*** Rejected

> ***Pros (specifically Dandelion++ iteration):*** Prevents deterministic linking of transactions back to their originating node by active surveillance of the p2p network; Provides strong network-level privacy without necessitating use of an anonymity network (which have their own serious DoS/Sybil issues)

> ***Cons (specifically Dandelion++ iteration):*** Transaction broadcast takes much longer (usually 1-1.5min for complete propagation instead of just a few seconds); Opens up new DoS vectors if using a malicious remote node and not your own

Dandelion is an approach to bringing plausible deniability to the Bitcoin peer-to-peer network in a way that prevents others on the network from deterministically tying transactions with the originating node. It does this by selecting a set of nodes to transmit the transaction to in series (one at a time, called the "stem" phase) and then only transmit to the rest of the network after a pre-determined number of nodes have also transmitted the transaction (called the "fluff" phase).

Dandelion++, an iteration that resolves many of the problems with the original Dandelion proposal, was implemented in Monero in 2020.

- [Original Dandelion BIP - 156](https://github.com/bitcoin/bips/blob/master/bip-0156.mediawiki)
- [Dandelion++ journal article](https://arxiv.org/pdf/1805.11060.pdf)
- ["Dandelion for Monero" - Monero Outreach](https://www.monerooutreach.org/stories/dandelion.html)
- ["How Dandelion++ Keeps Monero's Transaction Origins Private" - LocalMonero](https://localmonero.co/knowledge/monero-dandelion)

### Taproot - BIP 341

> ***Status:*** Draft (but actually not, as it's already deployed in Bitcoin via soft-fork)

> ***Pros:*** Drastically improved privacy when using scripts (like multi-sig or Lightning channel opens/closes) assuming broad adoption; More scripting possibilities via Tapscript; Potential efficiency improvements, batching, etc.

> ***Cons:*** Non-cooperative channel-close transactions must still reveal script, negating privacy gains in those situations

Taproot is likely the most well-recognized BIP on this list, and has actually been implemented in Bitcoin despite still being marked as "Draft" in the BIP Github repository.

Taproot is really only on this list as it has so far gone practically unused, but as things can move very slowly towards adoption in Bitcoin (especially when optional, as Taproot usage is) it will likely take several years before Taproot is widely used.

Once Taproot is usable for Lightning Network channel opens it will provide good privacy by hiding the script details in each channel open transaction and making it much harder to find channel opens on-chain in Bitcoin. This privacy does break down in the event of a non-cooperative channel close, however, as the script must be revealed in this case on-chain.

- [Original Taproot BIP - 341](https://github.com/bitcoin/bips/blob/master/bip-0341.mediawiki)

### SNICKER

> ***Status:*** Abandoned, never formally proposed for Bitcoin

As I don't know much about SNICKER I won't go into detail on my thoughts, but see the quote below for the summary of what the proposal was meant to do:

> SNICKER (Simple Non-Interactive Coinjoin with Keys for Encryption Reused) is a simple method for allowing the creation of a two party coinjoin without any synchronisation or interaction between the participants. It relies on the idea of reused keys (either reused addresses, or identification of ownership of signed inputs and thus pubkeys in signatures).

As far as I can tell the proposal has been abandoned since 2020 outside of a [partial implementation in JoinMarket](https://github.com/JoinMarket-Org/joinmarket-clientserver/blob/master/docs/SNICKER.md).

- [SNICKER proposal gist](https://gist.github.com/AdamISZ/2c13fb5819bd469ca318156e2cf25d79)
- [Partial implementation of SNICKER in JoinMarket](https://github.com/JoinMarket-Org/joinmarket-clientserver/blob/master/docs/SNICKER.md)

### CoinSwap

> ***Status:*** WIP, but never formally proposed for Bitcoin

> ***Pros:*** Appears to be a normal transaction type on-chain

> ***Cons:*** Does not actually obfuscate or break any on-chain history, it merely attempts to break simple ownership heuristics; Allows those with tainted funds to swap for "clean" funds to the detriment of the swap participant; No clear privacy advantages in most situations

CoinSwap was a popular and oft-discussed proposal in 2020 to allow users to swap UTXOs (and thus their associated history), but was met with strong push-back as it does nothing to remove history or break deterministic links.

See the below quote for a simple summary of CoinSwap

> Coinswap is a protocol that allows two or more users to create a set of transactions that look like independent payments but which actually swap their coins with each other, optionally making a payment in the process.

It seemed that CoinSwap has been abandoned as there was no progress since 2020, but recently Chris Belcher launched an implementation of CoinSwap called [Teleport Transactions](https://github.com/bitcoin-teleport/teleport-transactions).

- [CoinSwap design proposal](https://gist.github.com/chris-belcher/9144bd57a91c194e332fb5ca371d0964)
- [CoinSwap topic on Bitcoinops.org](https://bitcoinops.org/en/topics/coinswap/)

### Silent Payments

> ***Status:*** WIP, not yet formally proposed for Bitcoin

> ***Pros:*** Much easier receipt of funds to a static address while preserving privacy; No direct link between payment code and on-chain addresses/transactions (unlike static Bitcoin addresses); Does not require on-chain notification transaction, unlike [BIP 47]({{< relref "#reusable-payment-codes-for-hierarchical-deterministic-wallets---bip-47" >}})

> ***Cons:*** Currently completely incompatible with light-wallets; Adding a new Silent Payment code after IBD requires completely restarting IBD; Requires constant scanning of the blockchain for new uses/transactions

Silent Payments are all the rage in recent Bitcoin discussion, and are similar in some ways to BIP 47 [mentioned above]({{< relref "#reusable-payment-codes-for-hierarchical-deterministic-wallets---bip-47" >}}).

While they also offer the ability to share or publicize a single static payment code and receive payments that are not linkable on-chain, there remain serious tradeoffs in the approach that make light-wallet usage practically impossible and can require complete re-downloading of the Bitcoin blockchain to find new transactions for any new Silent Addresses.

It will be interesting to see this proposal play out but so far the better option appears to be BIP 47 still.

A [great summary of the three main reusable payment code schemes has been provided by Ruben Somsen](https://gist.github.com/Kixunil/0ddb3a9cdec33342b97431e438252c0a?permalink_comment_id=4013454#gistcomment-4013454), the author of Silent Payments in the gist for [Reusable Taproot addresses](#reusable-taproot-addresses).

- [Silent Address proposal gist](https://gist.github.com/RubenSomsen/c43b79517e7cb701ebf77eec6dbb46b8)

### Reusable Taproot addresses

> ***Status:*** WIP, not yet formally proposed for Bitcoin

> ***Pros:*** Much easier receipt of funds to a static address while preserving privacy; No direct link between payment code and on-chain addresses/transactions (unlike static Bitcoin addresses); Combines first payment and notification into one "real" transaction, unlike [BIP 47]({{< relref "#reusable-payment-codes-for-hierarchical-deterministic-wallets---bip-47" >}}); Notification transaction appears just like any other Taproot spend on-chain

> ***Cons:*** Sender and receiver both must support and use Taproot; Sender needs to follow a special protocol to be able to recover from backup

While this proposal bears many similarities to [BIP 47]({{< relref "#reusable-payment-codes-for-hierarchical-deterministic-wallets---bip-47" >}}) and [Silent Payments]({{< relref "#silent-payments" >}}), it leverages new capabilities in Taproot to essentially improve on the tradeoffs taken by BIP 47 reusable payment codes. A [great summary has been provided by Ruben Somsen](https://gist.github.com/Kixunil/0ddb3a9cdec33342b97431e438252c0a?permalink_comment_id=4013454#gistcomment-4013454), the author of [Silent Payments]({{< relref "#silent-payments" >}}) in the gist below:

> ***Reusable Taproot addresses:***
>
> - No continuous scanning of every transaction
> - One-time interaction with the recipient (stateful for sender: if they forget, they need to interact again)
> - No on-chain footprint
> - Sender needs to follow a special protocol to be able to recover from backup (this downside can be mitigated, see below)
>
> ***BIP 47:***
>
> - No continuous scanning of every transaction
> - No interaction with the recipient
> - On-chain footprint (or alternatively one-time interaction and stateful backups)
>
> ***Silent Payments:***
>
> - Continuous scanning of every transaction (increases cost of running full node)
> - No interaction with the recipient
> - No on-chain footprint

- [Reusable Taproot addresses proposal gist](https://gist.github.com/Kixunil/0ddb3a9cdec33342b97431e438252c0a)
- [Proof-of-concept implementation](https://github.com/w0xlt/reusable-taproot-addresses)

## Lightning Network

Please note that most of these proposals are still very much a work in progress have yet to be given a clear yes/no approval. As such the Lightning Network proposals are mainly added below as important developments to follow that potentially offer improved privacy when using the Lightning Network.

As the Lightning Network was originally designed as a tool for scalability and not privacy, many of the core design decision initially chosen are extremely detrimental to user privacy. Many of the proposals below are seeking to remedy those issues and hopefully will be able to do so without harming payment reliability or routing efficiency.

### Route Blinding

> ***Status:*** WIP

> ***Pros:*** Prevents sender from ascertaining full route to recipient; Hides recipient node alias/pubkey; Provides much better recipient privacy overall vs current transparent routing methods; Can provide better payment success rate by providing local routing data in some specific scenarios

> ***Cons:*** Can be difficult to craft blinded routes in specific routing graph scenarios; Can have a negative impact on payment success rate in specific scenarios

The current Lightning Network suffers from severe issues centered around receiver privacy, and Route Blinding is one of the key proposals seeking to remedy at least a part of this issue.

To quote the proposal:

> Route blinding is a lightweight technique to provide recipient anonymity by blinding an arbitrary amount of hops at the end of an onion path.

Route blinding is still very much a work in progress but shows promise for allowing a receiver to receive funds without deterministically revealing the final node receiving the funds.

- [Route Blinding proposal](https://github.com/lightning/bolts/blob/9ca59ace8f14d6dd5996f5c934823dd0eca23d1d/proposals/route-blinding.md)
- [Route Blinding BOLT PR](https://github.com/lightning/bolts/pull/765)

### Trampoline Onion Routing

> ***Status:*** WIP

> ***Pros:*** Can allow light-wallets to craft routes in a privacy-preserving way without a full route graph; Can be used to provide receiver privacy from the sender (but not the trampoline node AFAICT)

> ***Cons:*** None that I know of at this time

While not strictly a privacy improvement, Trampoline Onion Routing can provide better route privacy in some scenarios for the receiver and so is mentioned here. It can also be paired with route blinding to provide even better receive privacy, especially for use-cases where you cannot run a full node or construct entire routes yourself for whatever reason.

The full privacy implications are still under consideration, but it will be an interesting proposal to follow along with.

- [Trampoline Onion Routing proposal](https://github.com/lightning/bolts/blob/038575ac38ced9eee5ace09dd5ec9ba7515cad55/proposals/trampoline.md)
- [Trampoline Onion Routing BOLT documentation PR](https://github.com/lightning/bolts/pull/829)
- [Trampoline Onion Routing BOLT specification PR](https://github.com/lightning/bolts/pull/836)

### Alias SCID

> ***Status:*** WIP

> ***Pros:*** Prevents simple linking of payments to single node alias/pubkey by using a unique alias per channel/peer

> ***Cons:*** None that I know of at this time

One of the critical privacy issues in Lightning today is the fact that nodes have permanent aliases and pubkeys that are used for gossip and channel management, and as such any receipt of payments leaks your nodes alias and pubkey to the sender of the payment.

The key approach to resolving this issue in Lightning is something called "Alias SCID", which allows you to force your peers to only refer to you or your channels by an alias which can be unique to each peer and/or channel.

- [Alias SCID BOLT PR](https://github.com/lightning/bolts/pull/910)

### Offers - BOLT 12

> ***Status:*** WIP

> ***Pros:*** Drastically improved privacy and flexibility for payments as the recipient; Much smaller QR codes and much less data needed in the offer itself (as the necessary data is collected from the recipients node directly instead of being all included in the invoice as in BOLT 11 invoices)

> ***Cons:*** None that I know of at this time

BOLT 12 is a combination of many of the other proposed improvements and integrates them into a new and much more flexible invoice type for Lightning, also called an "offer". The implementation of BOLT 12 alongside route blinding and node alias SCIDs would be a big step forward for both privacy and user experience in Lightning, and is somewhat of the current holy grail of proposals.

Be sure to keep an eye on its development if you use or are interested in the Lightning Network as it promises to fix many of the current issues.

- [Website](https://bolt12.org/)
- [BOLT 12 - Offers BOLT PR](https://github.com/lightning/bolts/pull/798)

## Side-chains

### The Liquid Network

> ***Status:*** Live since 2018

> ***Pros:*** Mildly improved per-transaction privacy due to Confidential Transactions (but mostly useless due to almost no usage reducing crowd to hide in); Cheaper fees than on-chain

> ***Cons:*** Custodial (via a federation); Almost no usage gives you almost no crowd to hide in; Past issues with "emergency" multisig being held by very few parties

The Liquid Network is a Bitcoin-pegged and federated side-chain for Bitcoin that allows users to peg BTC to redeem it for L-BTC and then be able to transact on the Liquid Network.

Liquid provides moderate privacy improvements over on-chain Bitcoin due to its use of Confidential Transaction and is extremely cheap to transact in.

Users should be very aware that Liquid is a federated model where *custodians hold the keys to your Bitcoin*, and thus your funds are at risk of loss or theft and you should not assume you will always be able to convert back to BTC.

But Liquid remains practically unused even after four years of being in the wild and heavy marketing: <https://liquid.network/>

{{< figure src="/proposed-bitcoin-privacy-improvements/liquid_sadpool.png" align="center" style="border-radius: 8px;" >}}

- [Official website](https://liquid.net/)

### FediMint

> WIP

> ***Pros:*** Very strong privacy when transacting within the side-chain; Interoperable with the Lightning Network without requiring each user to run a node/manage channels/etc.; Anyone can start a new minimint, not just specific people/groups; Can choose a specific minimint to used based on federation members reputation, trust, etc.; Can serve as a middle-ground between self-sovereign Lightning (Zeus, Core LN, LND, etc.) and "single-custodian" Lightning (Wallet of Satoshi, Cash App, Strike, etc.) while retaining user privacy from custodians

> ***Cons:*** Custodial (via federations); Potential regulatory pressure on federation members due to custody/transfer of user's funds; Centralization of Lightning Network due to users not running their own node/managing channels/etc. and instead relying on federation Lightning services

FediMint (and the specific initial implementation, minimint) is a relatively new proposal for building a federated Chaumian-blinded eCash as a side-chain to Bitcoin, denominated in Bitcoin. These federated side-chains would be relatively small, interoperable, and would compete on reputation, uptime, and fees.

While it is still very much a work in progress, minimint holds promise for a middle-ground between fully self-sovereign Lightning Network usage (Zeus, Core LN, LND, etc.) and single-custodian Lightning Network usage (Cash App, Strike, etc.) by allowing a trusted federation of custodians to hold funds and manage Lightning node(s) for their users.

{{< figure src="/proposed-bitcoin-privacy-improvements/fedimint.jpeg" align="center" style="border-radius: 8px;" >}}

[Image Credit - @ODELL](https://twitter.com/ODELL/status/1531648367658401792)

Note that the proposal is still fully custodial, but has differing tradeoffs compared to something like [the Liquid Network]({{< relref "#the-liquid-network" >}}).

- [FediMint website](https://fedimint.org/)
- [minimint Github repository](https://github.com/fedimint/minimint)

# Conclusion

If you have any questions from this post or would like more information on a specific aspect, please reach out via [Signal, Matrix, Threema, or email]({{< ref "/content/about.md#how-to-contact-me" >}}).
