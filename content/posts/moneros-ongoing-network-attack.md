+++
title = "A Brief Breakdown of Monero's Ongoing Network Attacks"
date = "2020-12-08T15:35:00-05:00"
author = "Seth Simmons"
authorTwitter = "sethisimmons" #do not include @
cover = ""
tags = ["Monero", "Network", "p2p"]
keywords = ["Monero", "Eclipse", "Sybil", "p2p", "network"]
description = "In this blog post I'll break down a rough timeline of events, a short list of the known attacks that have happened or are still occurring, and what users can do to mitigate these attacks and others like them in the future."
summary = "In this blog post I'll break down a rough timeline of events, a short list of the known attacks that have happened or are still occurring, and what users can do to mitigate these attacks and others like them in the future."
showFullContent = false
draft = false
+++

# Introduction

As many of you may know, Monero's peer-to-peer (p2p) network has been undergoing several different types of attack by an 
entity who has consistently attacked, spammed, and attempted to undermine the Monero network and community for years.

Their latest attack is an attempt to undermine the reputation of the Monero network via long-lasting [Sybil and Eclipse](https://bitcoin.stackexchange.com/questions/61151/eclipse-attack-vs-sybil-attack) 
attacks, which have been ongoing since before the network upgrade on October 17th, 2020. While the motives are known 
to be malicious and the attacker has proven he does not want to improve the Monero network via code or responsible 
disclosure, this is a great chance for the Monero community and developers to work together to harden the p2p network under 
these attacks.

In the below blog post I'll break down a *rough* timeline of events, a short list of the known attacks that have happened
or are still occurring, and what users can do to mitigate these attacks and others like them in the future.

It's important to note before jumping in that while these attacks specifically target the Monero network, they share a 
common attack surface with most other cryptocurrency networks and so are valuable for any community to be aware of and 
attempt to mitigate or resolve to harden the network before these attacks happen.

The two best sources for info on this attack that have already been shared are [this Reddit post by u/dEBRUYNE_1](https://www.reddit.com/r/Monero/comments/jrh7mv/psa_informational_thread_on_the_recently_observed/) this Twitter thread by @fluffypony:
 
{{< twitter 1326130648491417602 >}}

# Timeline

The attack's origin date is unknown exactly, but prior to the implementation of Dandelion++ it seems to have been 
mostly harmless and being built out. We will focus here on the attack starting from the upgrade on October 17th, 2020:

- 10/17/2020 - Monero upgrades to v0.17 via hard-fork including Dandelion++ and CLSAG
- 10/18/2020 - Rapid increase in users unable to send transactions successfully due to malicious nodes dropping transactions
- 10/18/2020 - [PR6916](https://github.com/monero-project/monero/pull/6916) implemented to increase out_peers, lessening impact of 
malicious nodes
- 10/20/2020 - Some reports of an inability to sync successfully due to all peers showing incorrect chain-tip
- 10/27/2020 - [PR6939](https://github.com/monero-project/monero/pull/6939) implemented to reduce effectiveness of 
running multiple nodes behind one IP address
- 11/2/2020  - [PR6961](https://github.com/monero-project/monero/pull/6961) implemented to allow passing a banlist to 
monerod (like [selsta's block.txt](https://gui.xmr.pm/files/block.txt))
- 11/3/2020  - [PR6973](https://github.com/monero-project/monero/pull/6973) implemented to mitigate transaction DoS 
caused by malicious nodes dropping transactions
- 11/5/2020  - Attacker announces the attack publicly
- 11/5/2020  - [PR6983](https://github.com/monero-project/monero/pull/6983) implemented to prevent hiding of IPv4 nodes 
in IPv6 addresses
- 11/10/2020 - User's notice that wallet will not sync as malicious nodes are reporting a block height of +2 to the 
actual height
- 11/12/2020 - [PR7018](https://github.com/monero-project/monero/pull/7018) implemented to further improve Dandelion++ 
resistance to malicious nodes reporting incorrect height by avoiding selecting attacker nodes during Dandelion++ stem phase
- 11/18/2020 - [PR7025](https://github.com/monero-project/monero/pull/7025) implemented to further improve Dandelion++ 
handling of malicious peers in regards to transaction sending times
- 12/2/2020  - [PR7055](https://github.com/monero-project/monero/pull/7055) proposed to further mitigate misbehaving peers
- 12/4/2020  - [PR7072](https://github.com/monero-project/monero/pull/7072) proposed to prevent malicious nodes spamming 
large peer lists

# The Attack

The core of the attack is a cluster of malicious nodes running customized clients, hosted across ~130 IP addresses on OVH and Digital Ocean. 
These nodes increase their share of the p2p network by spamming outgoing connections to valid nodes, spamming of large peer lists containing only the malicious 
nodes, and utilizing a flaw in the node peering system that gives multiple nodes running behind one IP address a higher 
chance of being used as outgoing connections by valid nodes.

This overwhelming of a valid node's peer list allows the attacker to feed false block heights, intercept transactions, 
and if a node has only malicious peers, allows the attacker to prevent them from syncing or sending transactions at all.

Let's break down each (known) attack below.

## Disproportionately Gaining Network Share

This portion of the attack helped the attacker become a larger than normally allowed portion of the peer lists of valid 
nodes, and made the other attacks more effective by increasing their share of the network disproportionately.

*Mitigated by [PR6939](https://github.com/monero-project/monero/pull/6939).*

## Injecting Peer Lists of Malicious Nodes

This is another method used by the attacker to inject their malicious nodes into valid node peer lists and consists of 
only sending malicious nodes via their own peer lists when requested by valid nodes while spamming very large peer lists.

This attack, when combined with the use of excessively large peer lists above was the key to increasing the effectiveness of the attacks we'll break down below, as it drastically increased the attack surface available without increasing cost or node count to the attacker.

*Mitigated by [PR7072](https://github.com/monero-project/monero/pull/7072).*

## Block Height Mirroring

This was one of the first attacks, and it is very simple. The attacker edited the Monero code to query valid nodes for 
their existing block height, and then when the malicious node was asked for the latest block it reported that the 
chain-tip was the same height that the valid node was currently at.
 
This attack prevents eclipsed nodes from syncing while potentially slowing down initial block download by 
valid nodes containing any malicious node in their peer list but not fully eclipsed by limiting the number of peers providing valid blocks.

*This attack was partially mitigated by increasing outgoing peer count defaults, but is not harmful and requires no further mitigation.*

## Spying on Transactions

The particular attack made public by the attacker is an attempt to link the IP address of a node with particular transactions. This 
is done by spamming peer lists as we discussed above, and then attributing transactions to the node that first shares 
the transaction via p2p with the spying nodes.

This attack is the most dangerous in most networks as it could allow linking of transactions with user's 
node IP addresses if not using Tor/i2p. Thankfully, Monero has implemented [Dandelion++](https://www.monerooutreach.org/stories/dandelion.html) which makes it very 
difficult for nodes on the network to deterministically link IP addresses with transactions, as transactions are slowly 
published (via the stem phase) to a randomized set of nodes, and then "fluffed" to the rest of the network after a set 
number of hops (or a timeout).

The use of Dandelion++ drastically increases the portion of the network needing to be controlled by the attacker to accurately link node IP addresses with transactions, and makes the linkage probabilistic instead of deterministic.

*Mitigated by Dandelion++ and/or Tor/i2p usage.*

## Wallet DoS via Block Height +2

This attack is a simple DoS that relies on expected behavior of the Monero wallet. This behavior prevents the wallet from 
searching blocks for transactions until the node is fully synced.

Because of this behavior, any node with malicious peers run by the attacker will be told that the chain-tip is 2 blocks 
away from their valid block height, preventing their wallet from ever beginning to sync. Note that this is not an issue 
for the Monero CLI wallet, and only for the GUI and mobile wallets.

*Mitigated by [PR7055](https://github.com/monero-project/monero/pull/7055) and [PR6961](https://github.com/monero-project/monero/pull/6961).*

## Transaction DoS via Dropping Stem-Phase Transactions

This particular attack has caused a lot of headache for users as anyone using the "Simple Mode" in the GUI was 
particularly susceptible to this. If the first node the transaction was sent through was malicious, "Simple Mode" 
was unable to relay the transaction properly to the rest of the network after the set Dandelion++ timeout, causing the transaction to fail completely.

*Mitigated by a combination of Dandelion++ PRs.*

# Mitigations You Can Implement

Most of these mitigations will be familiar to the more privacy conscious or technical users, but are a common way to 
help protect yourself against malicious nodes in general across p2p networks:

- [Run your own node and keep it up to date](https://www.monerooutreach.org/monero_best_practices/your_own_node.html)
    - If you're running your own node, please make sure to update to the latest version containing all of the mentioned
    mitigations, [v0.17.1.6 or greater](https://www.getmonero.org/downloads/)
- [Utilize anonymity networks like Tor or i2p for relaying transactions](https://github.com/monero-project/monero/blob/master/docs/ANONYMITY_NETWORKS.md)
- Make use of the --ban-list flag, (a list of offending IPs managed by selsta can be found [here](https://gui.xmr.pm/files/block.txt)), 
to prohibit the attacker from connecting to your node
    - This is a temporary measure that should no longer be necessary after v0.17.1.6

# Moving Forward

As mentioned at the start of this article, these types of attacks are possible against most p2p networks and are 
difficult to prevent without introducing a permissioning system to the network, something that is inherently against the 
principle of p2p networks like Monero. The Monero community and developers will continue to iterate and improve the 
network in the meantime to reduce the attack vectors available to attackers.

Thankfully in Monero there is far less data for attackers to capture compared to most other cryptocurrency networks as 
transactions hide the sender, receiver, and amount transacted by-default. This lessens the impact of spying attacks on 
the network, but users with advanced threat models should still perform the mitigations mentioned above.

The last important note here is that none of these attacks affected the Monero protocol itself -- all on-chain privacy 
measures are intact and unaffected. These attacks merely target the p2p network layer, something that is shared by all 
decentralized cryptocurrencies.

If you have any questions from this post or would like more information on a specific aspect of the attack, please reach out via [Twitter, Keybase, or email]({{< ref "/content/about.md" >}}).

Thanks!

# Credits

Thanks to selsta for helping me piece together the PR timeline and walk me through some of the attack details, and 
thanks to all the Monero developers who have worked long hours hardening the Monero p2p network against these types of attacks.