---
title: "The Custody Trap"
date: 2025-08-26T12:00:00-04:00
tags: ["bitcoin", "privacy", "e-cash", "ecash", "custody"]
author: "Seth For Privacy"
summary: "How E-Cash Risks Bitcoiners' Sovereignty."
---

One of the most popular new technologies in the Bitcoin space has rapidly become e-cash, a system that allows anyone to easily spin up a new custodian that can issue and burn e-cash tokens backed by Bitcoin. This system works around many of the core issues with onboarding new users to Bitcoin or with using Bitcoin as a daily spending tool, but it does so at a great cost -- the loss of custody. While many view this tradeoff as reasonable for small amounts, I would argue that not only does the system as a whole have broken incentives, the time and resources spent building and improving e-cash necessarily detracts from more important efforts in the Bitcoin space.

## The basics

E-cash as a concept has existed for decades, but the advent of Bitcoin has made e-cash far more useful than ever before. The combination of Bitcoin and e-cash allows custodians to much more easily handle user funds, interact with other custodians, and further reduce the barrier of entry in ways that was never possible before. This combines with the near-perfect privacy assurances to user (when operating within a mint), something that has so far continued to elude the Bitcoin space as a whole. In addition, custodians can easily add programmability to their e-cash tokens in ways that is not currently possible on Bitcoin, expanding the use-cases even further than "just" privacy-preserving, custodial payments.

In addition, the combination of e-cash and Lightning drastically expands the usefulness of e-cash for payments, as Bitcoin's Lightning network allows an e-cash user on one mint to pay any Lightning user in the world, or any user on another e-cash mint. While e-cash isn't without its technical tradeoffs, it doesn't take a lot of imagination to understand why so many developers are drawn to building around e-cash when paired with Bitcoin and Lightning. But the core issues with e-cash are not technical, but rather incentive-based and philosophical.

## A case of broken incentives

E-cash finds itself between a rock and a hard place. For users to trust the mint, they need to know that the people behind the mint are trustworthy, as ultimately each mint acts as a custodian for its users precious sats. In a perfect world this wouldn't be an issue, but unfortunately we live in a world with vindictive nation-states that seek to continually tighten their control over our money and our activity. If the people running the mint reveal their identities (or even just nyms), they're a trivial target for regulators and law enforcement as it's clear that via current regulations in most jurisdictions, a mint is a money services business and thus subject to egregious banking laws.

Easy fix, just run all mints anonymously! Unfortunately that's also not the answer, as if the people behind a mint don't reveal their identities or nyms, users of that mint are subject to *trivial rug pulls with no recourse. *Custodians operate entirely on trust and reputation, two things that remain unsolved without some sort of identity attached to mint operators (even if purely pseudonymous). To bring it into the real world, if a mint had been targeted like Samourai Wallet was, instead of just a potential privacy loss, **all users would have lost all of their Bitcoin**. There is, however, an opportunity for a few small, jurisdictionally free mints to build up reputation over time simply by existing and not stealing customer's funds, but the larger they become the more risk of regulatory attacks and the larger the incentive to exit scam.

When we shift the lense to think about the "improving existing, trusted custodians" angle that is often pitched by e-cash proponents, a new set of broken incentives emerges. Not only does e-cash harm the UX their users are used to (not having to store a secret seed phrase), it also introduces additional infrastructure complexity. Instead of running a simpler system with accounts and balances handled via tradition infrastructure, now they have to run nascent mint software to provide their users with tokens, and handle support cases where users lose their seed phrase (and thus their tokens).

Lastly, the most difficult hurdle for many people to adopting Bitcoin is the simple first step -- writing down 12 words and making sure not to lose them. With e-cash you still have this single greatest barrier of entry as you must backup a seed phrase or secret in order to restore your e-cash tokens.

In theory a custodian could just also store the seed phrase for their users, but then have we actually improved on custodians at all? They even have custody of the e-cash tokens in that case, reducing the privacy guarantees by a reasonable margin. While I think it's a valid argument to say that users would be better off if their preferred custodian used e-cash instead of a transparent database, I don't see a clear path towards forcing those custodians to adopt a more technologically complex solution.

That being said, the onboarding process does get drastically cheaper and faster, as there is no longer a need to onboard a user on-chain -- simply send them e-cash tokens that they can (hopefully) redeem for Bitcoin via Lightning or on-chain at their convenience down the line.

## The custody trap

One of the foremost properties that makes Bitcoin unique is that we can *actually take custody of it ourselves*, gaining immense freedom and self-sovereignty through a bit of personal responsibility. Even though I am a massive proponent of building better privacy tools, **sacrificing custody to get better privacy is a non-starter for me. **In addition, the privacy provided by e-cash is severely hampered in the real-world through the transparency of Bitcoin on-chain, as all users deposits and withdrawals from mints are easily surveiled and linked together via timing and amount-based heuristics unless a single mint achieves massive scale. But the larger the mint, the larger the incentive of theft for the mint operators, hackers, and the more regulatory attention it draws.

This is somewhat offset by the native privacy that Lightning can provide, however, as users can lean away from on-chain deposits and withdrawals and instead rely on Lightning for all movement into and out of e-cash mints. This, as you can already guess, does come with drawbacks though, as either the mint operator needs to start the mint with a large amount of Bitcoin for Lightning channels that it's new users can leverage, or they have to rely on a third-party being willing to act as a Lightning Service Provider for their mint. The mint + LSP model is most likely the best approach here, and it will be interesting to see how the space evolves.

But surely we can do better and build privacy tools on top of Bitcoin (or directly into Bitcoin's consensus layer) that allow us to have both privacy *and* self-sovereignty via self-custody. The growth in Silent Payments adoption is a critical step towards improved receiver privacy, Payjoin v2 is rapidly gaining adoption among wallets to improve sender and receiver privacy, and access to the Lightning network without establishing an on-chain footprint is getting close by the day via Ark (more on that later).

I will not give up custody of my Bitcoin, no matter what, and you shouldn't either. "Better custodians" are just custodians with extra steps, and still strip us of self-sovereignty and thus freedom.

## Is it all doom and gloom?

While your takeaway from this may be that I don't see any value in e-cash, I'll actually push against that! The clear value that e-cash *does* provide is that of improving community custody. This is the model that Fedi have leaned into with their specific implementation of e-cash mints, where all mints distribute trust through a multisig model. The ability for a trusted family member to run a mint for his children and extended family, or for a group of village elders to run a Fedimint for their community to use in trading and payments is actually an immensely useful one in the Global South, specifically.

There is clear demand for ways to escape the broken fiat of the vast majority of countries around the world, and e-cash makes that process easier and cheaper than practically any other solution, as well has having the incentives align in the best way possible. Most of these countries have little to no ability to enforce banking regulations (if they even have those regulations), and many communities globally already rely on a trusted group of individuals for financial custody or leadership. This model is actually extremely interesting to me, and is one I hope to see explored more in-depth in the future.

## The only thing scarcer than Bitcoin is time

Even though I have been very outspoken on what I view as a pointless venture, I am not here to stop anyone from building what they enjoy in the space. Developers working on e-cash are free to do so as of course I have no control over them, though I fear that time spent on improving custodians is time that we will not get back. It's clear that the US government and many in the EU are seeking to ramp up their attacks on Bitcoin privacy and self-custody, and our time to build tools to route around them is growing shorter and shorter. The more of that time we focus on tools that face immense regulatory scrutiny with a pretty trivial path to enforcement, the less we are able to harden Bitcoin during times of relative calm to the coming onslaught against usage of Bitcoin as freedom money. The Biden-Harris administration in the US gave us a taste of what that coming environment looks like, and I have no doubt that will just be the beginning.

## A path forward: Ark

While this post will not go into great detail on the concept of Ark, I do want to call it out as an excellent alternative that solves for many of the same issues as e-cash **without sacrificing self-custody.** Ark is a new approach to scaling Bitcoin that also allows nearly-free, rapid transactions without any on-chain footprint, integrates directly with the Lightning network for payments and interoperability, and drastically simplifies the onboarding process for new users. Ark allows for trust-minimized off-chain payments with entirely trustless on-chain exits, and incredibly powerful combination.

While Ark lacks e-cash’s near-perfect intra-mint privacy, its reliance on Bitcoin’s base layer eliminates single points of failure – a tradeoff favoring censorship resistance over perfect anonymity. Combining this off-chain state with Lightning payments allows for what I would term "good enough" privacy for the vast majority of users, with far less complexity than a self-hosted Lightning node setup today.

All that being said, Ark is still a *very* new technology that is being built out by two main teams in the space, with many user experience hurdles and complexities to iron out before it becomes a mainstream product. I'm extremely thankful for the work of Ark Labs and Second for pioneering this path forward as I write this, and can't wait to see what both of them launch in 2025.

Let's not settle for better custodians, but instead keep our eye on the prize: digital, peer-to-peer cash.
