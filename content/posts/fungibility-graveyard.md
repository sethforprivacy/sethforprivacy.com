+++
title = "Bitcoin's Fungibility Graveyard"
date = 2021-03-23T11:00:00-04:00
author = "Seth Simmons"
authorTwitter = "sethisimmons" #do not include @
cover = ""
tags = ["fungibility", "Bitcoin", "privacy"]
keywords = ["fungibility", "Bitcoin", "privacy"]
description = "Where the pipe-dream of Bitcoin's real-world fungibility goes to die."
summary = "Where the pipe-dream of Bitcoin's real-world fungibility goes to die."
showFullContent = false
toc = true
draft = false
+++

# Introduction

Bitcoin is often touted as a fungible and private asset and digital cash alternative, when in fact it is technically non-fungible. Each bitcoin in circulation has a distinct history attached to it ensuring that 1BTC != 1BTC. While coin histories can be somewhat ofuscated with tools like CoinJoin, the fungibility of Bitcoin remains distinctly lacking.

Many Bitcoiners purport that fungibility can be gained through more users mixing, or by peer-pressuring and boycotting exchanges and services that flag or trace Bitcoin transactions. In theory this is possible (suppose in another universe, everyone mixes), but why leave it up to chance?

The Monero community sees fungibility as a basic safety feature. Good tools should include safety features by default, strong enough to withstand both governmental and social attacks. This is far preferable to relying on the goodwill of governments and regulators, or the peer-pressure of us as users to ensure fungibility of digital cash. Do you really want your coins to be fungible only if your grandma correctly follows a 50 page mixing guide?

Monero relies on privacy by-default, for all users and all transactions, to ensure that 1XMR = 1XMR, no matter what. Monero is fungible today, not just in a pipe dream.

# The Fungibility Graveyard

This concern isn't only a fun thought exercise, unfortunately, as users of Bitcoin privacy tools are being harassed today.

Below is a list of sources confirming cases of flagging, denied withdrawals, denied deposits, and censorship by services because of a distinct lack of fungibility within Bitcoin. The list is broken down by the tool or reason for the flagging or censorship.

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

## Samourai

- A users's Bottlepay deposit is rejected/returned upon depositing mixed funds:
  - [Twitter Source](https://twitter.com/Marty_P_B/status/1366737347887456260)
- A user's Paxos account is frozen upon attempted withdrawal to Samourai Wallet for mixing:
  - [Twitter Source](https://twitter.com/RonaldMcHodled/status/1222172084610027523)

## JoinMarket

- A user's BitMEX account is flagged months after withdrawal to Samourai Wallet for mixing:
  - [Twitter Source](https://twitter.com/kristapsk/status/1374336620158140419)

## All CoinJoins

- Multiple user's deposits are flagged by BlockFi upon depositing from a CoinJoin tool like Wasabi:
  - [Twitter Source](https://twitter.com/matt_odell/status/1234514628115341313)
  - [Response from BlockFi](https://tweetstamp.org/1234531935038341120)
- A user's account is flagged upon mixing coins after withdrawal from Voyager:
  - [Twitter Source](https://twitter.com/sundaywar/status/1366854774864322560?s=20)
- Paxos official statement on handling of Bitcoin with a history of CoinJoin:
  - [Twitter Source](https://twitter.com/jehrenhofer/status/1235963248522006528)

## Tainted Bitcoin

- A user receives tainted Bitcoin that cause two exchange accounts to be locked upon deposits:
  - [Bisq Source](https://bisq.community/t/dirty-btc-coins-on-the-xmr-market/7798)
- A user is attacked by the media upon receiving a donation from a "far-right" donor:
  - [Twitter Source](https://twitter.com/sethisimmons/status/1370721319680155651)
- Multiple user's exchange accounts are closed after making a donation to a dark-net researcher:
  - [Twitter Source](https://twitter.com/DarkDotFail/status/1359243753664303104)

## General Fungibility Issues

- Freshly mined bitcoin fetches a 20% premium from large buyers, as this is the only bitcoin available without taint or history:
  - [News Source](https://news.bitcoin.com/industry-execs-freshly-minted-virgin-bitcoins/)
- A user's account is flagged after withdrawing from BlockFi to a peer-to-peer exchange:
  - [Reddit Source](https://www.reddit.com/r/Monero/comments/mcxwhp/a_mail_from_block_fi/)
- Multiple mining pools start actively censoring transactions deemed illicit:
  - [Twitter Source](https://twitter.com/fluffypony/status/1326594121797087238?s=20)

# Something Missing?

If you've noticed an instance of fungibility causing issues in the real world with Bitcoin, please feel free to reach out via [Twitter, Matrix, or email]({{< ref "/content/about.md#how-to-contact-me" >}}) and I'll work to get it added ASAP.

# Credits

- Several of the sources linked above were pulled from an excellent resource by [@6102bitcoin](https://twitter.com/6102bitcoin?s=21) on cases of CoinJoin flagging: https://6102bitcoin.com/coinjoin-flagging/.
- Many of the linked sources were provided by Monero community members on Reddit and Twitter on threads like the below:
  - https://www.reddit.com/r/Monero/comments/mbn12q/i_created_a_new_blog_post_will_be_a_new_site_soon/
  - https://twitter.com/sethisimmons/status/1374445921484689408?s=21
- Thanks to the many Monero community members who contributed sources privately or contributed wording and feedback on this page itself.