---
title: "Dispelling CTV FUD"
date: 2023-12-19T07:05:30-05:00
tags: 
- Bitcoin
- Covenants
- CTV
- FUD
author: "Seth For Privacy"
description: "I've taken the time to collect, rebut, and give resources for each of the most common FUD points against covenants using CTV."
---

It happens with every proposal made for improving Bitcoin. First, the technical developers and researchers weigh in with strong and legitimate concerns, they hash out the details, and the proposal slowly improves over time. But at some point some of these concerns make their way onto social media and quickly become parroted FUD for those who don't like the concept of a proposal.

That same effect has happened with covenants on Bitcoin, so I've taken the time to collect, rebut, and give resources for each of the most common FUD points against CTV-based covenants I've seen in the space. We'll go in order from the most to least common I've seen, but note it's a subjective order! As [CTV](https://covenants.info/proposals/ctv/) is the most popular and likely initial covenant proposal, that is the focus of this particular post.

Having at least an introductory idea of what covenants are is vital to this conversation, so to learn more about covenants before diving into these points you can read more in these resources:

- [Bitcoin Covenants Wiki | covenants.info](https://covenants.info/)
- [Next-Gen Smart Contracts for Bitcoin | UTXOS.org](https://utxos.org/)
- [Bitcoin Covenants](https://bitcoincovenants.com/)
- [OP_CHECKTEMPLATEVERIFY | Bitcoin Optech](https://bitcoinops.org/en/topics/op_checktemplateverify/)
- [Covenants | Bitcoin Optech](https://bitcoinops.org/en/topics/covenants/)
- [What is #CTV BIP 119 (covenants)? | X thread by @dallasirushing](https://x.com/dallasirushing/status/1740443095689318566)
- [Covenants 101, with a focus on CTV | X thread by @OwenKemeys](https://x.com/owenkemeys/status/1741575353716326835?s=61)

## CTV could have unintended consequences

While this is a great place to *start* when considering proposals to Bitcoin, there has to be a point where you say "we've done enough research and resolved all known bad consequences." This one is easy to refute (thanks [@lopp](https://x.com/lopp)!), as there are also unintended consequences of **not** improving the protocol; i.e. a lack of approachable privacy, a harsh limit on how many people can self-custody Bitcoin, a less useful Lightning network, etc. We can quantify some of these, but there are surely many more that cannot be quantified (yet).

{{< tweet user="lopp" id="1737082565570310359" >}}

If we keep ringing the "unintended consequences" alarm bell for everything, we'll never improve Bitcoin. If we had done that in the past, we wouldn't have ever implemented Lightning. If Satoshi had thought that way, he would have never released Bitcoin to the world.

Every technology can and will have unintended consequences, both good and bad. Bitcoin is used for bad things today but that doesn't change the fact that it is freedom money and a necessity for freedom. At some point you have to do your best to make a technology a net positive and remove unintended consequences and move forward with the clear benefits it provides.

CTV is an extremely simple and specific implementation of covenants that intentionally does not support recursive covenants, and instead acts more as a way to perform more complex transactions without needing a time-consuming and complex Pre-Signed Bitcoin Transaction (PSBT) exchange. This makes the potential unintended consequences much lower and easier to quantify.

## Exchanges could force encumbering covenants

Honestly this one is the easiest to debunk, and [@4moonsettler](https://x.com/4moonsettler) has done a great job here:

{{< tweet user="4moonsettler" id="1736892059879895050" >}}

The only thing I would add is that if a government was able to force exchanges to do this, why wouldn't they just make self-custody illegal or force users into a much easier and simpler 2-of-2 multisig where they hold a key? This would be trivial to setup for an exchange, as they already have strong multisig wallets in-place, and already maintain blacklists of places their users are not allowed to withdraw funds to.

If you have the ability to withdraw to a wallet of your choice, there is no way for an exchange to force you into a covenant. If you can't withdraw to a wallet of your choice, you're FUBAR'd anyways and covenants don't make the situation any worse. If they can limit how you spend the money they sent to you, did they really send it?

{{< tweet user="jxpcsnmz" id="1737089845003190280" >}}

Preventing the immense positives that covenants bring for self-custody, self-custodial Lightning, privacy, and further scaling for a vague governmental attack that is more easily done without covenants makes no sense to me.

Note that CTV as an implementation of covenants *does not* support recursion, so the concept of a recursive encumbering covenant often lumped into this counter-argument is not valid with CTV. While a malicious actor in control of your wallet and receive address could still create an encumbering covenant, it could not be infinitely recursive and would be far harder to craft in a harmful way.

## Conclusion

If you have any questions from this post or would like more information on a specific aspect, please reach out via [Signal, SimpleX, X, or Nostr]({{< ref "/about.md#how-to-contact-me" >}}).
