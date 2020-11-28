+++
title = "Comparing Private Spends"
date = "2020-11-28T16:37:10Z"
author = "Seth Simmons"
authorTwitter = "sethisimmons" #do not include @
cover = ""
tags = ["", ""]
keywords = ["", ""]
description = ""
showFullContent = false
draft = true
+++

# Comparing "Reasonably Private" Spends in Bitcoin, Monero, and Zcash

## Introduction
As my first blog post, and a christening to this new venture, I wanted to go ahead and share some thoughts I've had about efficiency within transaction types when comparing privacy protocols and usage.

I have recently discussed this in some depth [on Twitter](https://twitter.com/sethisimmons/status/1285336820264382468?s=20) 
where I was surprised by the results, finding that Monero manages to be quite a bit more efficient on size compared to 
Bitcoin, when trying to use both in a private manner. I'll use this blog post to break it down in a bit more detail,
and add a new contender to the mix -- Zcash.

But first, an introduction to each approach to privacy.

## Bitcoin

Bitcoin is the king of cryptocurrencies, and made major breakthroughs that enabled the existence of cryptocurrencies 
like Monero and Zcash. While many thought it's approach to privacy sufficient in the early days, people quickly realized
that the pseudonymity it offered was insufficient for many use cases, and allowed users to very easily ruin their own
privacy via things like combining outputs, re-using addresses, and simple output amount analysis.

## Monero

## Zcash

## Size and Cost

Normal "reasonably private spend" TX size in Bitcoin: 2,363b, 1,475vb  
Normal "reasonably private spend" TX size in Monero: 1,419b  
Normal "reasonably private spend" TX size in Zcash: 2,373b  
Normal "reasonably private spend" TX cost in Bitcoin (excluding "doxxic" change and mixing fees): $8.75 @ 50sat/vb  
Normal "reasonably private spend" TX cost in Monero: $0.0022 (median as of 10/20)  
Normal "reasonably private spend" TX cost in Zcash: $0.0072 (median as of 10/20)  

## Throughput **CHANGEME**

Bitcoin block time: 10m  
Bitcoin block size limit: median of 2mb, hard cap of 4mb  
Bitcoin max RPS transactions per 10m: ~2,750 transactions  
Monero block time: 2m  
Monero block size limit: median of 300kb, hard cap of 600kb  
Monero max RPS transactions per 10m: ~2,150 transactions  
Monero max RPS transactions per 10m (weighted to Bitcoin): ~2,900 transactions  
Zcash block time: 1.25m  
Zcash block size: 2mb  
Zcash max RPS transactions per 10m: ~6,900 transactions  
Zcash max RPS transactions per 10m (weighted to Bitcoin): ~1,725 transactions  

## Notes
####Transaction used for Bitcoin estimate:  
https://blockstream.info/tx/5787a5eb16bb7e5e16651f5f1bdc5afde146c6f7f5b3516e1ab77c5444128fa2?output:5 
https://blockstream.info/tx/4e72519d391ce83e0659c9022a00344bedbb253de1747cf290162b3d3ea51479 
https://blockstream.info/tx/ce2394b8d4d3b5be4712184b554c8b8ca6772e5baa1123482b9e50ef5bf2e8a2?input:0 

####Transaction used for Monero estimate:  
https://xmrchain.net/search?value=66679d2326cb2f7596cb6e2e25f586c819025b9daa902c901f80fa9b41c33e41 

####Transaction used for Zcash estimate:  
https://blockchair.com/zcash/transaction/62cb32927d0fcfa6b8d5d36dfc72631191722f971b1141864fbcf73e06588d64 