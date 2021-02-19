+++
title = "Why I Can't Recommend GrapheneOS"
date = 2021-02-19T11:57:44-05:00
author = "Seth Simmons"
authorTwitter = "sethisimmons" #do not include @
cover = ""
tags = ["privacy", "GrapheneOS", "CopperheadOS", "CalyxOS"]
keywords = ["privacy", "GrapheneOS", "CopperheadOS", "CalyxOS"]
description = ""
summary = ""
showFullContent = false
toc = true
draft = true
+++

# Introduction

Earlier this year I explored moving from iOS to a de-Googled and hardened mobile OS, as I wanted to take the next step of my privacy journey. Ultimately, that led me to choose Copperhead OS and [write a post]({{< ref "/content/posts/switching-to-copperhead-os.md" >}}) about my experiences and takewaways.

I did this entirely from my own research, paid in full with Monero for the phone and service, and wrote the blog post to help any of my readers who also wanted to make the jump to Copperhead OS or a similar de-Googled OS.

Unfortunately, choosing Copperhead OS of my own free will and writing about it during my free time was taken as an attack on GrapheneOS by their leader [Daniel McCay](https://tweet.lambda.dance/DanielMicay) and others in the community. 

# Comparing CopperheadOS, GrapheneOS, and CalyxOS

The three main choices presented to me as de-Googled Android-based OSs were [CopperheadOS](https://copperhead.co/), [GrapheneOS](https://grapheneos.org/), and [CalyxOS](https://calyxos.org/). Upon exploring each of these, I came away with the following takeaways for each:

- ## CopperheadOS (have used personally)
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
    
- ## GrapheneOS (have not used personally)
  - Pros
      - Large community
      - Hardened and de-Googled OS with no Google Play Services
      - Fully open-source
      - Good technical reputation
      - Free
      - Accept Monero for donations
  - Cons  
      - Unstable leadership
      - Personally harassed me
      - Long record of harassment and brigading of Copperhead users
    
- ## CalyxOS (have not used personally)
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
    
# Why I chose CopperheadOS

As you can see above, there are quite a few shared pros between the three projects, and all use a similarly de-Googled Android base and build upon that. CopperheadOS and GrapheneOS, in particular, share many similarities and were once a single project.

The core reason that I chose to go with CopperheadOS over GrapheneOS (I decided against CalyxOS simply because I didn't want microG) was that the phone I'm using must be well supported as I require it for my work. I wanted to ensure that I would have timely updates, support, and someone on deck to help fix issues and bugs to keep my phone usable and useful. Combine that with the fact that it came highly recommended by many people I respected in both the Bitcoin and Monero communities and I was able to purchase both the phone and subscription with Monero and I decided to pull the trigger.

I was very much on the fence about this decision but decided to go with CopperheadOS for the above reasons and continued to recommend both GrapheneOS and CalyxOS as alternatives for those not wanting to pay the subscription or unwilling to use a source-available project instead of a fully open-source project.

Unfortunately, that has since changed:

{{< tweet 1362397771957960704 >}}

# GrapheneOS's organized campaign of harassment, slander, and brigading

As soon as [I posted]({{< ref "/content/posts/switching-to-copperhead-os.md" >}}) about how much I was enjoying CopperheadOS and what had helped me with the transition, I began receiving [canned reply spam](https://twitter.com/anupritaisno1/status/1350497125021278208?s=20) (one of many examples) from new or purchased accounts anytime I mentioned CopperheadOS.

Members of the GrapheneOS community also started creating new Telegram accounts to send the same canned reply and links and then delete their accounts, while also messaging members of the Monero community directly, attempting to undermine my reputation and contributions:

{{< tweet 1362457609077424128 >}}

{{< figure src="/graphene_DMs.png" position="center" style="border-radius: 8px;" >}}

This has happened twice with the latest being to someone directly via IRC as they are not on Twitter at all. I have no idea how they found this person or why they chose them, but thankfully the Monero community can see through attacks like these.

All this to find out today that these attacks are coordinated brigading being pushed from the top down in Matrix and Telegram channels (at least) by member's of the GrapheneOS community:

{{< figure src="/graphene_brigading.jpg" position="center" style="border-radius: 8px;" link="https://twitter.com/_copperj/status/1356303734691819524" >}}

Feel free to read all the brigade replies on the mentioned tweet, and note that this is but one of many such examples:

{{< tweet 1356303734691819524 >}}

This is merely the tip of the iceberg where their coordinated efforts to attack, slander, and brigade any CopperheadOS users or mentions.

# Conclusion

While I would generally be a strong advocate for the open-source version of any tool, and generally technical merit should trump all in what tool to use, I don't think you can just toss away malicious and aggressive behavior of the people almost solely responsible for running and building the FOSS tool.

If there was a fork of Graphene not controlled by Daniel McCay and the others attacking me that would be great, but I cannot inspect the code for myself and verify that there is not anything malicious being done technically, so I need to rely on some level of trust in the person/group controlling the code and project.

I cannot put any trust in Daniel McCay and/or whoever else is attacking me, and thus cannot knowingly recommend a tool that is run by people willing to stoop to such levels to undermine their competition.

GrapheneOS may or may not be an excellent tool, but the communities behavior is anything but a positive indicator of the technical merit and longevity of the project.

# Next steps

If you're using GrapheneOS (or regular Android/iOS) today and want to switch, I can highly recommend reaching out to [@maxtannahill](https://twitter.com/maxtannahill) (or his company [Mamushi](https://mamushi.io/)) to start the switch based on personal experience, and take a look at [my guide]({{< ref "/content/posts/switching-to-copperhead-os.md" >}}) to help the transition.

If you want to use a FOSS alternative and/or don't want to pay for CopperheadOS, [CalyxOS](https://calyxos.org/) is a great alternative that can be a bit easier to transition to due to [support for microG](https://calyxos.org/features/microg/).