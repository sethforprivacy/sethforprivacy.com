---
author: Seth For Privacy
authorTwitter: sethforprivacy
date: "2021-03-23T11:00:00-04:00"
summary: Where the pipe-dream of Bitcoin's real-world fungibility goes to die.
draft: false
keywords:
- fungibility
- Bitcoin
- privacy
tags:
- fungibility
- Bitcoin
- privacy
title: Bitcoin's Fungibility Graveyard
toc: true
weight: 3
---

# Introduction

Bitcoin is often touted as a fungible and private asset and digital cash alternative, when in fact it is technically non-fungible. Each bitcoin in circulation has a distinct history attached to it ensuring that 1 BTC is not equal to 1 BTC. While coin histories can be somewhat obfuscated with tools like CoinJoin, the fungibility of Bitcoin remains distinctly lacking. This lack of fungibility imposes an immense burden on those using Bitcoin as a method of exchange (MoE), introduces a permissioned and centralized layer to the network, and destroys the confidence of everyone accepting funds in Bitcoin.

Many Bitcoiners purport that fungibility can be gained through more users mixing, or by peer-pressuring and boycotting exchanges and services that flag or trace Bitcoin transactions. In theory this is possible (suppose in another universe, everyone mixes), but why leave it up to chance?

The Monero community sees fungibility as a basic safety feature. Good tools should include safety features by default, strong enough to withstand both governmental and social attacks. This is far preferable to relying on the good will of governments and regulators, or the peer-pressure of us as users to ensure fungibility of digital cash. Do you really want your coins to be fungible only if everyone in Bitcoin correctly follows a 36h-long privacy guide?

Monero relies on privacy by default, for all users and all transactions, to ensure that 1 XMR is equal to 1 XMR, no matter what. Monero is fungible today, not just in a pipe dream.

# The Fungibility Graveyard

This concern isn't only a fun thought exercise, unfortunately, as users of Bitcoin privacy tools are being harassed today.

Below is a list of sources confirming cases of flagging, denied withdrawals, denied deposits, and censorship by services because of a distinct lack of fungibility within Bitcoin. The list is broken down by the tool or reason for the flagging or censorship.

***Current confirmed cases: 33***

## Wasabi

- A user's Binance SGD account is frozen upon attempted withdrawal to Wasabi Wallet for mixing:
  - [Twitter Source](https://twitter.com/bittlecat/status/1207621591820951552)
- A user's Paxful account is frozen upon attempted withdrawal to Wasabi Wallet for mixing:
  - [Reddit Source](https://old.reddit.com/r/WasabiWallet/comments/czext2/paxful_account_was_frozen_due_to_coinjoin/)
- A user's Bitfinex account is frozen upon attempted withdrawal to Wasabi Wallet for mixing:
  - [Reddit Source](https://old.reddit.com/r/WasabiWallet/comments/beqj8r/bitfinex_lock_account/)
- A user's Bitstamp account is flagged months/years after withdrawal to Wasabi Wallet for mixing:
  - [Twitter Source (deleted after this blog was published)](https://twitter.com/6102bitcoin/status/1367376460214853632)
  {{< collapse summary="Source Image" >}}
  {{< figure src="/fungibility-graveyard/bitstamp_wasabi.png" align="center" style="border-radius: 8px;" >}}
  {{< /collapse >}}
- A user's BitVavo account is closed upon attempted withdrawal to Wasabi Wallet for mixing:
  - [Reddit Source](https://www.reddit.com/r/Bitcoin/comments/i8ye6x/exchange_account_closed_because_of_risk_profile/)
- A user's Paxos account is frozen upon attempted withdrawal to Samourai Wallet for mixing:
  - [Twitter Source](https://twitter.com/RonaldMcHodled/status/1222172084610027523)
    {{< tweet user="RonaldMcHodled" id="1222172084610027523" >}}
- The Ethereum DAO hacker's use of Wasabi Wallet leads directly to his ID after simple tracing
  - [News Source](https://www.forbes.com/sites/laurashin/2022/02/22/exclusive-austrian-programmer-and-ex-crypto-ceo-likely-stole-11-billion-of-ether/?sh=6e7cc3bc7f58)
  - [Twitter Source](https://twitter.com/laurashin/status/1496087239037698048)
    {{< tweet user="laurashin" id="1496087239037698048" >}}
  - [Twitter Source demonstrating tracing](https://twitter.com/LaurentMT/status/1496252516702605318)
    {{< tweet user="LaurentMT" id="1496252516702605318" >}}
  - [YouTube source demonstrating tracing](https://www.youtube.com/watch?v=alcLdBsoDDg)
- Wasabi Wallet announces they will start censoring mixing inputs to prevent certain users from mixing their funds
  - [Twitter Source](https://twitter.com/wasabiwallet/status/1503091503207432193)
    {{< tweet user="wasabiwallet" id="1503091503207432193" >}}
  - [Telegram Source](https://t.me/WasabiWallet/63992)
- A user's Gemini account is frozen after previous transactions with Wasabi Wallet were discovered upon review of his account:
  - [Twitter Source](https://twitter.com/bjackson2718/status/1527040352770588673)
  {{< tweet user="bjackson2718" id="1527040352770588673" >}}

## Samourai

- A users's Bottlepay deposit is rejected/returned upon depositing mixed funds:
  - [Twitter Source (deleted after this blog was published)](https://twitter.com/Marty_P_B/status/1366737347887456260)
  {{< collapse summary="Source Image" >}}
  {{< figure src="/fungibility-graveyard/bottlepay_samourai.png" align="center" style="border-radius: 8px;" >}}
  {{< /collapse >}}

## JoinMarket

- A user's BitMEX account is flagged months after withdrawal to JoinMarket for mixing:
  - [Twitter Source](https://twitter.com/kristapsk/status/1374336620158140419)
    {{< tweet user="kristapsk" id="1374336620158140419" >}}

## All CoinJoins

- Multiple user's deposits are flagged by BlockFi upon depositing from a CoinJoin tool like Wasabi:
  - [Twitter Source](https://twitter.com/ODELL/status/1234514628115341313)
    {{< tweet user="ODELL" id="1234514628115341313" >}}
  - [Response from BlockFi](https://tweetstamp.org/1234531935038341120)
- A user's loan is closed while under water (causing a loss of 50%) due to the previous owner of the coins using a mixing service or tool:
  - [Twitter Source](https://twitter.com/Bitfinexed/status/1489833237765660673)
    {{< tweet user="Bitfinexed" id="1489833237765660673" >}}
  - [Reddit Source](https://www.reddit.com/r/blockfi/comments/skxiei/blockfi_horrible_loan_experience_fortune_lost/)
- A user's account is flagged upon mixing coins after withdrawal from Voyager:
  - [Twitter Source](https://twitter.com/sundaywar/status/1366854774864322560)
    {{< tweet user="sundaywar" id="1366854774864322560" >}}
- Paxos official statement on handling of Bitcoin with a history of CoinJoin:
  - [Twitter Source](https://twitter.com/jehrenhofer/status/1235963248522006528)
    {{< tweet user="jehrenhofer" id="1235963248522006528" >}}
- A user's account is frozen due to 6mo-old post-CoinJoin transactions by Bitwala:
  - [Twitter Source (tweet is now deleted)](https://twitter.com/riccardomasutti/status/1375507165151076353)
    {{< collapse summary="Source Image" >}}
    {{< figure src="/fungibility-graveyard/bitwala_coinjoin.png" align="center" style="border-radius: 8px;" >}}
    {{< /collapse >}}
- Swan's custodians terminate accounts of any user who directly interacts with a mixing service "such as Wasabi, Samourai, and similar services:"
  - [Twitter Source](https://x.com/WimTweets/status/1723178230474052041?s=20)
  - [Swan's response](https://x.com/skwp/status/1723444038932582414?s=20)

## Tainted Bitcoin

- A user receives tainted Bitcoin that cause two exchange accounts to be locked upon deposits:
  - [Bisq Source](https://bisq.community/t/dirty-btc-coins-on-the-xmr-market/7798)
- A user is attacked by the media upon receiving a donation from a "far-right" donor:
  - [Twitter Source](https://twitter.com/sethforprivacy/status/1370721319680155651)
    {{< tweet user="sethforprivacy" id="1370721319680155651" >}}
- Multiple user's exchange accounts are closed after making a donation to a dark-net researcher:
  - [Twitter Source](https://twitter.com/DarkDotFail/status/1359243753664303104)
    {{< tweet user="DarkDotFail" id="1359243753664303104" >}}
- A user's account is closed by LocalBitcoins after sending funds directly to a DNM:  
  - [Reddit Source](https://www.reddit.com/r/darknet/comments/mrjd99/local_bitcoin_website_terminated_my_account_after/)
- A user is worried about accepting donations from unknown sources because of a lack of fungibility:
  - [Reddit Source](https://www.reddit.com/r/CryptoCurrency/comments/c7bw1h/question_what_is_someone_sends_me_stolen_funds/)
- 28 cryptocurrency addresses (including Bitcoin) are sanctioned due to alleged use to fund Russian operations:  
  - [Government Source](https://archive.ph/IqnrX)
- Bitcoin donated to the "Freedom Convoy" in Canada is blacklisted and frozen at centralized exchanges
  - [News Source](https://www.coindesk.com/layer2/2022/02/22/frozen-bitcoin-tied-to-canadian-protests-lands-at-coinbase-cryptocom/)
  - [Twitter Source](https://twitter.com/CoinDesk/status/1496220843420131329)
    {{< tweet user="CoinDesk" id="1496220843420131329" >}}
  - [News Source on addresses sanctioned](https://www.coindesk.com/policy/2022/02/16/canada-sanctions-34-crypto-wallets-tied-to-trucker-freedom-convoy/)
  - [Twitter source on addresses sanctioned](https://twitter.com/CoinDesk/status/1494002689931620352)
    {{< tweet user="CoinDesk" id="1494002689931620352" >}}
- A user's Bitcoin is frozen by FixedFloat.com due to suspected illicit acquisition (hack/theft)
  - [Reddit Source](https://www.reddit.com/r/Monero/comments/t1gyoo/fixedfloat_scammed_me_for_6000_usd/)
  - [Reddit Source - Response by FixedFloat](https://www.reddit.com/r/Monero/comments/t1gyoo/fixedfloat_scammed_me_for_6000_usd/hygp7bc/?utm_source=reddit&utm_medium=web2x&context=3)
  - [Reddit Source - Further detailed response by FixedFloat on the traceability of Bisq](https://www.reddit.com/r/Monero/comments/t1gyoo/fixedfloat_scammed_me_for_6000_usd/hyo163k/?utm_source=reddit&utm_medium=web2x&context=3)
  {{< collapse summary="Source Image" >}}
  {{< figure src="/fungibility-graveyard/fixedfloat_tainted.jpeg" align="center" style="border-radius: 8px;" >}}
  {{< /collapse >}}
- A user's Coinbase account is frozen and then shut down due to tainted transactions from 2y prior
  - [Twitter Source (user's account was suspended after this was added to the post)](https://twitter.com/AwyeeDeaterBob/status/1439377414484807680)
  {{< collapse summary="Source Image" >}}
  {{< figure src="/fungibility-graveyard/coinbase_taint.png" align="center" style="border-radius: 8px;" >}}
  {{< figure src="/fungibility-graveyard/coinbase_taint1.png" align="center" style="border-radius: 8px;" >}}
  {{< /collapse >}}

## Compliant Mining and "Virgin" Bitcoin

- Marathon Digital Holdings Inc. launches a mining pool "that is fully compliant with U.S. regulations, including anti-money laundering (AML) and the Office of Foreign Asset Control’s (OFAC’s) standards":
  - "We believe that such regulatory compliant mining will allow us to produce ‘clean’ Bitcoin."
  - "On May 1, 2021, Marathon will begin directing 100% of its hashrate to the new mining pool."
  - "By 2022, Marathon expects to have deployed 103,120 miners to direct 10.37 exahashes per second, or EH/s, to the mining pool — equal to roughly 6.4% of the Bitcoin network’s current combined hash rate."
  - "[Will] be the seventh largest bitcoin mining pool in the world."
  - [News Source](https://finance.yahoo.com/news/marathon-digital-holdings-launch-first-200000064.html?guccounter=1)
  - [News Source](https://cointelegraph.com/news/the-blacklist-marathon-only-mining-fully-compliant-bitcoin-transactions)
  - [First compliant block mined](https://mempool.space/block/000000000000000000003f8cb66fe1ecfb38754abc9c4d4a62b71de45fef8777)
  - [List of compliant blocks mined by MARA Pool w/ block template comparisons](https://miningpool.observer/template-and-block?pool=MARA%20Pool)
  - [Twitter thread with details on the first 10 compliant blocks](https://twitter.com/sethforprivacy/status/1393206480195788805)
    {{< tweet user="sethforprivacy" id="1393206480195788805" >}}
- Blockseer launches compliant Bitcoin mining pool that only mines approved and filtered transactions:
  - "Blocks posted to the Bitcoin blockchain by Blockseer’s pool will only contain filtered transactions using Blockseer and Walletscore’s labeling data, along with verified sources such as the United States OFAC blacklist for crypto."
  - [News Source](http://www.globenewswire.com/news-release/2020/10/29/2117008/0/en/DMG-s-subsidiary-Blockseer-Launches-Bitcoin-Mining-Pool-Focused-on-Good-Governance-Auditability-and-OFAC-Compliance.html)
- Bitcoin mined in China or via fossil fuels are not acceptable to institutional investors:
  - "If you don’t want to own China coin—also being called ‘blood coin’, which sounds like blood diamonds—you’re going to prove where your coin is born."
  - [News Source](https://decrypt.co/62850/institutions-china-bitcoin-kevin-oleary)  
  - [News Source](https://www.coindesk.com/shark-tank-kevin-oleary-bitcoin-mining)
- Freshly mined bitcoin fetches a 20% (or "very large") premium from large buyers, as this is the only bitcoin available without taint or history:
  - [News Source](https://news.bitcoin.com/industry-execs-freshly-minted-virgin-bitcoins/)
  - [Confirmation Source](https://www.youtube.com/watch?v=WcXp17fjcT8&t=2223s)
- Only "virgin" Bitcoin mined by state-sanctioned miners can be used in Iran:  
  - [News Source](https://bitcoinmagazine.com/culture/iran-using-cryptocurrency-for-imports)
  - [Twitter Source](https://twitter.com/Fatalmeh/status/1390338789462224908)
- F2Pool filters 4 OFAC-sanctioned transactions from their mined blocks intentionally:
  - [Blog source](https://b10c.me/observations/08-missing-sanctioned-transactions/?t)
  - [Twitter Source, showing co-founder confirming their censorship](https://twitter.com/Diverter_NoKYC/status/1727218593119822210?s=20)

## General Fungibility Issues

- A user's account is flagged after withdrawing from BlockFi to a peer-to-peer exchange:
  - [Reddit Source](https://www.reddit.com/r/Monero/comments/mcxwhp/a_mail_from_block_fi/)
- Luke Dashjr, Bitcoin core developer, blocks gambling sites as "spam" in a Bitcoin implementation:
  - [News Source](https://www.coindesk.com/blacklist-debate-ok-meddle-bitcoins-code)
- Coinbase proactively traces and blacklists 25,000 addresses connected with Russian users in order to comply with sanctions against Russia
  - ***Note: The percentage/amount of these addresses that are Bitcoin is not public information.***
  - [News Source](https://www.breitbart.com/tech/2022/03/08/coinbase-blacklists-25000-russian-crypto-addresses/)
  - [Blog Source](https://blog.coinbase.com/using-crypto-tech-to-promote-sanctions-compliance-8a17b1dabd68)

# Additional Reading on Fungibility

- ["SLP363 Seth For Privacy – Bitcoin & Fungibility Discussion" - Stephan Livera Podcast](https://stephanlivera.com/episode/363/)
- ["Why Fungibility Is Important in Understanding Money and Crypto" - Mises Institute](https://mises.org/wire/why-fungibility-important-understanding-money-and-crypto)
- ["How could regulators successfully introduce Bitcoin censorship and other dystopias" - Juraj Bednar](https://juraj.bednar.io/en/blog-en/2020/11/12/how-could-regulators-successfully-introduce-bitcoin-censorship-and-other-dystopias/amp/)
- ["Bitcoin censorship will most likely come, pt 2" - Juraj Bednar](https://juraj.bednar.io/en/blog-en/2020/11/18/bitcoin-censorship-will-most-likely-come-pt-2/)
- ["Compliant Miners" - 6102bitcoin](https://6102bitcoin.com/blog/compliant-miners/)
- ["Bitcoin’s Attack Vectors: Fungibility"](https://medium.com/chainrift-research/bitcoins-attack-vectors-fungibility-ed58cb4cff73)
- ["What is fungibility and why does it matter?" - Monero SE](https://monero.stackexchange.com/questions/1967/what-is-fungibility-and-why-does-it-matter)
- ["Fungibility" - Moneropedia](https://web.getmonero.org/resources/moneropedia/fungibility.html)
- [Adam Back on the lack of fungibility in Bitcoin and its effects](https://www.youtube.com/watch?v=2eWMwj8AnA0)
- [Andreas Antonopoulos on the risks of a lack of fungibility and miner censorship as a result](https://youtu.be/J8y_GypCWf4?t=2530)
  - ***Segment starts at 42:10 and goes until 45:15***

# Something Missing?

If you've noticed an instance of fungibility causing issues in the real world with Bitcoin, please feel free to reach out via [Signal, SimpleX, X, or Nostr]({{< ref "/content/about.md#how-to-contact-me" >}}) or click [suggest a change to this post on Github](https://github.com/sethforprivacy/sethforprivacy.com/blob/master/content/posts/fungibility-graveyard.md).

# Credits

- Several of the sources linked above were pulled from an excellent resource by [@6102bitcoin](https://twitter.com/6102bitcoin?s=21) on cases of CoinJoin flagging: https://6102bitcoin.com/coinjoin-flagging/.
- Many of the linked sources were provided by Monero community members on Reddit and Twitter on threads like the below:
  - https://www.reddit.com/r/Monero/comments/mbn12q/i_created_a_new_blog_post_will_be_a_new_site_soon/
  - https://twitter.com/sethforprivacy/status/1374445921484689408?s=21
- Thanks to the many Monero community members who contributed sources privately or contributed wording and feedback on this page itself.

# Source Image Archive

Below are archived images of the original sources in case of the source itself being deleted or taken down.

Where the source has already been taken down, see the "Source Image" drop-down under the relevant item above.

{{< collapse summary="Source Images" >}}

{{< figure src="/fungibility-graveyard/paxful_wasabi.png" align="center" style="border-radius: 8px;" >}}

{{< figure src="/fungibility-graveyard/bitfinex_wasabi.png" align="center" style="border-radius: 8px;" >}}

{{< figure src="/fungibility-graveyard/bitvavo_wasabi.png" align="center" style="border-radius: 8px;" >}}

{{< figure src="/fungibility-graveyard/paxos_wasabi.png" align="center" style="border-radius: 8px;" >}}

{{< figure src="/fungibility-graveyard/wasabi_censorship.png" align="center" style="border-radius: 8px;" >}}

{{< figure src="/fungibility-graveyard/bitmex_joinmarket.png" align="center" style="border-radius: 8px;" >}}

{{< figure src="/fungibility-graveyard/blockfi_coinjoin.png" align="center" style="border-radius: 8px;" >}}

{{< figure src="/fungibility-graveyard/blockfi_coinjoin2.png" align="center" style="border-radius: 8px;" >}}

{{< figure src="/fungibility-graveyard/blockfi_coinjoin3.png" align="center" style="border-radius: 8px;" >}}

{{< figure src="/fungibility-graveyard/paxos_coinjoin.png" align="center" style="border-radius: 8px;" >}}

{{< figure src="/fungibility-graveyard/bitwala_coinjoin.png" align="center" style="border-radius: 8px;" >}}

{{< figure src="/fungibility-graveyard/bisq_tainted.png" align="center" style="border-radius: 8px;" >}}

{{< figure src="/fungibility-graveyard/lukesmith_tainted.png" align="center" style="border-radius: 8px;" >}}

{{< figure src="/fungibility-graveyard/darkdotfail_tainted.png" align="center" style="border-radius: 8px;" >}}

{{< figure src="/fungibility-graveyard/donations_tainted.png" align="center" style="border-radius: 8px;" >}}

{{< figure src="/fungibility-graveyard/compliant_mara.png" align="center" style="border-radius: 8px;" >}}

{{< figure src="/fungibility-graveyard/iran_mining.png" align="center" style="border-radius: 8px;" >}}

{{< figure src="/fungibility-graveyard/blockfi_p2p.png" align="center" style="border-radius: 8px;" >}}

{{< figure src="/fungibility-graveyard/voyager_coinjoin.png" align="center" style="border-radius: 8px;" >}}

{{< figure src="/fungibility-graveyard/localbitcoin_tainted.png" align="center" style="border-radius: 8px;" >}}

{{< figure src="/fungibility-graveyard/coinbase_taint.png" align="center" style="border-radius: 8px;" >}}

{{< figure src="/fungibility-graveyard/coinbase_taint1.png" align="center" style="border-radius: 8px;" >}}

{{< figure src="/fungibility-graveyard/f2pool.jpeg" align="center" style="border-radius: 8px;" >}}

{{< figure src="/fungibility-graveyard/swan.jpeg" align="center" style="border-radius: 8px;" >}}

{{< /collapse >}}
