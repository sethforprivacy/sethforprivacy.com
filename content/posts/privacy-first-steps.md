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

- [Brave Browser](https://brave.com/)
  - Brave has some excellent defaults, but certainly takes some odd approaches (like cryptocurrency ads all over the place and built-in cryptocurrency wallets which aren't helpful to most people).
    - [Brave hardening guide from anonymousplanet.org](https://anonymousplanet.org/guide/?h=brave#brave_1)
- [LibreWolf](https://librewolf.net/)
  - I've been leaning on LibreWolf more and more thanks to it's strong defaults, essentially giving a pre-hardened Firefox that does a great job keeping up to date with upstream Firefox updates. No hardening guide necessary, just install and enjoy!
  - P.S. - As Firefox has made some... questionable privacy policy and data handling policy changes lately, the only form of Firefox I would recommend is LibreWolf to ensure that your data is not affected in any way by their changes upstream.
- [Orion](https://kagi.com/orion/)
  - For those of you on macOS, I've been *thoroughly* enjoying Orion browser since making the switch to Kagi. It's extremely lightweight and fast, has native tracker and ad blocking as you'd expect, and of course first-class integration with Kagi search as well. It is still in beta so proceed with caution, but it's been my daily driver since I switched to macOS for my work machine for the past few months and has been fantastic.

Extensions:

- [uBlock Origin](https://github.com/gorhill/uBlock)
  - By far the most important extension and available for all of the browsers mentioned above, uBlock goes *far* beyond just blocking ads, and handles a wide swath of ad, tracker, and script blocking in a way that is very rarely detrimental to the browsing experience but has a massive impact on privacy and load times for pages. An absolute *must* install, no matter which browser you choose.
  - NOTE: Installing uBlock isn't necessary on Brave and Orion in the recommended browsers above, but if you use any others it's a must-have.
- Password manager extension
  - This extension will change based on the password manager you choose in the next step, but I highly recommend installing the password manager extension (where available) for much simpler autofill and password management when browsing.

### 3. Use a password manager

While this step isn't *technically* privacy related, properly securing accounts can lead to much better privacy by reducing the amount of data leaks and hacks you experience as a result of stolen or leaked credentials. Password managers make it extremely simple to manage usernames and passwords across all of the sites and apps you use, without needing to re-use passwords (or username or email!) in order to remember them. This has drastic implications on security, and is a huge step forward in your journey.

Migrating to a password manager is also a great chance to think twice about which accounts you *actually need*, and close those you don't in the process.

- [Proton Pass](https://proton.me/pass)
  - As a Visionary Proton user, I got the chance to try Proton Pass early and have been amazed at the strides it's made already. Proton Pass has a beautiful, simple UI, powerful features, native integration with Proton aliases + SimpleLogin, and much more. To me it's the best password manager out there, and most Proton plans even give it to you for free.
- [Bitwarden](https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager/)
  - Bitwarden was my personal favorite and what my wife and I used for many years (until recently switching to Proton Pass). It works very well, is open-source, cross-platform, and can be self-hosted (if desired).
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
  - NOTE: After Proton's acquisition of SimpleLogin, aliasing has become a native feature in Proton Mail and Proton Pass. If you're already a Proton user, check out the aliasing in both!
- [AnonAddy](https://anonaddy.com/)
  - While I haven't used AnonAddy myself, I've heard very good things from people I highly trust. It has a very similar approach to SimpleLogin but with a more generous free plan.
  - AnonAddy is also free and open-source, and can even be self-hosted!
    - <https://github.com/anonaddy/anonaddy>

### 6. Use a privacy-preserving search engine

This step can seem extremely annoying at first as none of the privacy-preserving search engines are quite as fast or complete as simply using Google, but the data you provide to a search engine tells *a lot* about you, and removing that data point is a key step towards reducing your digital footprint.

Each of the alternatives have some key pros and cons, and are really up to personal choice -- I'd recommend trying them each for a day or more as your default and see what solution fits you best.

- [Kagi](https://kagi.com/)
  - Kagi.com is a search engine with a new and refreshing take on things - instead of paying with your data or your eyes via ads, you simply... pay! Kagi has multiple paid plans (which can be paid in Bitcoin!) and has been my go-to lately as it performs extremely well and is completely ad-free. I'm not sure I can go back to another search engine at this point, Kagi, is that good.
  - NOTE: One major downside with an account-based search platform is that your searches can be easily tied back to your account. If you use Kagi and want to ensure your searches remain anonymous, be sure to enable their [Privacy Pass](https://blog.kagi.com/kagi-privacy-pass) feature on your respective platform to cryptographically break the links between your searches and your account. NGL, it's badass.
  - [Opt Out episode on Kagi](https://optoutpod.com/episodes/how-kagi-is-fixing-search-vlad-prelovac/)
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

### 7. Switch yourself and your friends/family to a more private messaging service/app

Step 6 can be one of the most difficult ones, as to get the most benefit you really need your friends and family (those you chat with most) to jump ship to a private messaging app as well. Thankfully, I was able to get all of my friends and family to switch to Signal, but I know that's not always possible.

Introducing a private-by-default and end-to-end encrypted messaging app into your workflow helps prevent self-censorship, surveillance, and state censorship in private chats, and is an essential tool to liberty long-term.

The "messaging wars" continue to rage, but I'll make my recommendations based only on what I've used heavily here.

- [Signal](https://www.signal.org/)
  - Signal holds the brand recognition they do for a reason -- it's extremely easy to use, easy to onboard new people, and has the core feature-set that most messaging apps do. Even though it's not perfect, it's an incredible tool and has been a huge boon for the privacy space and free speech so far.
  - Note that Signal does require a phone number to use, but this does not harm the *privacy* provided by Signal, and it's affects on anonymity/pseudonymity have been drastically lessened with the introduction of usernames.
  - I almost exclusively use Signal with people I know personally, and couldn't live without it.
- [SimpleX Chat](https://simplex.chat/)
  - SimpleX is a newcomer on the scene and has taken my messenger use by storm. I absolutely love their approach to providing privacy not just for message contents but also for all metadata, their server-based approach, and their slick UI and UX. It's quickly becoming my go-to instead of Signal due to the lack of any phone number requirement.
  - I interviewed the founder of Simplex, Evgeny, on Opt Out and learned a lot from him. I highly recommend listening to the episode to get a detailed picture of what they're building and what SimpleX can do today.
    - [SimpleX chat and how privacy aligns with the future of computing](https://optoutpod.com/episodes/s3e02-simplexchat/)

### 8. Use a more privacy-preserving form of money

This step can definitely slide around in order, but can be an extremely helpful one to get down before pursuing a VPN service or mobile OS to help enable private ways to pay for these types of services and hardware.

While cryptocurrencies like Bitcoin are commonly considered private or anonymous, it's important that you realize that most cryptocurrencies *are not* privacy preserving by default, and merely enable fragile pseudonymity at best. With this in mind, here are a couple recommendations for using cryptocurrencies while preserving your privacy.

- [Use Monero](https://getmonero.org/)
  - Monero is a privacy-preserving cryptocurrency in the vein of Bitcoin, but enabling privacy for the sender, receiver, and amount of each transaction by default. This means you can use any wallet you prefer and gain the same time-tested and excellent privacy offered by the Monero protocol. For more info on Monero, check out the following links:
    - [What is Monero? A simple animated introduction to Monero](https://www.youtube.com/watch?v=B7sLnmlZ-kU)
    - [A more in-depth look at Monero's privacy](https://www.youtube.com/watch?v=H33ggs7bh8M)
    - [A feature-by-feature breakdown of Monero](https://www.monerooutreach.org/gallery/know-monero.html)
    - [Try Monero in Cake Wallet](https://cakewallet.com)
- Use Robosats + Zeus
  - With the attack on financial privacy coming in the cases against Samourai Wallet and Tornado Cash, privacy on Bitcoin has gotten drastically more difficult. The first step that every privacy-conscious Bitcoiner needs to take is to avoid linking their real-world identity with their on-chain activity by avoiding "KYC" exchanges that require ID to use.
  - [Robosats](https://learn.robosats.com/) is a fantastic, Lightning-only no-KYC exchange that allows you to easily buy and sell Bitcoin with other real people around the world, all anonymously.
  - [Zeus](https://zeusln.com/) is the best Lightning wallet out there for preserving your privacy, and works well with Robosats. You can either remote control a Lightning node you run on something like Start9, or you can run it with your node on your phone directly.
  - [A simple guide to using the two together to buy/sell/spend Bitcoin privately](https://x.com/btcqna/status/1810703621731778757)
- [Use Cake Wallet with Silent Payments on Bitcoin](https://cakewallet.com)
  - Cake Wallet is a multi-cryptocurrency wallet that focuses heavily on financial privacy, starting with Monero and recently expanding to Bitcoin privacy with [Silent Payments](https://silentpayments.xyz). Silent Payments are especially useful if you need an easy way to accept donations or raise funds and don't want the headache of setting up servers etc.
    - [Their website](https://cakewallet.com)
    - [Their code](https://github.com/cake-tech/cake_wallet/)
    - [Their docs, a great way to get started](https://docs.cakewallet.com/)
    - [Intro to Silent Payments + tutorial by Ian Major](https://youtu.be/payDPlHzp58)

### 9. Use a non-logging and trustworthy VPN provider

VPNs often get a bad rap as there are *so many* malicious and predatory VPN providers out there with tons of money throwing around bad advertisements. VPNs as a tool, however, are an important part of a privacy journey, in my opinion.

Using a non-logging and trustworthy VPN is a great way to shift the trust from your network provider (home ISP, mobile carrier, etc.) to a 3rd-party you trust more than them (and that don't have your personal information or address). When selecting a VPN it's *extremely* important that you do your own research and come to your own conclusions, but I will recommend two VPNs as great starting points.

I have used both of the below VPNs extensively and they also come recommended by many people I trust dearly.

- [IVPN](https://www.ivpn.net/)
  - tl;dr -- trustworthy team, incredible cross-platform clients, strong reputation, extremely honest about shortcomings of VPNs generally, externally audited, fast, Wireguard support
- [Mullvad](https://mullvad.net/en/)
  - Mullvad is an amazing VPN provider and have long been a recommendation of mine. They have a long and storied history, great service, account-less setup, and solid cross-platform clients.
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
  - I've long been a huge fan of CalyxOS, ran it for almost a year, and am a financial supporter of the [Calyx Institute](https://calyxos.org/), the non-profit organization behind CalyxOS. CalyxOS is an incredibly powerful tool, one that takes the open-source Android operating system created by Google and strips Google's tracking and services out of it, and then builds it back up with a focus on user privacy and FOSS app stores (like F-Droid).
  - For more on CalyxOS and my experience/recommendations, see my blog post ["Switching to CalyxOS"]({{< ref "/posts/switching-to-calyxos.md" >}}).

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

If you have any questions from this post or would like more information on a specific aspect, I'd love to hear from you via [Signal, SimpleX, Threema, or Nostr]({{< ref "/about.md#how-to-contact-me" >}}).
