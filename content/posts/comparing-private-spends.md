+++
title = "Comparing Reasonably Private Spends"
date = "2020-11-28T16:37:10Z"
author = "Seth Simmons"
authorTwitter = "sethisimmons" #do not include @
cover = ""
tags = ["Monero", "Bitcoin", "Zcash"]
keywords = ["Monero", "Bitcoin", "Zcash", "privacy", "efficiency"]
description = ""
showFullContent = false
draft = true
+++

# Comparing "Reasonably Private" Spends in Bitcoin, Monero, and Zcash

## Introduction
As my first blog post I wanted to go ahead and share some thoughts I've had about efficiency within transaction types 
when comparing privacy protocols and usage.

I have recently discussed this in some depth [on Twitter](https://twitter.com/sethisimmons/status/1285336820264382468?s=20) 
where I was surprised by the results, finding that Monero manages to be quite a bit more efficient on size compared to 
Bitcoin when trying to use both in a private manner. I'll use this blog post to break it down in a bit more detail,
and add a new contender to the mix -- Zcash.

But first, an introduction to each approach to privacy.

### Bitcoin

[Bitcoin](https://bitcoin.org/en/) is the king of cryptocurrencies and made major breakthroughs that enabled the existence of cryptocurrencies 
like Monero and Zcash. While many thought it's approach to privacy sufficient in the early days, people quickly realized
that the pseudonymity it offered was insufficient for many use cases and allowed users to very easily ruin their own
privacy via things like combining outputs, re-using addresses, and simple output amount analysis among many other
heuristics.

There are currently two main approaches to gaining some level of "reasonable privacy" on Bitcoin, using CoinJoin[^1] to 
obfuscate UTXO ownership, and the Lightning Network[^2] to move the trail of funds off-chain (to some extent).

CoinJoin is a technique where a group of unique users use a central coordinator to build a shared transaction that 
combines all of their input UTXOs of the same fixed amount and then "mixes" these funds to break deterministic links 
between the input UTXOs and output addresses. The most well known approaches to this are 
[Samourai](https://samouraiwallet.com/), [Wasabi](https://www.wasabiwallet.io/), and 
[JoinMarket](https://github.com/Joinmarket-Org/joinmarket-clientserver/releases).

For this blog post we'll focus on Samourai wallet, as that is most widely accepted as the ideal way to gain privacy in 
Bitcoin at the moment. For more information on how the basics of Samourai Wallet work, see 
[here](https://www.bitcoinqna.com/post/samourai-101) for a great explainer.

[^1]: For more info see https://bitcoinmagazine.com/articles/coinjoin-combining-bitcoin-transactions-to-obfuscate-trails-and-increase-privacy-1465235087  
[^2]: For more info see https://blog.bitmex.com/the-lightning-network/

### Monero

[Monero](https://www.getmonero.org/) was created in 2014 as a fork of a project called “Bytecoin” by a small community of developers. Monero is not a 
fork of Bitcoin, and uses an entirely new codebase called “Cryptonote”[^3] that has evolved into the Monero protocol. 
Monero was started with three core aims -- privacy that is usable and approachable for the masses, by-default, a 
 scalable and iterating base-layer, and ASIC-resistance to enable commodity hardware mining, which aids decentralization
  of mining.
  
Monero enables this default privacy for all users of the network through a variety of means:

- RingCT[^4]: this technology hides all amounts sent and received on-chain, as well as hides which output is actually 
being spent among (currently) 10 others. This requires no coordination (unlike CoinJoin) and happens entirely via the 
protocol itself.  
- Stealth addresses[^5]: this technology hides sender and receiver addresses on-chain by letting the sender generate a 
one-time address using the receiver’s public key, so no actual addresses are ever published to the blockchain.  
- Dandelion++[^6]: This technology helps to hide the sender’s IP address when sending Monero by using a special method 
of relaying transactions to other nodes.  

These technologies combine to allow any user interacting with the Monero network to gain strong privacy without taking 
extra effort, making multiple transactions, or relying on a central coordinator.

[^3]: https://cryptonote.org/whitepaper.pdf
[^4]: https://www.getmonero.org/resources/moneropedia/ringCT.html
[^5]: https://www.getmonero.org/resources/moneropedia/stealthaddress.html
[^6]: https://www.monerooutreach.org/stories/dandelion.html

### Zcash

[Zcash](https://z.cash) is a fork of Bitcoin created in 2016 that adds on optional privacy via a technology called 
zk-SNARKs[^7], allowing users to opt-in to hiding the sender, receiver, and amount of a given transaction (if sending 
from a z-address to another z-address).

Zcash retains many of the network characteristics of Bitcoin, but does enable vastly greater privacy to those users who 
choose to opt-in. Unfortunately, because these strong privacy tools are not enabled by default for users, they see very 
little adoption and normal, Bitcoin-like transactions are by far the majority of transactions made on the Zcash network.

For more info on how Zcash works technically, see [here](https://z.cash/technology/) for a solid introduction.

[^7]: [https://z.cash/technology/zksnarks/](https://z.cash/technology/zksnarks/)

## Comparing Size and Cost

As comparing across unique networks is very difficult, I've done my best to find a unifying set of metrics that we can 
more easily compare, and used the common denominator of USD as a fee measure, as measuring in native units is not easily
 comparable.

Some more notes on the exact comparison transactions used here:

#### Bitcoin 

This example chain of transactions represents the recommended way to gain "reasonable privacy" and spend in 
Bitcoin, and requires a TX0 pre-mix transaction, a Whirlpool mixing transaction, and a post-mix transaction (here a 
STONEWALL transaction is used for the comparison, as this is most common and does not require a trusted second part).

#### Monero

This example transaction is a standard 1-in 2-out Monero transaction with the present network technology, and 
represents the most common spend. Note that no preparatory, mixing, or post-mix transactions are necessary to protect 
the sender, receiver, and amount, or to break any deterministic links along the way.

#### Zcash

This example transaction is a standard 1-in 2-out z-to-z transaction in Zcash, and represents the highest level of 
privacy available to users who opt-in to sending from and to a z-address (fully shielded). This type of transaction 
hides the sender, receiver, and amount on-chain. Note that no preparatory, mixing, or post-mix transactions are 
necessary to protect the sender, receiver, and amount, or to break any deterministic links along the way.

### Results

As you can see below, Monero offers the most cost and space-efficient transactions of the three networks, saving almost 
900b per "reasonably private" spend compared to comparable transactions in Bitcoin and Zcash, and is 33% the cost of 
Zcash and 0.0002% the cost of Bitcoin.

The largest caveat here for the scaling of Monero is that it is not currently fully pruneable in the same way as 
Bitcoin (can prune down to just the current UTXO set), and requires retaining a database of all outputs to use as decoys 
in each future transaction as no output is ever known-spent by the network. Zcash is (as far as I can tell) not 
pruneable in any way at present.

It's important to note that most users of both Zcash and Bitcoin do not opt into using these privacy tools, and instead 
choose to transact without hiding sender/receiver/amount for the vast majority of transactions.

For more info on comparing the frequency of spends utilizing these privacy tools, see a recent Tweet thread from 
@JEhrenhofer [here](https://twitter.com/JEhrenhofer/status/1332552672185098240?s=20).

| Cryptocurrency | Transaction Size | Transaction Cost (in USD) |
| ---| --- | --- |
| Bitcoin | 2,363b, 1,475vb | $8.75 @ 50sat/vb (excluding "doxxic" change and mixing fees) |
| Monero  | 1,419b | $0.002 (median as of 11/29) |
| Zcash   | 2,373b | $0.0066 (median as of 11/29) |


## Throughput

Throughput is an even harder metric to measure across networks, as each network has made their own choices of block 
size and block time to match their own needs and goals. To provide a common ground here, I've chosen to list the default
 limits/times of each network and the throughput that allows, as well as provide a version of each weighted to Bitcoin's
  design choices of 10min block times and 2MB/4MB block size caps.
  
Some more details of each network:

#### Bitcoin

Bitcoin has retained the 10min block times from it's inception, but block sizes have been changed (kind of) with the 
introduction of SegWit[^8] to a maximum of 4MB for native SegWit transactions, and 2MB for "legacy" transactions. To 
provide the optimal network conditions for this comparison, I am assuming a 100% native SegWit adoption, something that 
is not even close to reality, but provides a better picture of what is *possible* in Bitcoin natively.

More details of how the weighting of transactions works in Bitcoin can be found [here](https://bitcoin.stackexchange.com/questions/98810/whats-the-blocksize-limit-after-segwit-and-how-do-legacy-nodes-deal-with-segwit).

[^8]: https://bitcoinmagazine.com/what-is-bitcoin/what-is-segwit

#### Monero

The Monero network has a block time of 2min, but has a more complex block size limit than most other networks. In 
Monero, block sizes have a median and a hard cap that can both be expanded by miners at the expense of block subsidy 
penalties proportional to the block size increase. For the calculations below I've chosen the default block size hard 
cap, but the Monero network can easily and smoothly scale up without any developer intervention or software releases.

For more info on how this dynamic block scaling works, see [here](https://localmonero.co/knowledge/dynamic-block-size).

#### Zcash

Zcash uses similar properties to the Bitcoin network, but with a reduced block time of only 1.25min between blocks. It 
does, however, retain the 2MB hard cap for block sizes from Bitcoin. As SegWit is not supported, there is no complicated
 block limit differences to discuss here.

### Results

As you can see below, due to the much more space-efficient transactions in Monero, you can support the most 
Bitcoin-weighted TPS when comparing "reasonably private" spends across the three networks.

Note that Zcash technically supports the highest TPS natively, but combining their very quick block times with full 
blocks would lead to difficulties for nodes and a quickly growing blockchain.

| Cryptocurrency | Block Time | Block Size Limit | Max TPS/10min | Max TPS/10min weighted to Bitcoin block size |  
| ---| --- | --- | --- | -- |  
| Bitcoin | 10min | median of 2MB, hard cap of 4MB | ~2,750 (with SegWit) | ~2,750 (with SegWit) |  
| Monero  | 2min | Initial median of 300KB, hard cap of 600KB | ~2,150 | ~2,900 (w/o SegWit) |  
| Zcash   | 1.25min | 2MB | ~6,900 | ~1,725 (w/o SegWit) |  

## Conclusion

To summarize the findings here, we see that while Monero is often discounted as a privacy tool due to "scaling issues" 
or "inefficient transactions", it actually boasts the most scalable privacy implementation among the leaders, and has 
been constantly iterating, dropping from nearly 13KB per transaction to ~1.4KB per transaction since it's inception.

There is still a long way to go, but it's exciting to see the constant progress pay off in a comparison of "reasonably 
private" spends like I've tried to do here.

I do realize that these comparisons are incredibly difficult to make, and would be grateful for any pointers on how I 
can better hone this approach to give a clear picture of privacy tool efficiency today.

Thanks for tuning in to my first blog post, and hopefully you'll keep a close eye on my future writings!

If you have any questions or want to follow me elsewhere, please check me out on Twitter 
[@sethisimmons](https://twitter.com/sethisimmons), and on Keybase (@sethsimmons).

## Transactions used for estimates
#### Bitcoin 
[TX0 pre-mix transaction](https://blockstream.info/tx/5787a5eb16bb7e5e16651f5f1bdc5afde146c6f7f5b3516e1ab77c5444128fa2?output:5)  
[Whirlpool mix transaction](https://blockstream.info/tx/4e72519d391ce83e0659c9022a00344bedbb253de1747cf290162b3d3ea51479)  
[STONEWALL post-mix transaction](https://blockstream.info/tx/ce2394b8d4d3b5be4712184b554c8b8ca6772e5baa1123482b9e50ef5bf2e8a2?input:0)  

#### Monero  
https://xmrchain.net/search?value=66679d2326cb2f7596cb6e2e25f586c819025b9daa902c901f80fa9b41c33e41 

#### Zcash  
https://blockchair.com/zcash/transaction/62cb32927d0fcfa6b8d5d36dfc72631191722f971b1141864fbcf73e06588d64 