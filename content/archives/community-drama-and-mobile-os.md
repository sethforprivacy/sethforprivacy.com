---
author: Seth For Privacy
authorTwitter: sethforprivacy
date: "2021-02-19T11:57:44-05:00"
summary: 'Community drama, legal battles, slandering, and harassment takes away
  from the important mission of any OS like this: privacy and security.'
draft: false
keywords:
- privacy
- Android
- GrapheneOS
- CopperheadOS
- CalyxOS
tags:
- privacy
- Android
- GrapheneOS
- CopperheadOS
- CalyxOS
title: Community Drama and My Search for a Privacy-Preserving Mobile OS
toc: true
---

***This post has been archived and much of the content is either outdated or impossible to verify. In the interest of doing what I can to move forward and repairing a broken relationship with the GrapheneOS community, I am archiving the post.***

# Introduction

Earlier this year I explored moving from iOS to a de-Googled and hardened mobile operating system. I wanted to be more intentional about my data footprint and continue my privacy journey, where I ultimately settled on [CopperheadOS](https://copperhead.co/android/).

I have since switched to CalyxOS and [written a post]({{< ref "/content/posts/switching-to-calyxos.md" >}}) about my experiences and takeaways.

In full disclosure, I originally chose CopperheadOS entirely from my own research, paid in full with Monero for the phone and the service, and wrote a blog post to help others interested in privacy and who may want to switch to a more privacy-conscious mobile operating system.

# Comparing CopperheadOS, GrapheneOS, and CalyxOS

The three main choices presented to me as de-Googled Android-based OSs were [CopperheadOS](https://copperhead.co/), [GrapheneOS](https://grapheneos.org/), and [CalyxOS](https://calyxos.org/). Upon exploring each of these, I came away with the following takeaways for each:

- ## CopperheadOS

    _(have used personally)_
  - Pros
    - Recommended by Bitcoin and Monero community members I trust
    - Hardened and de-Googled OS with no Google Play Services
    - Quick and helpful support
    - Enterprise longevity
    - Consistent updates
    - Native app integrations like Samourai Wallet
    - Accept Monero as payment
  - Cons
    - Source-available instead of open-source
    - Requires a (relatively) costly subscription for updates and support
    - Phones must be flashed by resellers, cannot manually flash
    - Ongoing legal battle against GrapheneOS and some of its contributors

- ## GrapheneOS

    _(have not used personally)_
  - Pros
    - Large community
    - Hardened and de-Googled OS with no Google Play Services
    - Fully open-source
    - Good technical reputation
    - Free
    - Accept Monero for donations
  - Cons
    - Long record of harassment and brigading of Copperhead users (including myself, as I will detail in this post) by community members
      - _Note: I cannot prove that this is not a few rogue members of the community and is representative of the GrapheneOS community as a whole, but this type of behavior has been exhibited in almost all interactions I have had with GrapheneOS community members. Hopefully this is merely rogue actors and not indicative of the whole community or project, but that is not the conclusion I have come to based on my own personal experience and evidence I have seen._
    - Ongoing legal battle against CopperheadOS

- ## CalyxOS

    _(have used personally)_
  - Pros
    - Recommended by Bitcoin and Monero community members I trust
    - Includes [microG](https://calyxos.org/features/microg/) for using Google Play Services
      - Greatly eases the transition to a de-Googled OS as you can still use apps relying on Google Play Services
    - Hardened and de-Googled OS
    - Fully open-source
    - Good technical reputation
    - Free
  - Cons
    - Worse privacy guarantees if using microG
      - Can disable entirely on initial setup if desired
    - Smaller project
    - Do not accept Monero for donations
      - Will be added soon

# Why I chose CopperheadOS

As you can see above, there are quite a few shared pros between the three projects, and all use a similarly de-Googled Android base and build upon that. CopperheadOS and GrapheneOS, in particular, share many similarities and were once a single project.

The core reason that I chose to go with CopperheadOS over GrapheneOS (I decided against CalyxOS simply because I didn't want microG) was that the phone I'm using must be well supported as I require it for work. I wanted to ensure that I would have timely updates, support, and someone on deck to help fix issues and bugs to keep my phone usable and useful. If you combine that with it coming highly recommended by many people I respect in both the Bitcoin and Monero communities while also being able to purchase both the phone and subscription with Monero, I decided to go that route.

I was very much on the fence about this decision, but continued to recommend both GrapheneOS and CalyxOS as alternatives for those not wanting to pay the subscription or unwilling to use a source-available project.

_Note: Since writing this post I have changed to using CalyxOS. For more details on the thought process on the change, please see [Switching to CalyxOS]({{< ref "/content/posts/switching-to-calyxos.md#why-calyxos" >}})_

# GrapheneOS community member's organized campaign of harassment, slander, and brigading

Unfortunately, choosing CopperheadOS of my own free will and writing about it during my free time was taken as an attack and misinformation campaign on GrapheneOS by their leader [Daniel Micay](https://x.com/DanielMicay) and others in the community.

As soon as I posted about how much I was enjoying CopperheadOS and what had helped me with the transition, I began receiving [canned reply spam](https://x.com/anupritaisno1/status/1350497125021278208?s=20) (one of many examples, see [another new/purchased user account here](https://x.com/twitty16553128)) from new or purchased accounts anytime I mentioned CopperheadOS.

***Edit: The tweet and account above have both been deleted since writing this article.***

Members of the GrapheneOS community also started messaging members of the Monero community directly, attempting to undermine my reputation and contributions:

{{< tweet user="sethforprivacy" id="1362457609077424128" >}}

{{< figure src="/community-drama-and-mobile-os/graphene_DMs.png" align="center" style="border-radius: 8px;" >}}

This has happened twice, with the latest being directly to someone via IRC. I have no idea how they found this person or why they chose them, but thankfully the Monero community can see through attacks like these.

All this to find out today that these attacks are coordinated brigading being pushed from the top down in Matrix and Telegram channels (at least) by members of the GrapheneOS community, this instance being by a lead dev for GrapheneOS as [listed on their Github](https://github.com/orgs/GrapheneOS/people):

{{< figure src="/community-drama-and-mobile-os/graphene_brigading.jpg" align="center" style="border-radius: 8px;" >}}

Feel free to read all the brigade replies on the mentioned tweet, and note this is one of many such examples:

{{< tweet user="_copperj" id="1356303734691819524" >}}

_Note: I cannot prove that this is not a few rogue members of the community and is representative of the GrapheneOS community as a whole, but this type of behavior has been exhibited in almost all interactions I have had with GrapheneOS community members. Hopefully this is merely rogue actors and not indicative of the whole community or project, but that is not the conclusion I have come to based on my own personal experience and evidence I have seen._

# Negative behavior of CopperheadOS

While I have directly been affected by harassment, slander, and brigading by members of the GrapheneOS community, that is not to say that CopperheadOS is innocent in this ongoing community drama. The ongoing legal battle between CopperheadOS and GrapheneOS has been expanded to [include contributors to the GrapheneOS project](https://renlord.com/posts/2020-03-25-copperheados-legal-threat/) in ways that do not seem right or proper to me.

As the legal proceedings are private I cannot comment on how it will turn out or who is right or wrong in this case, but the ongoing drama that is happening publicly around it is harmful to both communities, and more specifically, to people simply trying to take back a piece of their privacy via a hardened and privacy-preserving mobile OS. I have still settled on CopperheadOS for my personal use (for now) but this whole situation is a stain on both communities and muddies the waters greatly.

# Conclusion

While I would generally be a strong advocate for open-source, privacy-conscious versions of any tool, I find it hard to ignore malicious and aggressive behavior from a project's community, especially by the lead developer.

I cannot put any trust in Daniel Micay and others attacking me, and therefore will not recommend a tool run by people willing to stoop to such levels to harass others they disagree with.

GrapheneOS may very well be an excellent tool, but the community's behavior is anything but a positive indicator of the technical merit and longevity of the project. While I cannot personally recommend the project, hopefully this post will help others untangle a bit of this messy situation and make a more informed decision for themselves.

I want to be intentional about providing options for people to take control of their privacy. Community drama, legal battles, slandering, and harassment takes away from the important mission of any OS like this: privacy and security. This hurts those who want to better their life and it gets in the way of what is ultimately important.

# Next steps

If you're using Google Android/iOS today and want to switch, I can highly recommend [CalyxOS](https://calyxos.org/) as a great alternative that can be a bit easier to transition to due to [support for microG](https://calyxos.org/features/microg/) based on personal experience, and be sure to take a look at [my guide]({{< ref "/content/posts/switching-to-calyxos.md" >}}) to help the transition.

If you have any questions from this post or would like more information on a specific aspect of my thought process or decision here, please reach out via [Signal, SimpleX, X, or Nostr]({{< ref "/content/about.md#how-to-contact-me" >}}).
