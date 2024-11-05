---
author: Seth For Privacy
authorTwitter: sethforprivacy
date: "2024-07-15T8:35:00-04:00"
summary: "BIP 353: Making payments social, one DNS entry at a time."
draft: false
keywords:
- Bitcoin
- privacy
- BIP 353
- BOLT 12
- Silent Payments
tags:
- Bitcoin
- privacy
- BIP 353
- BOLT 12
- Silent Payments
title: Setting up a Bitcoin username
toc: true
---

One of the trickiest things in the cryptocurrency space is finding out how to pay someone repeatedly *without having to pester them for new addresses.* The core technical hurdle of this user experience hurdle has been resolved in Monero from the start with stealth addresses, and more recently in Bitcoin with the growing adoption of [Silent Payments](https://silentpayments.xyz) (essentially stealth addresses for Bitcoin) and [BOLT 12](https://bolt12.org) invoices (reusable, privacy-preserving invoices for Lightning).

But once you have a privacy-preserving, reusable payment method, how exactly does someone find you? Do they message you once for this long string of characters? Do you post it in your X bio? How about Nostr? [BIP 353](https://bips.dev/353/) aims to solve this and make payment info easily accessible *without needing to run a server at all.* Simply adding your payment info as a DNS entry (a "TXT" record to be specific, but we'll get into that) allows any wallet supporting BIP 353 to securely resolve and validate the payment details without any interaction.

In essence, BIP 353 gives anyone with access to a domain the ability to have their own custom usernames with just a few clicks of a mouse.

## What payment info should I use?

One aspect of Bitcoin usernames that is vital to understand is that you should *never* use them with a standard Bitcoin address or a one-time BOLT 11 invoice. Setting a standard Bitcoin address with your Bitcoin username would allow anyone to easily see all payments made to/from that address, as you'd be forcing anyone who paid you to reuse the same receive address for you. On the opposite spectrum, BOLT 11 invoices can only be used once, so if you set that for your username you would have to rotate it out for a new invoice every time someone paid you, a painful process requiring automation of some sort.

Thanks to the growing adoption of Silent Payments and BOLT 12 invoices with integration into wallets like [Cake Wallet](https://cakewallet.com/), [Phoenix Wallet](https://phoenix.acinq.co/), and [Zeus](https://zeusln.com/), anyone can easily generate reusable payment codes for on-chain and Lightning, allowing you to set a static DNS record and get paid, over and over, without linking any two payments together.

## Privacy and security concerns

While DNS isn't a silver bullet, the power it brings here for user experience is well worth the tradeoffs, IMO. It's still quite easy to register a domain anonymously, using privacy-preserving payment methods, and the use of DNSSEC in BIP 353 protects you against the simplest attacks. That being said, here are some quick tips to keep in mind when setting up and using a Bitcoin username:

1. Be sure to use a domain provider that is well-known and trusted!
   1. A malicious domain operator (or simply an incompetent one that gets hacked) can replace your payment details with their own as they see fit. While this is extremely rare, it is possible, and the easiest solution is just to use a well-known, vetted domain provider. The two most well-known and trusted that accept Bitcoin etc. for payments are Njalla (as used in this guide) and Namecheap.
2. Ideally use a provider that provides domain privacy, and one that doesn't require real information.
   1. Most domain providers give you the option to hide the info used to register your domain (i.e. name, address, contact info) but some don't do this by default. Njalla does protect your info by default, but Namecheap has an additional add-on you have to purchase/enable to protect your info. For now I believe it is always free, but that could change in the future for Namecheap specifically.
3. Only use privacy-preserving payment info in your username.
4. Just like Silent Payment addresses and BOLT 12 invoices, your domain does not change. While this can provide privacy of one kind (preventing address reuse and protecting your node's privacy) it *can also be used to link your sharing of this username across platforms.* Be sure not to use a username intended to be anonymous/pseudonymous alongside your real identity etc.

## Getting a Silent Payment address and/or BOLT 12 invoice

I'll lay out the three apps I love the most to get reusable, privacy-preserving payment info from, but hopefully the number of apps supporting these in the Bitcoin ecosystem will increase rapidly! If you already use one of these wallets feel free to just follow the instructions below, or if not, pick your favorite and roll from there.

### Silent Payments via Cake Wallet

1. Download [Cake Wallet](https://cakewallet.com/)
2. Set up a new Bitcoin wallet
3. Backup your new seed phrase!
4. Hit "Receive" at the bottom
5. Tap the drop-down chevron beside "Receive" at the top
6. Select "Silent Payments"
7. Copy the address and send it yourself so you can easily copy-paste it on your computer, using something like Signal's "Note to Self"

{{< collapse summary="GIF of setup" >}}

{{< figure src="/setting-up-a-bitcoin-username/CakeSP.gif" title="Getting a Silent Payment address via Cake Wallet" >}}

{{< /collapse >}}

### BOLT 12 invoice via Phoenix Wallet

1. Download [Phoenix Wallet](https://phoenix.acinq.co/)
2. Set up Phoenix for the first time
3. Backup your new seed phrase!
4. Tap "Receive" at the bottom
5. Tap "Show reusable QR code"
6. Copy it out or share it with yourself using something like Signal's "Note to Self"

{{< collapse summary="GIF of setup" >}}

{{< figure src="/setting-up-a-bitcoin-username/phoenixBOLT12.gif" title="Getting a BOLT 12 invoice via Phoenix Wallet" >}}

{{< /collapse >}}

### BOLT 12 invoice via Zeus

1. Download [Zeus](https://zeusln.com/)
2. Setup a new wallet (either using the quick start self-contained node or connecting to your own CLN node)
   1. Note that LND does not currently support BOLT 12 and likely won't for months yet, unfortunately
3. Save your new seed phrase (if applicable)
4. Swipe left-to-right on the "Lightning" pill on the home screen
5. Tap on "Pay Codes"
6. Set a label for the BOLT 12 pay code if desired
7. Select the new pay code
8. Long-press on the BOLT 12 field to copy out the invoice, and send it yourself so you can easily copy-paste it on your computer, using something like Signal's "Note to Self"

{{< collapse summary="GIF of setup" >}}

{{< figure src="/setting-up-a-bitcoin-username/ZeusBOLT12.gif" title="Getting a BOLT 12 invoice via Zeus Wallet" >}}

{{< /collapse >}}

## Getting a domain

Now comes the hardest part of all of this. In order to use BIP 353, you have to own a domain (something like `sethforprivacy.com` as I have here) to be able to set these payment instructions up on. This is still pretty straightforward but I'll walk you through it on my favorite domain registrar, [Njalla](https://njal.la/). These steps will have you use the Tor browser to gain a bit more anonymity from Njalla when setting up your domain, but if that isn't necessary for you (i.e. you plan to use the domain for other things that would be linked to you anyways) feel free to use their normal website.

1. Download the Tor browser if you don't already have it
2. Open Tor, and navigate to `https://njallalafimoej5i4eg7vlnqjvmb6zhdh27qxcatdn647jtwwwui3nad.onion/`
3. Search for a domain that you find interesting, being as vague or specific as you want
    {{< figure src="/setting-up-a-bitcoin-username/njalla-1.png" title="Njalla via Tor browser" >}}
4. If you see a fitting domain, simply click "Select domain"
    {{< figure src="/setting-up-a-bitcoin-username/njalla-2.png" title="Searching for a domain" >}}
5. Select "Check out"
6. Create an account
   1. Ideally, you should use something like [SimpleLogin](https://simplelogin.io/) for an email alias here
   2. Also, you should use a strong, unique password using something like [Bitwarden](https://bitwarden.com/)
    {{< figure src="/setting-up-a-bitcoin-username/njalla-3.png" title="Creating an account" >}}
7. Once you get to your cart, click "Add funds" at the bottom right
    {{< figure src="/setting-up-a-bitcoin-username/njalla-4.png" title="Njalla cart" >}}
8. Add funds using your preferred payment method
   1. I would highly advise paying with something privacy-preserving like Monero (or post-mix funds if paying with Bitcoin) to ensure you don't have financial ties back to yourself from the domain
    {{< figure src="/setting-up-a-bitcoin-username/njalla-5.png" title="Adding funds" >}}
9. Select "Pay Now" once funds are confirmed

And that's it! You're now the proud owner of a new domain that you can use for BIP 353 Bitcoin usernames (among many other things).

## Setting up your Bitcoin username

Once you have a domain, it's time to finally set up your username. For this step, be sure you've first created a Silent Payment address or BOLT 12 invoice as detailed above, as we'll need it for this to work. Be sure you're logged in to your Njalla account you created previously (or the domain provider of your choice) before starting here.

As Namecheap is another extremely popular domain provider, I'll also detail the steps for Namecheap configuration below for those who need it.

### Creating your Bitcoin username on Njalla

1. Go to the "Domains" tab
2. Select "Manage" on the far right of your preferred domain
3. Select "Add record" at the bottom left
    {{< figure src="/setting-up-a-bitcoin-username/njalla-6.png" title="Adding a record" >}}
4. Change the "Type" dropdown from "A" to "TXT"
5. For the "Name" field, enter `username.user._bitcoin-payment`, replacing `username` with whatever you prefer (i.e. `tips`)
   1. This will be the username before the `@domain.com` portion of the BIP 353 address
6. For the "Content" field you need to create a string in a specific format (specified by [BIP 21](https://bips.dev/21/))
   1. If you want to only use a BOLT 12 invoice, enter the following, replacing "REPLACE_ME" with your BOLT 12 invoice (the string starting with `lno` that you got from Phoenix or Zeus)
      1. `bitcoin:?lno=REPLACE_ME`
      2. i.e. `bitcoin:?lno=lno1pgqpvggzrdhszmg5yafguxmkm779vd8jftxskjyadjdrallmq8uxfjdjfyaq`
   2. If you want to only use a Silent Payments address, enter the following, replacing "REPLACE_ME" with your Silent Payments address (the string starting with `sp1` that you got from Cake Wallet)
      1. `bitcoin:?sp=REPLACE_ME`
      2. i.e. `bitcoin:?sp=sp1qqweplq6ylpfrzuq6hfznzmv28djsraupudz0s0dclyt8erh70pgwxqkz2ydatksrdzf770umsntsmcjp4kcz7jqu03jeszh0gdmpjzmrf5u4zh0c`
   3. If you want to use both BOLT 12 and Silent Payments for the same username, replace "REPLACE_ME_BOLT_12" with your BOLT 12 invoice (the string starting with `lno` that you got from Phoenix or Zeus) and "REPLACE_ME_SP" with your Silent Payments address (the string starting with `sp1` that you got from Cake Wallet)
      1. `bitcoin:?lno=REPLACE_ME_BOLT_12&sp=REPLACE_ME_SP`
      2. i.e. `bitcoin:?lno=lno1pgqpvggzrdhszmg5yafguxmkm779vd8jftxskjyadjdrallmq8uxfjdjfyaq&sp=sp1qqweplq6ylpfrzuq6hfznzmv28djsraupudz0s0dclyt8erh70pgwxqkz2ydatksrdzf770umsntsmcjp4kcz7jqu03jeszh0gdmpjzmrf5u4zh0c`
    {{< figure src="/setting-up-a-bitcoin-username/njalla-7.png" title="Setting TXT record" >}}
7. Select "Add" at the right
8. Go to the "DNSSEC" tab
9. Select "Enable DNSSEC"
   1. DNSSEC is a protocol to ensure that no one between you and the proper DNS server can replace the TXT record with their own payment information, and is a vital security aspect of BIP 353. Without it, your username won't work!

And that's it! You should now be able to receive payments at your new username, sharing it as username@domain.com, in this instance `tips@bip353.com`.

### Creating your Bitcoin username on Namecheap

1. Log in to your [Dashboard](https://ap.www.namecheap.com/dashboard)
2. Select "Manage" on the right side of your domain
3. Select the "Advanced DNS" tab on the top right
    {{< figure src="/setting-up-a-bitcoin-username/namecheap-1.png" title="Advanced DNS tab" >}}
4. Select "Add new record" under the "Host Records" section
    {{< figure src="/setting-up-a-bitcoin-username/namecheap-2.png" title="Adding a new record" >}}
5. Change the drop-down from "A record" to "TXT record"
6. For the "Host" field, enter `username.user._bitcoin-payment`, replacing `username` with whatever you prefer (i.e. `tips`)
   1. This will be the username before the `@domain.com` portion of the BIP 353 address
7. For the "Value" field you need to create a string in a specific format (specified by [BIP 21](https://bips.dev/21/))
   1. If you want to only use a BOLT 12 invoice, enter the following, replacing "REPLACE_ME" with your BOLT 12 invoice (the string starting with `lno` that you got from Phoenix or Zeus)
      1. `bitcoin:?lno=REPLACE_ME`
      2. i.e. `bitcoin:?lno=lno1pgqpvggzrdhszmg5yafguxmkm779vd8jftxskjyadjdrallmq8uxfjdjfyaq`
   2. If you want to only use a Silent Payments address, enter the following, replacing "REPLACE_ME" with your Silent Payments address (the string starting with `sp1` that you got from Cake Wallet)
      1. `bitcoin:?sp=REPLACE_ME`
      2. i.e. `bitcoin:?sp=sp1qqweplq6ylpfrzuq6hfznzmv28djsraupudz0s0dclyt8erh70pgwxqkz2ydatksrdzf770umsntsmcjp4kcz7jqu03jeszh0gdmpjzmrf5u4zh0c`
   3. If you want to use both BOLT 12 and Silent Payments for the same username, replace "REPLACE_ME_BOLT_12" with your BOLT 12 invoice (the string starting with `lno` that you got from Phoenix or Zeus) and "REPLACE_ME_SP" with your Silent Payments address (the string starting with `sp1` that you got from Cake Wallet)
      1. `bitcoin:?lno=REPLACE_ME_BOLT_12&sp=REPLACE_ME_SP`
      2. i.e. `bitcoin:?lno=lno1pgqpvggzrdhszmg5yafguxmkm779vd8jftxskjyadjdrallmq8uxfjdjfyaq&sp=sp1qqweplq6ylpfrzuq6hfznzmv28djsraupudz0s0dclyt8erh70pgwxqkz2ydatksrdzf770umsntsmcjp4kcz7jqu03jeszh0gdmpjzmrf5u4zh0c`
    {{< figure src="/setting-up-a-bitcoin-username/namecheap-3.png" title="Setting TXT record" >}}
8. Hit the green checkmark on the right side of the record to save it
9. Ensure DNSSEC is enabled in the section right below the "Host Records" section, enabling it if disabled
    {{< figure src="/setting-up-a-bitcoin-username/namecheap-4.png" title="Enabling DNSSEC" >}}

### Test out your new username

The best tool to test out your new username is built by [TheBlueMatt](https://x.com/TheBlueMatt), the author of BIP 353.

1. Navigate to [satsto.me](https://satsto.me/)
2. Enter your new username@domain.com address in the text box
   1. i.e. `tips@bip353.com`
3. Check that the payment details resolve properly

{{< figure src="/setting-up-a-bitcoin-username/satstome.png" title="Testing your BIP 353 username" >}}

You can also test out the details using a wallet like Phoenix wallet that supports BIP 353 already.

## Usernames for Monero

For those of you only using Monero, there is a very similar protocol supported called Open Alias. There is a great guide written up by [Justin Ehrenhofer](https://x.com/jehrenhofer) quite a while ago that details what Open Alias is, how it's useful, and how to set it up: [OpenAlias, the best cryptocurrency wallet feature you’ve never heard of | Justin Ehrenhofer](https://medium.com/@JEhrenhofer/openalias-the-best-cryptocurrency-wallet-feature-youve-never-heard-of-bbf4a991d0a8)

You'll still need a domain for this, so feel free to use the directions above up until the steps that have you set the Bitcoin username and instead use the values Justin guides you through. Note that OpenAlias has broad support within the Monero ecosystem and works today in every wallet I know of!

## Conclusion

I'm very excited to see BIP 353 usernames grow in adoption, as they make reusable, privacy-preserving payment methods far easier to discover and use when paying other Bitcoiners. Hopefully this guide helps more and more people get setup and rolling! If this guide seems too daunting for you (or you just don't want to deal with owning a domain), be sure to check out [twelve.cash](https://twelve.cash/), a fantastic (but trusted!) service.

If you have any questions from this post or would like more information on a specific aspect, please reach out via [Signal, SimpleX, X, or Nostr]({{< ref "/about.md#how-to-contact-me" >}}).

## Appendix: Additional community-recommended domain providers

{{< notice warning >}}
Please note that I have not personally used the following domain providers, but they have been recommended to me by individuals I have a reason to trust. Use at your own risk!
{{< /notice >}}

- [MyNymBox](https://mynymbox.io/)
- [IncogNet](https://incognet.io/)
- [NiceVPS](https://nicevps.net/)
  - [Tor .Onion URL](http://nicevpsvzo5o6mtvvdiurhkemnv7335f74tjk42rseoj7zdnqy44mnqd.onion/)
