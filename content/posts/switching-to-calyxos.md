+++
title = "Switching to CalyxOS"
date = 2021-03-13T12:30:00-05:00
author = "Seth Simmons"
authorTwitter = "sethisimmons" #do not include @
cover = ""
tags = ["privacy", "CalyxOS", "F-Droid"]
keywords = ["privacy", "CalyxOS", "F-Droid"]
description = "How and why I made the jump to CalyxOS for my mobile operating system."
summary = "How and why I made the jump to CalyxOS for my mobile operating system."
showFullContent = false
toc = true
draft = false
+++

# Introduction

*This post originally recommended CopperheadOS and focused on my experiences with that, but I have since transitioned to CalyxOS and thought that this post would be the best place to share that process as well.*

As the next step in my journey towards reducing my digital footprint and improving my privacy, I wanted to step away from the tracking-centric and monopolized mobile operating systems (OSs) that are most commonly used by people all around the world.

As Android is an open-source operating system at the core with many vendor-specific changes and additions on top, it provides a great base for a privacy-centric OS once stripped of any Google tracking services and applications.

The three main contenders today are [CalyxOS](https://calyxos.org/), [GrapheneOS](https://grapheneos.org), and [CopperheadOS](https://copperhead.co/).

*Note: GrapheneOS and/or CopperheadOS are common recommendations, but due to [many factors]({{< ref "/content/posts/community-drama-and-mobile-os.md" >}}) I can not recommend either one.*

# Why CalyxOS?

All three options above have the same [Android Open Source Project (AOSP)](https://source.android.com/) base and focus heavily on stripping Google services out, while GrapheneOS and CopperheadOS add in a few security optimizations to the base OS to help close off advanced threat vectors. While I appreciate the hyper-secure approach taken by both GrapheneOS and CopperheadOS, these security optimizations add quite a bit of lag and greatly slow down the usage of the OS as a whole.

I spent two months using CopperheadOS as my daily driver and enjoyed the overall experience, but after the many-sided drama and some behind the scenes issues, I decided to flash CalyxOS and make the jump. The main driver for choosing CalyxOS was the overall strength of the organization (Calyx) behind the OS and the balanced approach taken with CalyxOS -- give users options but lean towards preserving good UX when it doesn't conflict with private options.

For a more detailed comparison of the three, see my breakdown of each at ["Comparing CopperheadOS, GrapheneOS, and CalyxOS"]({{< ref "/posts/community-drama-and-mobile-os.md#comparing-copperheados-grapheneos-and-calyxos" >}}).

# How do I install it?

Thankfully, Calyx has made the process very straightforward with a pre-built flashing tool available from their site.

I simply downloaded the appropriate package for the Pixel 4a, downloaded the flashing tool for Linux at https://calyxos.org/get/install/, and followed the instructions the flashing tool put in my terminal.

It took all of ten minutes to flash and setup, and was very straightforward. You can see all the supported devices and downloads at https://calyxos.org/get/.

*Be sure to also check out [BitcoinQ+A's installation guide](bitcoiner.guide/calyxos/) for more details on his thoughts on CalyxOS and how to install it with step by step instructions.*

# What is it like to use?

Using CalyxOS is *very* similar to using the near-stock Android found on Google Pixel devices normally, albeit with the exception of not having default Google Play services and the Google Play Store.

I chose to go with the Google Pixel 4a and so far it's extremely smooth to use, has all the core settings I would normally expect, and has provided me with excellent battery life right out of the box.

One thing to note with CalyxOS -- while the default is no support for Google Play Services, they do allow you to enable [microG](https://calyxos.org/features/microg/) for using Google Play Services in a more private and FOSS way. I personally have chosen to run my phone without microG enabled, but it's a perfectly valid choice and enables a much easier transition as more apps will function properly when it is enabled.

# How do I get apps?

The biggest difference when switching to a privacy-preserving mobile OS like CalyxOS is the distinct lack of any Google service support -- including the Play Store, where all apps are normally distributed through! So how do you get all the apps you need installed?

**Enter [F-Droid](https://f-droid.org/).**

F-Droid is an awesome repository of open-source Android apps and comes pre-installed in CalyxOS. There are a core set of repositories enabled within F-Droid, but you can add your own repositories from companies and services you love to get their app directly through F-Droid.

F-Droid not only allows you to download, install, and update apps, it also performs verification on them each time to make sure some of the most serious Android attack vectors are harder to use against you.

CalyxOS has taken integration with F-Droid a step further and provides a recommended list of apps at initial setup, which makes the transition much easier. I would highly recommend testing out each of the apps they recommend, and hope they will add apps like [Monerujo]({{< relref "#monerujo-for-payments" >}}) in the future.

Two other options exist as well for installing applications, though I would generally recommend avoiding them where possible:

- [Aurora Store](https://auroraoss.com/) is an open-source Google Play Store alternate client, allowing you to (either anonymously via throwaway accounts or via your own Google account) install apps from the Play Store without Google Services installed.
  - Reasons to use it: the ability to access the entire Google Play Store library of applications is powerful, and many applications are simply not available via F-Droid or direct APK installation
  - Reasons to avoid it: many of the apps require Google Play Services to run correctly and are not open-source
- Installing APKs manually allows you to install any APKs that are published for direct download by their creator or on a site like [APKMirror](https://www.apkmirror.com/)
  - Reasons to use it: many applications like Signal are not available on F-Droid yet but still provide a manual APK download
  - Reasons to avoid it: installing APKs downloaded from the internet without validation is risky and exposes you to malware and other dangerous applications. Be sure to always validate the APK comes from the official source whenever possible.

# My recommended apps

A big part of switching over to CalyxOS was to get off of Google services, so many of the apps I had been using before had to be replaced. Hopefully the list below will save you some time when you decide to take this privacy leap as well!

## Aegis for OTP

#### Why I like it

Aegis is an open-source two-factor authentication app, similar to Google Authenticator and Authy in usage. It was very simple to setup, has native encrypted backup support, and came highly recommended to me.

#### Where to get it

https://f-droid.org/en/packages/com.beemdevelopment.aegis/

## AntennaPod for podcasts

#### Why I like it

AntennaPod is a great open-source podcast app that shares a lot of it's UX with Pocket Casts, but is available through F-Droid. I've just started using it, but so far it's an excellent FOSS replacement for Pocket Casts!

#### Where to get it

https://f-droid.org/en/packages/de.danoeh.antennapod/

## Bitwarden for password manager

#### Why I like it

An open-source, encrypted by-default, and highly portable password manager is a powerful tool. I use Bitwarden across all of my devices and thoroughly enjoy the feature-set.

#### Where to get it

For Bitwarden (and some other apps on this list) you will have to install the repo provided by the creator:

https://mobileapp.bitwarden.com/fdroid/

## Element for community interactions

#### Why I like it

Element is the native Matrix client available across platforms, and is something I use daily on both desktop and Android. It isn't without it's quirks but works quite well and is a great way to stay engaged with many communities in the privacy and FOSS ecosystem.

#### Where to get it

https://f-droid.org/en/packages/im.vector.app/

## Fennec for browsing

#### Why I like it

FireFox has quickly become my browser-of-choice for day-to-day browsing, even though I'm slowly working my way to using Tor Browser more and more. Fennec is a distribution with some native FireFox services and telemetry removed, and is the main version available via F-Droid.

#### Where to get it

https://f-droid.org/en/packages/org.mozilla.fennec_fdroid/

#### Alternatives

##### Brave Browser

An alternative I am currently testing is [Brave Browser](https://brave.com), a privacy-preserving version of Google Chrome with some nice added features. The best way to install Brave is via an updater app that is present in F-Droid: 

https://f-droid.org/en/packages/de.marmaro.krt.ffupdater/

## Gcam for pictures and video

#### Why I like it

[Gcam](https://www.celsoazevedo.com/files/android/google-camera/) is a custom built camera app focused on emulating many (if not all) of the core features of the native Google Pixel camera app for devices and OSs that are non-standard. Using Gcam gives practically the same experience and quality of shooting on the official Google Android without needing Google Play Services and without Google's tracking and Photos integration.

#### Where to get it

Gcam is a bit tricky as there are many devs that create many different builds, all of which have some slight differences in supported devices or features. In my usage on my Pixel 4a (and in others in the CalyxOS community's experience on the Pixel 5) the builds by Urnyx05 have been excellent and worked without issue. You can find those builds below:

https://www.celsoazevedo.com/files/android/google-camera/dev-urnyx05/

Note that if you're on a Pixel 5/4a 5G you will need a build that is version 8.1+, so be sure to grab that.

## Infinity for Reddit

#### Why I like it

Infinity is a gorgeous Reddit app with great features, and has been a much better overall experience than I ever had on iOS. Highly recommended.

#### Where to get it

https://f-droid.org/en/packages/ml.docilealligator.infinityforreddit/

## Monerujo for payments

#### Why I like it

[Monerujo](https://www.monerujo.io/) was the first mobile Monero wallet I ever used, and has constantly pushed the boundaries of UX and usability on mobile for Monero. It's a great wallet with simple features to use, an awesome automatic node selection tool, and "Street Mode" for hiding balances from prying eyes.

#### Where to get it

For the latest versions directly via F-Droid, install the repo for Monerujo:

https://f-droid.monerujo.io/fdroid/repo/

## NewPipe for YouTube

#### Why I like it

I consume a lot of content on YouTube, so going without that service was something I was dreading with this switch. Thankfully NewPipe is an incredible tool that allows you to browse, watch, and download YouTube videos without ads, and requires no Google log-in. It even provides native ways to create playlists, import subscriptions directly from YouTube, and keep up to date with your latest channels.

#### Where to get it

For the latest versions and quicker updates, install the NewPipe F-Droid repository here: 

https://newpipe.net/FAQ/tutorials/install-add-fdroid-repo/

It is also available on a slower update schedule from the standard F-Droid repositories here:

https://f-droid.org/en/packages/org.schabi.newpipe/

## Samourai Wallet for Bitcoin payments

#### Why I like it

[Samourai Wallet](https://samouraiwallet.com/) is a privacy-preserving Bitcoin wallet that aims to make it easier for users to mix and spend Bitcoin while not revealing their transaction history or wallet balances to the observer.

#### Where to get it

Install the Samourai repo in F-Droid:

https://samouraiwallet.com/download/fdroid

## Signal for all messaging

#### Why I like it

[Signal](https://signal.org/) is an easy-to-use end-to-end encrypted messaging app, which allows people to easily communicate without revealing data to any intermediaries. While not perfect, it’s a great first step to get people on the journey towards better online privacy, and I use it daily.

#### Where to get it

Signal provides the APK download directly on their site:

https://signal.org/android/apk/

## Standard Notes for encrypted notes

#### Why I like it

[Standard Notes](https://standardnotes.org/) is a great encrypted notes app available across platforms that also accepts Monero for subscriptions. Extensions add a lot of power features including encrypted attachment uploads to your own WebDav server, like Nextcloud.

#### Where to get it

Official APKs are available from Github for the latest versions:

https://github.com/standardnotes/mobile/releases/

If you're OK being a bit behind the most recent release, there is a community-run F-Droid version available as well:

https://f-droid.org/en/packages/com.standardnotes/

## Tor Browser and Orbot

#### Why I like it

[Tor](https://www.torproject.org/) is an anonymity network protocol that helps users avoid ISP and government network surveillance. It is the backbone of many privacy tools, and is a great initiative to help user’s remain anonymous while online.

The Tor browser is the browser I would recommend people use for everyday browsing as it includes many default privacy protections by-default, while also sending all traffic natively over the Tor network.

Orbot allows you to tunnel specific apps through Tor, or even tunnel all of your phones traffic over the Tor network if desired.

#### Where to get it

Tor and Orbot are both available via F-Droid, but in order to access them you will need to enable Guardian Project repo in F-Droid's repository settings.

## Updater for Spotify

#### Why I like it

I normally use YouTube Music, but as part of this switch I wanted to find a new music subscription service that had the ability to function without Google Services. Spotify was highly recommended, and I've been liking it so far.

This particular app allows you to easily download, install, and update Spotify via direct APK downloads, as Spotify does not provide APKs on their site nor are they listed on F-Droid.

#### Where to get it

https://f-droid.org/en/packages/ru.ra66it.updaterforspotify/

## VLC for video

#### Why I like it

VLC is a well-respected and trusted video player, and one I have used for many, many years. Simple controls, solid UI, and distribution via F-Droid make it an easy choice.

#### Where to get it

https://f-droid.org/en/packages/org.videolan.vlc/

#### Alternatives

##### MPV for Android

MPV Android is a great and simple FOSS player available via Github: https://github.com/mpv-android/mpv-android/releases/latest

I have switched to using this instead of VLC while some bugs I have found and reported are fixed, and it's served my needs well.

## Magic Earth for maps and navigation

#### Why I like it

While [Magic Earth](https://www.magicearth.com) is not available on F-Droid and is not open-source, it does have very strong privacy-preserving features and a much better UX than OSMAnd. So far in my experience it is an excellent navigation app and doesn't even require network access once you download the map for your area.

POI searches can still be a bit lackluster, but I've defaulted to finding the place I want to go via DuckDuckGo searches and just copy+pasting the address into Magic Earth.

#### Where to get it

Make sure you have the [Aurora Store](https://auroraoss.com/) installed first, and then simply search in Aurora for "Magic Earth" and install from there.

Future updates will be served via Aurora as well.

#### Alternatives

##### Waze

While Waze is owned by Google, it provides an easy and non-account-based option for modern navigation. I made sure to go into the settings of Waze and enable some of the privacy features and disable data collection, but it's still not an ideal choice.

While Waze is available from the Aurora Store, the latest versions do not work in any of the major de-Googled OSs. In order to use the latest version you have to first download [v4.35.1.0](https://www.apkmirror.com/apk/waze/waze-gps-maps-traffic-alerts-live-navigation/waze-gps-maps-traffic-alerts-live-navigation-4-35-1-0-release/), install it manually, launch the app and let it perform initial setup, and then update through the [Aurora Store](https://auroraoss.com/).

After that future versions update and work properly.

# Conclusion

While the jump to a de-Googled phone may not be the easiest, it's a great further step towards preserving my privacy, reducing my digital footprint, and ensuring I am not reliant on the good-graces of a big tech company like Google for my daily apps.

The experience is surprisingly user-friendly once you get used to how to get apps and migrate over to strong open-source alternatives where possible, and I would highly recommend this for those somewhat tech-savvy users who want to preserve their privacy while on the go.

If you have any questions from this post or would like more information on a specific aspect of my switch to CalyxOS, please reach out via [Twitter, Matrix, or email]({{< ref "/content/about.md#how-to-contact-me" >}}).