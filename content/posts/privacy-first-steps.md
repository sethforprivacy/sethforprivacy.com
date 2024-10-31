---
author: Seth For Privacy
comments: false
date: "2021-12-21T10:00:00-04:00"
summary: An extensive post detailing a recommendation of the order of steps I would
  take if starting from scratch in my privacy journey today.
draft: false
hidemeta: false
showToc: true
tags:
- privacy
- threat model
- beginner
title: Privacy first steps
weight: 1
---

One of the most common questions I get from people who are starting to realize the need for personal privacy is "Where do I start?"

While this question is not one I can answer *for* you, I wanted to go ahead and put together a recommendation of the order of steps I would take if starting from scratch in my privacy journey today.

Please remember that not all threat models are equal, and not all people have the same priorities -- so be sure to take what is below (especially the order!) with a grain of salt and try to assess the best path for you, personally.

For more on threat modeling, check out the following resources:

- [Threat modeling tutorial by Techlore](https://www.youtube.com/watch?v=DHZRhboZhfI)
- [Threat modeling guide by TheNewOil](https://thenewoil.org/threatmodel.html)
- [EFF threat modeling tutorial](https://ssd.eff.org/en/module/your-security-plan)
- [Privacy Guides threat modeling tutorial](https://www.privacyguides.org/threat-modeling/)
- [ArsTechnica threat modeling tutorial](https://arstechnica.com/information-technology/2017/07/how-i-learned-to-stop-worrying-mostly-and-love-my-threat-model/)

### 1. Find a privacy-loving community

The first in the list might not be a technical solution, but it's by far the most important in my experience. Having a group of people around you to support you, give solid feedback, and bounce ideas off of is an *essential* aspect of a successful journey towards privacy.

Not only is this type of community beneficial along the way, they can often help with many of the feelings that come along with falling down the privacy "rabbit hole", like nihilism, loneliness, etc.

Before you go any further, I'd recommend this step be priority number one for you no matter your own personal threat model. Below are some recommended communities that I have found helpful along the way:

- [Techlore's Forums](https://discuss.techlore.tech/)
  - [Discord](https://discord.gg/Xd7baMSpqS)
- [Opt Out Podcast Matrix room](https://matrix.to/#/#opt-out-podcast:monero.social)
- [TheNewOil Matrix room](https://matrix.to/#/#TheNewOil:matrix.org)

### 2. Use a privacy-preserving browser

The next step is one that can be daunting, but thankfully there are excellent browser alternatives out there these days. We spend more and more of our lives in web apps as time goes by, and so a browser that is more privacy-preserving by default can be a huge win in decreasing the amount of data that 3rd-parties can collect about you from simply browsing.

If you happen to be running one of the recommended browsers, awesome! Just take a look at the hardening links (if applicable) and the recommended extensions to see if they're of interest to you.

Browsers:

- [Firefox](https://www.mozilla.org/en-US/firefox/new/)
  - ["The Ultimate Guide to Firefox Hardening!" - TechLore](https://www.youtube.com/watch?v=F7-bW2y6lcI)
    - By far my favorite hardening guide for Firefox and made by my good friends at [TechLore](https://techlore.tech/), goes step by step with very simple instructions and walks you through the process. Don't let it scare you! It's very straightforward, and only needs to be done once per computer you have/use.
- [Brave Browser](https://brave.com/)
  - Brave has some excellent defaults, but certainly takes some odd approaches (like cryptocurrency ads all over the place and built-in cryptocurrency wallets which aren't helpful to most people).
    - [Brave hardening guide from anonymousplanet.org](https://anonymousplanet.org/guide.html#brave-1)
- [Ungoogled Chromium](https://github.com/Eloston/ungoogled-chromium)
  - Ungoogled Chromium takes the best of Chrome Browser and strips Google from it, making a very compelling and very fast browser. It can be a bit tricky to get and keep updated on some operating systems, and extension installation and updates are a bit of a pain, but it's a great option for those who are a bit more hardcore but like the Chrome web engine.

Extensions:

- [uBlock Origin](https://github.com/gorhill/uBlock)
  - By far the most important extension and available for all of the browsers mentioned above, uBlock goes *far* beyond just blocking ads, and handles a wide swath of ad, tracker, and script blocking in a way that is very rarely detrimental to the browsing experience but has a massive impact on privacy and load times for pages. An absolute *must* install, no matter which browser you choose.
- [LocalCDN](https://www.localcdn.org/)
  - Similarly to [Decentraleyes](https://decentraleyes.org/), LocalCDN helps to improve privacy by replacing externally hosted assets with local ones, reducing network calls and reducing the risk of compromised assets being delivered by web pages. Deeply understanding what this does takes a deep knowledge of how the modern Internet works, but none of that is necessary here -- LocalCDN just works and works well.
- Password manager extension
  - This extension will change based on the password manager you choose in the next step, but I highly recommend installing the password manager extension (where available) for much simpler autofill and password management when browsing.

### 3. Use a password manager

While this step isn't *technically* privacy related, properly securing accounts can lead to much better privacy by reducing the amount of data leaks and hacks you experience as a result of stolen or leaked credentials. Password managers make it extremely simple to manage usernames and passwords across all of the sites and apps you use, without needing to re-use passwords (or username or email!) in order to remember them. This has drastic implications on security, and is a huge step forward in your journey.

Migrating to a password manager is also a great chance to think twice about which accounts you *actually need*, and close those you don't in the process.

- [Bitwarden](https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager/)
  - Bitwarden is my personal favorite and what my wife and I use. It works very well, is open-source, cross-platform, and can be self-hosted (if desired).
  - [Opt Out episode on Bitwarden](https://optoutpod.com/episodes/s2e09-bitwarden/)
- [KeepassXC](https://keepassxc.org/)
  - KeepassXC is a well-respected FOSS password manager, but importantly does not integrate sync across devices natively, which is a deal-breaker for me. Outside of that, though, it works extremely well and has a long and solid history.

### 4. Use a privacy-preserving email service

Many people choose to start here, and I fully understand if you feel the same way, but to me the process of switching email providers was a *long* one and quite involved, so I would generally have done this after improving my browsing and having a password manager handy. Migrating email and passwords (with a good password manager) go hand-in-hand quite well, and can save you a lot of time if you can couple the two tasks.

Using an email provider that is privacy-preserving and uses some native method of end-to-end encryption as well is a key way to reduce the data available about your communication, shopping, job hunting, etc. from an invasive company like Google or Microsoft. This is a very important step, and gives you an awesome chance to evaluate what subscriptions and accounts you want to keep, and make a clean break from the rest.

- [ProtonMail](https://protonmail.com/)
  - Probably the most well-known name in the privacy-preserving email space, and for good reason. ProtonMail has many solid features out of the box, a usable free tier, and solid cross-platform clients to go with a long history of supporting user privacy. Their excellent UX and support make this my preferred email provider, and how I do all of my email.
- [Tutanota](https://tutanota.com/)
  - While I haven't used them, I know many people I trust who do and have heard nothing but great things. They also provide steep discounts to FOSS and non-profit organizations, so well worth a look if you happen to be a part of either of those.

### 5. Use an email aliasing service

Once you're using a more privacy-preserving email, you can also leverage email aliasing services to create unique email addresses (also called "aliases") for each and every account and subscription you have online. When you use unique email aliases for every account you have, not only do you prevent trivial links between accounts (by using the same email address) in the event of a hack or collusion between companies, you also allow yourself to easily prevent spam or unwanted emails from individual services. Email alias gets leaked in a hack? Just disable that one alias and move on with your life. Company starts spamming you with marketing emails with or without your consent? Disable that one alias and move on with your life.

Email aliasing services give you pseudonymity and control of your email inbox in an entirely new and powerful way, and are something I use *daily* as a part of my setup now. They seem daunting at first, but if you sign up for an email aliasing service and then replace one email address at a time as you sign into accounts (similarly to how I recommend switching to Bitwarden), you'll have all of your accounts updated in no time.

If you'd like to purchase a premium plan for either of the below services, you can do so with Bitcoin or Monero via a favorite proxy merchant of mine, ProxySto.re: [ProxyStore - Digital Goods](https://digitalgoods.proxysto.re/en).

- [SimpleLogin](https://simplelogin.io/)
  - SimpleLogin is the service I use and has been an incredible tool for me personally. I use their paid plan (paid with Monero yearly!) and have over 200 (!!) aliases setup right now, with the count rapidly rising. Couldn't live without them, and their recent teaming up with Proton promises tight integration with Proton's privacy tooling and other great things to come! They also have excellent browser extensions and a simple and easy-to-use mobile app.
  - I did a podcast episode with SimpleLogin where we went into great detail on what email aliasing is and why it's so useful, you can listen in here:
    - [Email aliasing w/ Son from SimpleLogin](https://optoutpod.com/episodes/s2e01-simplelogin/)
  - SimpleLogin is also free and open-source, and can even be self-hosted!
    - <https://github.com/simple-login/app>
- [AnonAddy](https://anonaddy.com/)
  - While I haven't used AnonAddy myself, I've heard very good things from people I highly trust. It has a very similar approach to SimpleLogin but with a more generous free plan.
  - AnonAddy is also free and open-source, and can even be self-hosted!
    - <https://github.com/anonaddy/anonaddy>

### 6. Use a privacy-preserving search engine

This step can seem extremely annoying at first as none of the privacy-preserving search engines are quite as fast or complete as simply using Google, but the data you provide to a search engine tells *a lot* about you, and removing that data point is a key step towards reducing your digital footprint.

Each of the alternatives have some key pros and cons, and are really up to personal choice -- I'd recommend trying them each for a day or more as your default and see what solution fits you best.

- [Brave Search](https://search.brave.com/)
  - Unlike the other options here (and other popular ones), Brave is building their own search engine from the ground up instead of just proxying results from Google or Microsoft. I've been testing this out lately as a replacement for DuckDuckGo and have been thoroughly impressed. Solid results, great features (bangs!), ~~and no issues using with a VPN (unlike Startpage)~~ (*Update: unfortunately, starting in 2023 I have had off-and-on issues with Captcha's being served when using a VPN with Brave Search*).
- [Searx](https://searx.github.io/searx/)
  - Searx is probably the most hard-core of the options, but provides a very solid experience and search results across multiple sources. I actually use SearX exclusively now and am very impressed with it.
  - My public instance is available at <https://searx.sethforprivacy.com>
  - [Public instances](https://searx.space/)
- [Whoogle](https://github.com/benbusby/whoogle-search)
  - I personally host a [public instance of Whoogle](https://search.sethforprivacy.com/) and really appreciate the ability to get Google search results without revealing IP address and without the extra bloat of Google searches. It's also quite easy to self-host, if desired.
  - [Public instances](https://github.com/benbusby/whoogle-search#public-instances)
  - [Opt Out episode on Whoogle](https://optoutpod.com/episodes/s2e12-whoogle/)
- [Kagi](https://kagi.com/)
  - Kagi.com is a search engine with a new and refreshing take on things - instead of paying with your data or your eyes via ads, you simply... pay! Kagi has multiple paid plans (which can be paid in Bitcoin!) and has been my go-to lately as it performs extremely well and is completely ad-free.

### 7. Switch yourself and your friends/family to a more private messaging service/app

Step 6 can be one of the most difficult ones, as to get the most benefit you really need your friends and family (those you chat with most) to jump ship to a private messaging app as well. Thankfully, I was able to get all of my friends and family to switch to Signal, but I know that's not always possible.

Introducing a private-by-default and end-to-end encrypted messaging app into your workflow helps prevent self-censorship, surveillance, and state censorship in private chats, and is an essential tool to liberty long-term.

The "messaging wars" continue to rage, but I'll make my recommendations based only on what I've used heavily here.

- [Signal](https://www.signal.org/)
  - Signal holds the brand recognition they do for a reason -- it's extremely easy to use, easy to onboard new people, and has the core feature-set that most messaging apps do. Even though it's not perfect, it's an incredible tool and has been a huge boon for the privacy space and free speech so far. 
  - Note that Signal does require a phone number to use, but this does not harm the *privacy* provided by Signal, but can be detrimental if pseudonymity or anonymity in messaging are key to your threat model.
  - I tend to use Signal with people I know personally, and couldn't live without it.
- [SimpleX Chat](https://optoutpod.com/episodes/s3e02-simplexchat/)
  - SimpleX is a newcomer on the scene and has taken my messenger use by storm. I absolutely love their approach to providing privacy not just for message contents but also for all metadata, their server-based approach, and their slick UI and UX. It's quickly becoming my go-to instead of Signal due to the lack of any phone number requirement.
  - I interviewed the founder of Simplex, Evgeny, on Opt Out and learned a lot from him. I highly recommend listening to the episode to get a detailed picture of what they're building and what SimpleX can do today.
    - [SimpleX chat and how privacy aligns with the future of computing](https://optoutpod.com/episodes/s3e02-simplexchat/)
- [Threema](https://threema.ch/en)
  - Threema takes the template of WhatsApp and orients the app around preserving user-privacy, including end-to-end encrypted chats by default, voice messages, and other features users of WhatsApp will be very familiar with. It also drops the phone number requirement of Signal, which is a big win for pseudonymity.
  - I tend to use Threema for chats with people I don't know personally, and have really enjoyed the experience (both with direct and group messaging).

### 8. Use a more privacy-preserving form of money

This step can definitely slide around in order, but can be an extremely helpful one to get down before pursuing a VPN service or mobile OS to help enable private ways to pay for these types of services and hardware.

While cryptocurrencies like Bitcoin are commonly considered private or anonymous, it's important that you realize that most cryptocurrencies *are not* privacy preserving by default, and merely enable fragile pseudonymity at best. With this in mind, here are a couple recommendations for using cryptocurrencies while preserving your privacy.

- [Use Monero](https://getmonero.org/)
  - Monero is a privacy-preserving cryptocurrency in the vein of Bitcoin, but enabling privacy for the sender, receiver, and amount of each transaction by default. This means you can use any wallet you prefer and gain the same time-tested and excellent privacy offered by the Monero protocol. For more info on Monero, check out the following links:
    - [What is Monero? A simple animated introduction to Monero](https://www.youtube.com/watch?v=B7sLnmlZ-kU)
    - [A more in-depth look at Monero's privacy](https://www.youtube.com/watch?v=H33ggs7bh8M)
    - [A feature-by-feature breakdown of Monero](https://www.monerooutreach.org/gallery/know-monero.html)
- Use [Samourai Wallet](https://samouraiwallet.com/) or [Sparrow Wallet](https://www.sparrowwallet.com/) for Bitcoin
  - The privacy stack that Samourai Wallet have built is by far the best way to use Bitcoin, and enables fairly easy to use and approachable privacy without the need for another cryptocurrency. While privacy on Bitcoin can be extremely fragile and difficult to achieve, Samourai Wallet makes it as simple as possible, keeps fees down, and has a long track record of preserving user privacy on Bitcoin. For more info on Samourai, check out the following links:
    - [Their website](https://samouraiwallet.com/)
    - [Their code](https://code.samourai.io/explore/groups)
    - [Simple guide to mixing Bitcoin using Samourai Wallet by BitcoinQnA](https://bitcoiner.guide/privacy/separate/)
    - [In-depth guide to Samourai Wallet usage by EconoAlchemist](https://www.econoalchemist.com/post/bitcoin-wallets-for-beginners-part-ii)
    - [An in-depth walk through of what Samourai Wallet is, how they operate, and what you can expect](https://optoutpod.com/episodes/s2e03-samourai-wallet/)
  - Sparrow Wallet is built from the ground up as an approachable and yet powerful desktop wallet for Bitcoin, with deep support for the Samourai privacy tools like Whirlpool and their post-mix tooling. It allows you to easily connect to your own node, use a recommended public node, or run Bitcoin Core on the same computer and connect directly. I actually use Sparrow Wallet almost exclusively for on-chain transactions these days, paired with my [Foundation Passport hardware wallet](https://foundationdevices.com/passport/).
    - [Their website](https://www.sparrowwallet.com/)
    - [Their code](https://github.com/sparrowwallet/sparrow)
    - [Their docs, a great way to get started](https://www.sparrowwallet.com/docs/)

### 9. Use a non-logging and trustworthy VPN provider

***NOTE: My podcast, Opt Out, is sponsored by one of the VPNs recommended here. That does not, however, change my recommendation, but I wanted to state it plainly so you can make a well-informed decision. This post (and its content) are not sponsored in any way, however.***

VPNs often get a bad rap as there are *so many* malicious and predatory VPN providers out there with tons of money throwing around bad advertisements. VPNs as a tool, however, are an important part of a privacy journey, in my opinion.

Using a non-logging and trustworthy VPN is a great way to shift the trust from your network provider (home ISP, mobile carrier, etc.) to a 3rd-party you trust more than them (and that don't have your personal information or address). When selecting a VPN it's *extremely* important that you do your own research and come to your own conclusions, but I will recommend two VPNs as great starting points.

I have used both of the below VPNs extensively and they also come recommended by many people I trust dearly.

- [IVPN](https://www.ivpn.net/)
  - I've spoken at length on why I trust and use IVPN, but for more details check out [this link](https://optoutpod.com/sponsors/#ivpn).
  - tl;dr -- trustworthy team, incredible cross-platform clients, strong reputation, extremely honest about shortcomings of VPNs generally, externally audited, fast, Wireguard support
- [Mullvad](https://mullvad.net/en/)
  - Mullvad is an amazing VPN provider and have long been a recommendation of mine. They have a long and storied history, great service, accountless setup, and solid cross-platform clients.
- [Proton VPN](https://protonvpn.com/)
  - Proton have proven themselves time and time again to be a focused and dedicated company, and their VPN service reflects that. It works extremely well, has a generous free plan, and comes bundled with most of their email plans for very cheap.

To help you make your own well-informed choices, here are some excellent resources:

- [IVPN's own tool, "Do I need a VPN?"](https://www.doineedavpn.com/)
- [Techlore's incredible VPN toolkit](https://techlore.tech/vpnchart.html)
- Two episodes of [Opt Out](https://optoutpod.com/) focused on VPNs and Tor:
  - ["Global surveillance, VPNs, and Tor w/ Smuggler"](https://optoutpod.com/global-surveillance-vpns-and-tor-w-smuggler/)
  - ["Balancing privacy with mental health, plus second realms w/ j43"](https://optoutpod.com/balancing-privacy-with-mental-health-plus-second-realms-w-j43/)

### 10. Use a privacy-preserving mobile operating system

This section is a bit more drastic than the others, but switching to an operating system that is designed around protecting user privacy gives you a strong foundation for all of the other steps to live on top of and enhances their effect (and often makes them easier!). For more on the broad topic of mobile privacy, listen to this [episode I did with Matt Odell on Citadel Dispatch](https://citadeldispatch.com/cd34/) on the topic.

The only real recommendations I have here are below, but note that for some threat models using an iPhone can be a solid approach to gaining strong *3rd-party* privacy (i.e. from other data collection, but not from Apple).

- [GrapheneOS](https://grapheneos.org/)
  - I've been testing out GrapheneOS for over a year now and am thoroughly impressed with how far the usability has come since the beginning of 2022. The [Sandboxed Google Play Service](https://grapheneos.org/usage#sandboxed-google-play) enables better support for apps than microG and works seamlessly once installed. If you want a bit more security to go with the privacy, consider trying out GrapheneOS.
- [CalyxOS](https://calyxos.org/)
  - I've long been a huge fan of CalyxOS, have run it for almost a year, and am a financial supporter of the [Calyx Institute](https://calyxos.org/), the non-profit organization behind CalyxOS. CalyxOS is an incredibly powerful tool, one that takes the open-source Android operating system created by Google and strips Google's tracking and services out of it, and then builds it back up with a focus on user privacy and FOSS app stores (like F-Droid).
  - For more on CalyxOS and my experience/recommendations, see my blog post ["Switching to CalyxOS"]({{< ref "/content/posts/switching-to-calyxos.md" >}}).

### 11. Use a more privacy-conscious desktop operating system

This last step can be very daunting at first, but is a good step once you're a bit deeper down the privacy and self-sovereignty rabbit hole. Things are getting better each year, but switching to Linux is still something that requires some extra know-how and dedication to find alternative apps and tools.

I do think the switch is well worth it and not nearly as painful as I expected - I have switched entirely to running Linux on both my desktop and laptop without serious issues - but I understand my approach and tools used can be quite different to many people.

There are *many* options to choose from when considering switching to Linux, but I'll just give my top two recommendations that are relatively easy to switch to and use, comparatively:

- [Pop_OS! by System76](https://pop.system76.com/)
  - This is the Linux distribution (distro) that I use on all my computers, and is a great balance between productivity and ease-of-use in my opinion. It's based on Ubuntu and provides sane defaults, a powerful app store, and consistent and stable updates.
  - [System76](https://system76.com/), the company behind Pop_OS!, also sells their own laptops and desktops that are custom-built for using Pop_OS!, often integrating FOSS firmware, Coreboot, and other extremely powerful and important features.
    - I interviewed System76's Principal Engineer, Jeremy Soller, on Opt Out, focusing on what they do, why open-source firmware matters, and much more:
      - [Coreboot, FOSS firmware, Pop_OS!, and System76 w/ Jeremy Soller](https://optoutpod.com/episodes/special-jeremy-soller-system76/)
- [ZorinOS](https://zorin.com/os/)
  - While I haven't used this personally, I've heard excellent things from people I trust and I love the "easy to switch" approach that ZorinOS takes. This may be the easiest visual switch from Windows or macOS, and if you're willing to pay you can get a lot of extra features, support, and bundled apps as well.

## Conclusion

While these steps are certainly not the end-all-be-all of privacy, they're hopefully a solid and straightforward set of steps to get you thinking about where to go next in your privacy journey. Take them with a grain of salt and see what is most important to you personally, then make the jump into the next step of your journey!

If you have any questions from this post or would like more information on a specific aspect, I'd love to hear from you via [Signal, SimpleX, Threema, or Nostr]({{< ref "/content/about.md#how-to-contact-me" >}}).
