---
title: "Taproot Didn't Cause JPEGs Or Inscriptions on Bitcoin"
date: 2023-12-18T07:15:45-05:00
tags: 
- Bitcoin
- Taproot
- NFTs
- Covenants
author: "Seth For Privacy"
description: "tl;dr - Focus on how we can make Bitcoin better via covenants."
---

*Note: This was originally [posted on X](https://twitter.com/sethforprivacy/status/1736715932704063997) and has been re-posted/reformatted for posterity here.*

I've seen the view that "Taproot caused/enabled arbitrary data storage on Bitcoin" commonly mentioned across Twitter, and it's one that can be extremely harmful. Many in the space would love to further ossify (prevent change) in Bitcoin and use jpegs/inscriptions "spam" as the reason for doing so, but I'd argue that that would be the worst possible outcome from this situation.

This needs a lengthy explanation to properly grasp what's at play here, though, so let's get into the fun details.

## Arbitrary data in Bitcoin has always been possible

Something most people don't understand is that a system like Bitcoin is built for data storage, it's just intended for monetary data. This design made it possible from day one to include arbitrary (arbitrary) data into the blockchain, either through methods like OP_RETURN (a good place for storing arbitrary data as it can be easily pruned) or in tweaked pubkeys (a bad place for storing arbitrary data, as it cannot be pruned).

Some examples of this:

- Satoshi inscribed a newspaper headline in the genesis block coinbase (https://mempool.space/tx/4a5e1e4baab89f3a32518a88c31bc87f618f76673e2cc77ab2127b7afdeda33b)
- Luke Dash Jr. used his pool to inscribe Bible texts and prayers in 2011 in the coinbase (https://bitcointalk.org/index.php?topic=38007.0)
- Someone added the entire Bitcoin whitepaper to the UTXO set in 2013 (https://bitcoin.stackexchange.com/questions/35959/how-is-the-whitepaper-decoded-from-the-blockchain-tx-with-1000x-m-of-n-multisi)

All of these happened before both SegWit and Taproot, and there are many more cases of this type of data storage on Bitcoin.

## But I thought Taproot enabled this?

Unfortunately, there is a common misunderstanding (thanks for the troll name [@TaprootWizards](https://twitter.com/TaprootWizards) 😅) that Taproot enabled this type of data storage, thus opening the way for jpeg/inscription "spam." In reality, this type of arbitrary data storage on Bitcoin has always been possible, but was made much cheaper to do with the introduction of SegWit in 2017.

SegWit was a major upgrade and bug fix for Bitcoin that enabled the Lightning network to be built and included a 3MB "witness" data allowance within each block w/ reduced fees for data to incentivize spending UTXOs (therefore making them prunable). More on SegWit in a fantastic post from [@River](https://twitter.com/River) here:

<https://river.com/learn/what-is-segwit/>

This incentivized portion of each transaction (called "witness" data) is intended for things like Bitcoin scripts, but can be used to store any data as long as it's done the "right" way. Specifically, jpegs in particular are stored in an "envelope" between two opcodes, allowing the data to count as witness data and get the discount. This storage method was possible before SegWit, but now saves on fees in comparison to pre-SegWit usage.

While this of course was not the intent of SegWit, it underlines the simple fact that if someone wants to store arbitrary data in a blockchain, they will find ways to do it.

If you want a deep dive into what exactly SegWit changed, why, and why they chose the discount they did, you can read more in a fantastic post from [@reardencode](https://twitter.com/reardencode) here:

<https://bitcoinmagazine.com/technical/the-witness-discount-why-some-bytes-are-cheaper-than-others>

## Does that make SegWit bad?

If your first reaction is then to want to raise a pitchfork and campaign for no more changes in Bitcoin, remember this -- without the SegWit soft-fork there would be no Lightning network, no discount for users consolidating UTXOs, and instead users would be incentivized to create more un-prunable UTXOs as it's cheaper to create than to consume UTXOs w/o SegWit.

Additionally, jpegs being stored in witness data allows those who run a node to easily prune them and not store them in RAM, unlike any method that leverages pubkey tweaking or other types of stenography to include arbitrary data on-chain. This means that the actual impact of jpegs on those who run a node is drastically minimized versus other arbitrary data storage methods.

## If we didn't have SegWit, NFTs would all use the UTXO set

It's extremely likely that if we had never included the SegWit soft-fork into Bitcoin that the jpeg craze would still have happened, and along with it a drastically worse outcome for the blockchain. In this alternate reality, Taproot Wizards (and all similar NFTs) would likely be inscribed directly into the UTXO set, similar to how Stamps function today.

Some within the Bitcoin community have been asking for a removal of the SegWit witness data discount to force jpeg enjoyers to pay the same fees as all other users per byte. Unfortunately, this would have two extremely detrimental side-effects: it would disincentivize healthy UTXO management (consolidating UTXOs vs creating new ones) and incentivize jpegs to be put in the UTXO set directly.

While putting the data into the UTXO set does cost those creating these NFTs drastically more, it also means that those running a Bitcoin node cannot prune the data, no matter what. Bitcoin relies on nodes being able to retain the entire UTXO set in order to verify transactions properly and prevent double-spends, and any data within that UTXO set must be kept in perpetuity.

That would be drastically worse for those running a Bitcoin node, and makes the jpegs in SegWit witness data pale in comparison when it comes to negative impact on Bitcoin nodes.

## So what can we do about it?

The solution to reducing the cost of using Bitcoin is not censoring jpegs (something that isn't even technologically possible, BTW), but rather finally building solutions to Bitcoin's long-term scaling. Jpegs/inscriptions have highlighted something most of us knew would happen -- base-layer fees would become untenably high, as they have to for Bitcoin to be secure long-term.

In order for the average person to use Bitcoin, we need powerful scaling solutions like layer twos, and unfortunately Lightning in it's current form isn't the final solution. Lightning relies on every channel-owner (and thus user when done in a non-custodial manner) being able to settle back on-chain to resolve disputes, something that isn't economically feasible in a realistic fee environment.

## The solution? Covenants

Enter covenants, an improvement to Bitcoin that has been a long-time in the making and is finally picking up the steam it deserves in the space. Covenants enable both improvements to Lightning that make it drastically more scalable, and new layer two networks to be built that have different (often better) trade-offs compared to Lightning.

As this post is already getting a bit too long I won't dive into the details of covenants, but instead ask you to spend a few minutes going through this fantastic set of resources on covenants to better understand what they enable:

<https://covenants.info>

Have questions? **ASK THEM!** The best way for the broader Bitcoin "rough consensus" layer to work is for more people to step up, learn, and ask questions as they go.

## Conclusion

If you have any questions from this post or would like more information on a specific aspect, please reach out via [Signal, SimpleX, X, or Nostr]({{< ref "/content/about.md#how-to-contact-me" >}}).
