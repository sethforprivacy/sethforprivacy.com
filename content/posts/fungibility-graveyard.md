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
---

# Introduction

Bitcoin is often touted as a fungible and private asset and digital cash alternative, when in fact it is technically non-fungible. Each bitcoin in circulation has a distinct history attached to it ensuring that 1BTC != 1BTC. While coin histories can be somewhat ofuscated with tools like CoinJoin, the fungibility of Bitcoin remains distinctly lacking.

Many Bitcoiners purport that fungibility can be gained through more users mixing, or by peer-pressuring and boycotting exchanges and services that flag or trace Bitcoin transactions. In theory this is possible (suppose in another universe, everyone mixes), but why leave it up to chance?

The Monero community sees fungibility as a basic safety feature. Good tools should include safety features by default, strong enough to withstand both governmental and social attacks. This is far preferable to relying on the goodwill of governments and regulators, or the peer-pressure of us as users to ensure fungibility of digital cash. Do you really want your coins to be fungible only if your grandma correctly follows a 50 page mixing guide?

Monero relies on privacy by-default, for all users and all transactions, to ensure that 1XMR = 1XMR, no matter what. Monero is fungible today, not just in a pipe dream.

# The Fungibility Graveyard

This concern isn't only a fun thought exercise, unfortunately, as users of Bitcoin privacy tools are being harassed today.

Below is a list of sources confirming cases of flagging, denied withdrawals, denied deposits, and censorship by services because of a distinct lack of fungibility within Bitcoin. The list is broken down by the tool or reason for the flagging or censorship.

***Current confirmed cases: 25***

## Wasabi

- A user's Binance SGD account is frozen upon attempted withdrawal to Wasabi Wallet for mixing:
  - [Twitter Source](https://twitter.com/bittlecat/status/1207621591820951552)
- A user's Paxful account is frozen upon attempted withdrawal to Wasabi Wallet for mixing:
  - [Reddit Source](https://old.reddit.com/r/WasabiWallet/comments/czext2/paxful_account_was_frozen_due_to_coinjoin/)
- A user's Bitfinex account is frozen upon attempted withdrawal to Wasabi Wallet for mixing:
  - [Reddit Source](https://old.reddit.com/r/WasabiWallet/comments/beqj8r/bitfinex_lock_account/)
- A user's Bitstamp account is flagged months/years after withdrawal to Wasabi Wallet for mixing:
  - [Twitter Source](https://twitter.com/6102bitcoin/status/1367376460214853632)
- A user's BitVavo account is closed upon attempted withdrawal to Wasabi Wallet for mixing:
  - [Reddit Source](https://www.reddit.com/r/Bitcoin/comments/i8ye6x/exchange_account_closed_because_of_risk_profile/)
- A user's Paxos account is frozen upon attempted withdrawal to Samourai Wallet for mixing:
  - [Twitter Source](https://twitter.com/RonaldMcHodled/status/1222172084610027523)

## Samourai

- A users's Bottlepay deposit is rejected/returned upon depositing mixed funds:
  - [Twitter Source](https://twitter.com/Marty_P_B/status/1366737347887456260)

## JoinMarket

- A user's BitMEX account is flagged months after withdrawal to JoinMarket for mixing:
  - [Twitter Source](https://twitter.com/kristapsk/status/1374336620158140419)

## All CoinJoins

- Multiple user's deposits are flagged by BlockFi upon depositing from a CoinJoin tool like Wasabi:
  - [Twitter Source](https://twitter.com/matt_odell/status/1234514628115341313)
  - [Response from BlockFi](https://tweetstamp.org/1234531935038341120)
- A user's account is flagged upon mixing coins after withdrawal from Voyager:
  - [Twitter Source](https://twitter.com/sundaywar/status/1366854774864322560?s=20)
- Paxos official statement on handling of Bitcoin with a history of CoinJoin:
  - [Twitter Source](https://twitter.com/jehrenhofer/status/1235963248522006528)
- A user's account is frozen due to 6mo-old post-CoinJoin transactions by Bitwala:
  - [Twitter Source](https://twitter.com/riccardomasutti/status/1375507165151076353?s=21)

## Tainted Bitcoin

- A user receives tainted Bitcoin that cause two exchange accounts to be locked upon deposits:
  - [Bisq Source](https://bisq.community/t/dirty-btc-coins-on-the-xmr-market/7798)
- A user is attacked by the media upon receiving a donation from a "far-right" donor:
  - [Twitter Source](https://twitter.com/sethforprivacy/status/1370721319680155651)
- Multiple user's exchange accounts are closed after making a donation to a dark-net researcher:
  - [Twitter Source](https://twitter.com/DarkDotFail/status/1359243753664303104)
- A user's account is closed by LocalBitcoins after sending funds directly to a DNM:  
  - [Reddit Source](https://www.reddit.com/r/darknet/comments/mrjd99/local_bitcoin_website_terminated_my_account_after/)
- A user is worried about accepting donations from unknown sources because of a lack of fungibility:
  - [Reddit Source](https://www.reddit.com/r/CryptoCurrency/comments/c7bw1h/question_what_is_someone_sends_me_stolen_funds/)
- 28 cryptocurrency addresses (including Bitcoin) are sanctioned due to alleged use to fund Russian operations:  
  - [Government Source](https://archive.ph/IqnrX)

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
  - [Twitter thread with details on the first 10 compliant blocks](https://twitter.com/sethforprivacy/status/1393206480195788805?s=21)
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
  - [Twitter Source](https://twitter.com/Fatalmeh/status/1390338789462224908?s=19)

## General Fungibility Issues

- A user's account is flagged after withdrawing from BlockFi to a peer-to-peer exchange:
  - [Reddit Source](https://www.reddit.com/r/Monero/comments/mcxwhp/a_mail_from_block_fi/)
- Luke Dashjr, Bitcoin core developer, blocks gambling sites as "spam" in a Bitcoin implementation:
  - [News Source](https://www.coindesk.com/blacklist-debate-ok-meddle-bitcoins-code)

# Additional Reading on Fungibility

- ["How could regulators successfully introduce Bitcoin censorship and other dystopias"](https://juraj.bednar.io/en/blog-en/2020/11/12/how-could-regulators-successfully-introduce-bitcoin-censorship-and-other-dystopias/amp/)
- ["Bitcoin censorship will most likely come, pt 2"](https://juraj.bednar.io/en/blog-en/2020/11/18/bitcoin-censorship-will-most-likely-come-pt-2/)
- ["Compliant Miners"](https://6102bitcoin.com/blog/compliant-miners/)
- [Bitcoin’s Attack Vectors: Fungibility](https://medium.com/chainrift-research/bitcoins-attack-vectors-fungibility-ed58cb4cff73)
- [What is fungibility and why does it matter?](https://monero.stackexchange.com/questions/1967/what-is-fungibility-and-why-does-it-matter)
- [Fungibility - Moneropedia](https://web.getmonero.org/resources/moneropedia/fungibility.html)

# Something Missing?

If you've noticed an instance of fungibility causing issues in the real world with Bitcoin, please feel free to reach out via [Twitter, Matrix, or email]({{< ref "/content/about.md#how-to-contact-me" >}}) or open a pull request with the addition against <https://github.com/sethforprivacy/sethforprivacy.com-content>.

# Credits

- Several of the sources linked above were pulled from an excellent resource by [@6102bitcoin](https://twitter.com/6102bitcoin?s=21) on cases of CoinJoin flagging: https://6102bitcoin.com/coinjoin-flagging/.
- Many of the linked sources were provided by Monero community members on Reddit and Twitter on threads like the below:
  - https://www.reddit.com/r/Monero/comments/mbn12q/i_created_a_new_blog_post_will_be_a_new_site_soon/
  - https://twitter.com/sethforprivacy/status/1374445921484689408?s=21
- Thanks to the many Monero community members who contributed sources privately or contributed wording and feedback on this page itself.
