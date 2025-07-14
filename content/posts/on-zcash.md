---
title: "On Zcash"
date: 2025-07-12T15:00:00-04:00
tags: ["bitcoin", "privacy", "monero", "zcash"]
author: "Seth For Privacy"
description: "Zcash: jack of all trades, master of none"
---

As I've followed the rise and fall of Zcash's popularity in my time in the crypto and privacy spaces, it's been fascinating to see the shifting narratives, successes, and failures as it has fought to remain in the limelight in a rapidly changing space. A recent blog post by an OG cypher punk and someone I highly respect, [Frank Braun](https://frankbraun.org/), gave me a good chance to think more on where I see Zcash fitting in today, and more specifically, where I think it continues to fall short.

I will preface the rest of this post with something I have said often -- I am in no way tied to the dominance of Monero *specifically*, and merely want the world to have easily accessible, privacy-preserving digital cash at their fingertips. Today, that is Monero, but if somehow that changed and a different tool was best serving the needs of the average, privacy-loving individual and leading to broader human freedom and flourishing, I would gladly jump ship.

> I'm not a Bitcoin maximalist. I'm not a Monero maximalist. I'm a freedom maximalist.

Lastly, before you read this post I'd highly recommend you read [Frank's original blog post](https://frankbraun.org/t-addr/) in full to get a better idea of his holistic arguments, but I'll quote his post where relevant inline throughout.

## The user's perspective

One thing that is often overlooked by those of us who have been in the weeds of the crypto space for too long is what the average user actually desires from crypto. Three specific needs have become exceedingly clear as I've observed circular economies, darknet economies, and the vocal crypto space as a whole:

1. The ability to easily on-ramp to the crypto world

2. The ability to easily spend privately

3. The ability to make money work for you

Users generally seek to solve these three problems in the simplest, most user-friendly way possible. The reality of today is that users are solving these with Bitcoin (highly liquid and most broadly available), Monero (simplest way to achieve reasonable privacy), and Ethereum (broadest set of DeFi tooling, but can argue much of this has shifted to Solana, Tron, etc.), respectively.

> The change of perspective is that Zcash is an *integrated* system of two separate parts: The shielded pool and a transparent ledger.

A critical issue I have observed over the years is that Zcash aims to be all things to all people rather than staying laser-focused on what *theoretically* makes Zcash great - best-in-class privacy tech.

## Jack of all trades, master of none

Zcash has tried to solve #1 by persisting in the belief that t-addresses will allow Zcash to remain on more centralized, surveilled exchanges, have more integrations into hardware wallets, and broaden user access. I think we can all agree that has generally held true, as Zcash has remained far more accessible than Monero over the years.

Zcash has tried to solve for #2 by slowly and successfully iterating on the cutting-edge cryptographic tech they started with back in 2016, leading to a massive breakthrough in cryptocurrency privacy with the launch of the Orchard shielded pool. I think we can also all agree that (for now) when used properly (a massive caveat in Zcash's fractured ecosystem) Zcash's technical privacy is superior to anything else, even Monero (gasp!).

Zcash has tried to solve for #3 by building out plans for ZSAs (Zcash "shielded assets"), smart contract capabilities, and other more advanced functionality on Zcash. As of writing none of these are actually functional on Zcash, so I'll leave judgement on those efforts to a later date.

Now if you've read this far, you're probably wondering why I'm not yelling at you to go use Zcash today.

## A fractured focus

The major downside to this approach taken by the Zcash community is that the purpose and direction of Zcash is quite fractured. Is the goal to seek mass adoption and liquidity at all costs, a la Bitcoin? Is the goal to be the best form of digital cash, a la Monero? Or is the goal to compete with Ethereum, a la Solana?

> And just as Apple, by making both the hardware and the software, can make the better UX and better security features, Zcash can deliver better UX and better privacy by tightly integrating these two parts, **if executed correctly**.

As Braun so rightly points out, the crux of the issue comes down to execution, and this is where I think we can argue that Zcash has faltered.

In terms of on-ramping, users are generally not concerned with privacy and instead want what is most liquid and available, a space where Bitcoin has achieved perfect product-market fit. Arguably nothing can compete with the immense network effects of Bitcoin when it comes to getting users into the crypto space, and there is very little value to attempting to do so. Instead, projects like Monero have leaned on the symbiosis between Bitcoin and Monero via atomic swaps and decentralized exchanges, allowing users to easily swap to Monero from Bitcoin directly.

When it comes to being a powerful tool for payments, again network effects and simplicity have been the thorn in Zcash's side. Monero's simple focus on digital cash has allowed it to hone in on the simplest UX possible -- sync, receive, and send. No complex juggling of multiple address types, no dramatic change in privacy provided depending on what wallet is used. This simplicity has led to a powerful network effect for private spending, with Lightning and Monero leading the way in merchant adoption and usage by far.

Lastly, when it comes to competing on programmability it's become clear that users care far less about decentralization and privacy when it comes to making their money work for them. The growth in usage of chains like Solana and Tron, specifically for stablecoins has shown that capturing that market based on privacy alone would be practically impossible.

The biggest issue with this trifurcated focus is that it saps development and research resources away from what Zcash *should* be the best at -- digital cash. Imagine if all of Zcash's immense resources (far more than have been at the disposal of Monero) were funneled into building out a broad ecosystem of z-to-z-only tooling, including hardware wallet support, cross-platform wallets, etc. Imagine if those resources were spent focusing on improving the sync process for shielded wallets (the single greatest UX hurdle remaining for Zcash usage IMO).

In my opinion, Zcash has lost the privacy coin/digital cash arms race primarily because it tried to do everything, instead of trying to do one, simple thing.

## On privacy

When it comes to practically achievable privacy, Zcash again *should* be leading the pack. The holistic privacy provided by the shielded pool in Zcash is quite powerful, and doesn't suffer from the biggest flaw in Monero's armor - ring signatures (for now). This powerful privacy has been hampered, however, as the attempt to remain both transparent and shielded throughout the Zcash ecosystem means that many users are constantly shooting themselves in the foot moving in and out of the shielded pool in predictable ways that are vulnerable to timing and amount heuristics.

> I don't know about you, but when it comes to privacy in transactions, I just want the best possible and not think about potential weaknesses, how to use it best, and so on.

Yet again, Braun nails the issue on its head, but I'd argue comes away with an incorrect conclusion. Zcash's inability to narrow down the scope of user experience to "just use it and gain strong privacy", instead trying to intermingle private and transparent addresses with Unified Addresses, allowing exchanges and hardware wallets to take the shortcut of being t-address-only, and not enforcing privacy at the protocol level has led to an extremely fractured ecosystem of wallets and tooling.

Zashi, as Braun notes, is a very cool and wise new approach to a Zcash wallet, attempting to obfuscate and hide the transparent aspects of Zcash away from the user and force them through the shielded pool instead.

> Having a good wallet is very important, because privacy comes more from the wallet than from the network or from your counterparties.

Again Braun is spot on here, but only because of Zcash's fractured approach. You can use any wallet in Monero, be it Cake Wallet, Monerujo, Feather, or the "official" desktop wallet and gain the exact same privacy assurances *because Monero enforces these privacy assurances at the consensus level*. Again this drastically eases the mental burden for users and similarly expands the possibilities for wallet developers, as you can leave the privacy to the Monero protocol itself and focus on the tertiary aspects of building a wallet.

> It also integrates with the Keystone Hardware Wallet, which for the first time lets you *store* and *spend* Orchard-pool Zcash on a hardware wallet.

Again, it's astonishing to me that despite the immense amount of resources at the Zcash communities disposal they have been unable to get shielded Zcash support in any major hardware wallet, despite Monero having support in Ledger and Trezor for years. Monero also has support in Keystone, Cupcake, and is coming soon to Foundation's Passport Prime. The market demand for Monero is so immense that despite the more difficult integration of Monero over Zcash's t-addresses, it has received broad support. No privacy shortcuts possible + immense market demand = privacy at rest on many hardware wallets.

One note I will add, however, is that due to it's complexity Monero support has never felt first-class in hardware wallets, something that I hope will be rectified soon via Cupcake (for those with an old phone lying around) and Passport Prime.

> As you can see on the [ZecHub Dashboard](<https://zechub.wiki/dashboard>), the amount of ZEC in the shielded pools has more than doubled in the last year and almost 14% of the circulating ZEC supply is held in the Orchard shielded pool now, trend increasing.

Now this I just wanted to say I love to see, and would love to see \~100% of the circulating supply in the shielded pool sooner rather than later! Privacy number-go-up is the best kind, no matter where it's happening :D

## Market adoption

In the last section of his blog post, Braun expands on the broader adoption that Zcash's t-addresses (and thus simple transparency and integration) can theoretically bring. This is actually the most critical reason for t-addresses not being disabled years ago, and has been broadly argued for by Zooko and many others in the Zcash community. While this is a very valid explanation (and arguably the only reasonable one), the reality of expanded adoption has not panned out as planned.

> And for Zcash having t-addresses and transparent transactions, which are very similar to Bitcoin addresses and transactions, means it's much easier to plug Zcash into the wider ecosystem.

If we take the definition that peer-to-peer marketplaces count as decentralized exchanges (which I think most would agree on), Monero has absolutely dominated that space for years. If you take a look at Bisq's volume, you'll notice that [~85% of it is BTC <> XMR swaps](https://coinpaprika.com/exchanges/bisq/). Jump over to Haveno, a Monero-centric fork of Bisq, it has [surpassed Bisq's entire volume in less than a year](https://www.reddit.com/r/Monero/comments/1jy7mvz/were_currently_seeing_retoswap_overtaking_bisq_by/) and doesn't even support Zcash. If you [go to Robosats](https://learn.robosats.org/docs/access/) and try to swap for anything other than fiat, you'll notice there are only stablecoins and Monero available as those are by far the highest demand for moving in and out of Bitcoin.

While protocols like Thorchain have [opted to avoid listing Monero due to compliance pressure](https://x.com/THORChain/status/1562226389851729922), there has been no technical blocker to it's addition over the years, with much of the work being done and then summarily abandoned when the compliance sharks smelled blood in the water in the wake of Tornado Cash's sanctions and indictments. Unfortunately I couldn't find any liquidity or volume numbers for Zcash on the sole AMM-style DEX that lists it, Maya, but if I do track down numbers I'll be sure to update this post.

Lastly, a brilliant Monero community member, researcher, and developer is building his own AMM-style DEX called [Serai](https://serai.exchange/), centered on Bitcoin, Monero, and Ethereum that will solve this last gap in Monero's DEX ecosystem.

## Monero has optional transparency too...

I have no clue why this fact seems to be broadly overlooked in the crypto space, but for some reason people seem to forget that Monero also has the ability to optionally reveal a transaction to the world, or an entire wallet. The use of transaction keys allows users to reveal single transactions to the world (most often used for proving transactions on platforms like Bisq and Xmr Bazaar), while view keys allow users to reveal the activity of an entire wallet to the world.

> Furthermore, t-addresses can also increase *visibility* for the use-cases where it actually makes sense.

This optional transparency is critical to transparency for entities that require accountability (like the Monero General Fund) or for integration into DEXs that require proof of transfer like Thorchain or Serai. This functionality has existed from the beginning, and is often overlooked but is critical to giving users choice - with choice being the core of what makes privacy so powerful. Users are provided excellent privacy by default, and can always choose to opt-out of privacy for individual transactions or wallets as necessary.

## Conclusion

While I started this blog post with a simple goal, it rapidly expanded to include years of my thoughts on Zcash. Braun ends his post well with a set of three goals that all forms of digital cash should aim for:

> - privacy by default, independent of third parties
> 
> - deeper integration into the wider crypto ecosystem (for example, with DEXs)
> 
> - optional visibility and auditability

Fortunately, Monero has already accomplished all three of these and as a result has seen massive growth in adoption over the years across DEXs, circular economies, and darknet markets. My concern for Zcash at this point is: how exactly does Zcash see itself supplanting the market leader at this point in the adoption curve? What will cause users to switch from Monero to Zcash, and what tangible benefit to human freedom and flourishing will this actually accomplish?

As mentioned in the introduction to this post, my goal is not for Monero itself to win, but rather for the tool that leads to the most human freedom and flourishing to win. Today, that is Monero, but if tomorrow that was Bitcoin (with a massive improvement to privacy somehow) or Zcash (with a massive improvement in adoption somehow) I would gladly champion that tool.

Here's to freedom tech maximalism instead of tribalism.
