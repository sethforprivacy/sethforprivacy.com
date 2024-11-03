---
title: "Privacy-preserving Statistics Using Plausible"
date: 2022-02-23T10:00:10-05:00
aliases: ["/privacy"]
tags: ["plausible", "privacy", "statistics", "self-hosted"]
author: "Seth For Privacy"
description: "In this post I'll dive into the key features of Plausible's self-hosted statistics tool, the key datapoints you should be aware of, and how to disable or block it if desired."
cover:
    image: /privacy-preserving-stats/sethforprivacy_stats.png
---

## Introduction

As this blog and my podcast, [Opt Out](https://optoutpod.com), grow and reach a larger audience, having a way to gauge what topics are of interest to site visitors, what blog posts catch people's attention, and what resources they find the most useful that I link to is becoming a more and more useful tool to enable me to improve the content I create over time.

Traditionally, this is done via invasive tracking scripts and cookies that harvest your data, track you across sites, and attempt to link your visits to the site over time using your IP address or a long-lasting cookie. Thankfully, there are two unique new tools that allow for privacy-preserving, self-hosted statistics collection using a lightweight JavaScript script.

The best two solutions I have found today are [Plausible](https://plausible.io) (what I am not using on sethforprivacy.com and optoutpod.com) and [Umami](https://umami.is/docs/about), as both never log or store visitor IP addresses, do not use cookies *at all*, are GDPR compliant, and can be self-hosted.

In this post I'll dive into the key features of Plausible's self-hosted statistics tool, the key datapoints you should be aware of, and how to disable it if desired.

## Why Plausible

I settled on Plausible as the tool for my site due to two core reasons:

- It does not use cookies at all, does not track across sites, and never logs or stores visitor IP addresses or other PII
- I can self-host it, ensuring data never leaves my host, no visitor data is ever shared externally, and I do not rely on any other entity to preserve the privacy of my site visitors

***For detailed info on all aspects of Plausible, see their [official docs](https://plausible.io/docs).***

Plausible also provides an extremely simple dashboard that keeps things easy to consume, and allows me to easily expose the statistics I can see publicly for transparency. If you'd like to view the statistics I have access to in their entirety, you can see the statistics around both of my sites below:

- [Visitor statistics for sethforprivacy.com](https://stats.sethforprivacy.com/sethforprivacy.com)
    {{< figure src="/privacy-preserving-stats/sethforprivacy_stats.png" align="center" style="border-radius: 8px;" >}}
- [Visitor statistics for optoutpod.com](https://stats.sethforprivacy.com/optoutpod.com)
    {{< figure src="/privacy-preserving-stats/optoutpod_stats.png" align="center" style="border-radius: 8px;" >}}

Exposing the statistics publicly is an important part of the approach so that you, the reader, can see 100% of the information I have access to around visitors to the site.

In addition, Plausible's statistics gathering script is extremely lightweight and simple to deploy. The entire source code for the script can be viewed below and can be compared to the live version at <https://stats.sethforprivacy.com/js/plausible.outbound-links.js> at any time:

{{< collapse summary="plausible.outbound-links.js" >}}

```javascript
! function() {
    "use strict";
    var a = window.location,
        r = window.document,
        t = window.localStorage,
        o = r.currentScript,
        s = o.getAttribute("data-api") || new URL(o.src).origin + "/api/event",
        l = t && t.plausible_ignore;

    function p(t) {
        console.warn("Ignoring Event: " + t)
    }

    function e(t, e) {
        if (/^localhost$|^127(\.[0-9]+){0,2}\.[0-9]+$|^\[::1?\]$/.test(a.hostname) || "file:" === a.protocol) return p("localhost");
        if (!(window._phantom || window.__nightmare || window.navigator.webdriver || window.Cypress)) {
            if ("true" == l) return p("localStorage flag");
            var i = {};
            i.n = t, i.u = a.href, i.d = o.getAttribute("data-domain"), i.r = r.referrer || null, i.w = window.innerWidth, e && e.meta && (i.m = JSON.stringify(e.meta)), e && e.props && (i.p = JSON.stringify(e.props));
            var n = new XMLHttpRequest;
            n.open("POST", s, !0), n.setRequestHeader("Content-Type", "text/plain"), n.send(JSON.stringify(i)), n.onreadystatechange = function() {
                4 == n.readyState && e && e.callback && e.callback()
            }
        }
    }

    function i(t) {
        for (var e = t.target, i = "auxclick" == t.type && 2 == t.which, n = "click" == t.type; e && (void 0 === e.tagName || "a" != e.tagName.toLowerCase() || !e.href);) e = e.parentNode;
        e && e.href && e.host && e.host !== a.host && ((i || n) && plausible("Outbound Link: Click", {
            props: {
                url: e.href
            }
        }), e.target && !e.target.match(/^_(self|parent|top)$/i) || t.ctrlKey || t.metaKey || t.shiftKey || !n || (setTimeout(function() {
            a.href = e.href
        }, 150), t.preventDefault()))
    }
    r.addEventListener("click", i), r.addEventListener("auxclick", i);
    var n = window.plausible && window.plausible.q || [];
    window.plausible = e;
    for (var c, d = 0; d < n.length; d++) e.apply(this, n[d]);

    function u() {
        c !== a.pathname && (c = a.pathname, e("pageview"))
    }
    var w, h = window.history;
    h.pushState && (w = h.pushState, h.pushState = function() {
        w.apply(this, arguments), u()
    }, window.addEventListener("popstate", u)), "prerender" === r.visibilityState ? r.addEventListener("visibilitychange", function() {
        c || "visible" !== r.visibilityState || u()
    }) : u()
}();
```

{{< /collapse >}}

## What data is gathered or provided

***For a more detailed look at the information gathered, see <https://plausible.io/data-policy>, but remember that I am self-hosting Plausible so none of the data is ever sent to Plausible themselves and remains entirely on-device where I host the two sites.***

One of the reasons I opted for something client-side instead of using server-side analytics is to ensure that I never even had access to visitor IP addresses or more sensitive information. Using Plausible (self-hosted) gives me insight into the following data points about visitors:

- Unique visitors, while preserving privacy and never tracking users across days
  - More info here: <https://plausible.io/data-policy#how-we-count-unique-users-without-cookies>
- Aggregate device type (i.e. mobile/laptop/desktop/other), browser type (i.e. Chrome, Firefox, Brave), and user OS (i.e. Windows, Linux, MacOS)
  - Helps me optimize the site more appropriately based on visitor preferences
  - More info here: <https://plausible.io/docs/devices>
- Aggregate visitors per page
  - Helps gauge which pages are the most useful on the site to visitors
  - More info here: <https://plausible.io/docs/top-pages#how-it-works>
- Aggregate visitors per country/continent
  - Gauge potential languages for translation work
  - More info here: <https://plausible.io/docs/countries#how-it-works>
- Aggregate referrals per site
  - Gauge where my content is being shared to better target sharing content myself
  - More info here: <https://plausible.io/docs/top-referrers#how-it-works>
- Aggregate time spent on the site, averaged out against unique user count
  - Helps me understand what posts are most/least engaging
- Aggregate outbound links clicked
  - Helps me better understand what linked resources are most helpful to users to better select resources in the future
  - More info here: <https://plausible.io/docs/outbound-link-click-tracking>

***All available metrics and definitions can be viewed here: <https://plausible.io/docs/metrics-definitions>***

## What data is not gathered or provided

But it's important to note that using Plausible also *does not* give me insight into the more harmful data points to privacy like:

- No activity of users visiting the Tor Onion site (<http://sfprivg7qec6tdle7u6hdepzjibin6fn3ivm6qlwytr235rh5vc6bfqd.onion>)
  - I have disabled the script entirely on the Tor onion site, so no visitors to that will provide statistics, even if they have JavaScript enabled
- Individual visitor IP addresses
  - Addresses are never logged or written to disk, and I have no access to them no matter what
- Exact location
  - The aggregate location data above is achieved via a local geo IP database
- Behavior per user (only aggregate statistics are logged/presented, never individual behaviors)
- Fingerprinting of user extensions or exact window size
- Browsing history across other sites
  - I have no ability (or desire) to track your browsing across sites
- Any activity on other services I host like Nitter, Teddit, etc.

Note that by enabling statistics via Plausible I can keep *all* server logs entirely disabled while still gaining useful info, so no one gaining access illegally (or requesting logs legally) can get insights into specific users or usage of other services I host.

## All statistics gathering is entirely open-source

Another reason why I am willing to do statistics gathering like this is that all visitors have full visibility into the code that the site runs. You can easily browse Github and view the specific code used on the site, and I have linked all relevant files/lines that enable Plausible below:

For sethforprivacy.com (full source at <https://github.com/sethforprivacy/sethforprivacy.com>):

- [head.html, where the JavaScript is loaded](https://github.com/sethforprivacy/sethforprivacy.com/blob/master/layouts/partials/head.html#L163-L165)
- [nginx.conf, where the JavaScript is proxied/provided locally](https://github.com/sethforprivacy/sethforprivacy.com/blob/master/nginx.conf#L88-L114)
- [404.html, where the specific pages that 404 are sent to my Plausible instance](https://github.com/sethforprivacy/sethforprivacy.com/blob/master/layouts/404.html#L2)

For optoutpod.com (full source at <https://github.com/sethforprivacy/optoutpod.com>):

- [head.html, where the JavaScript is loaded](https://github.com/sethforprivacy/optoutpod.com/blob/main/layouts/partials/head.html#L163-L165)
- [nginx.conf, where the JavaScript is proxied/provided locally](https://github.com/sethforprivacy/optoutpod.com/blob/main/nginx.conf#L95-L121)
- [404.html, where the specific pages that 404 are sent to my Plausible instance](https://github.com/sethforprivacy/optoutpod.com/blob/main/layouts/404.html#L2)

The full source for Plausible itself can be found at <https://github.com/plausible/analytics>.

## How to opt out of statistics collection

Simply navigate to the following URL and press the "Exclude my visits" button, once per device/browser:

- [sethforprivacy.com "Exclude my visits" page](https://sethforprivacy.com/plausible-exclusion/)
- [optoutpod.com "Exclude my visits" page](https://optoutpod.com/plausible-exclusion/)

You can also navigate to the same link from any page in the footer, using the "Opt out" link.

For more details on this method, see <https://plausible.io/docs/excluding-localstorage#allow-anyone-on-your-site-to-exclude-themselves>.

## Conclusion

If you have any questions from this post or would like more information on a specific aspect, please reach out via [Signal, SimpleX, X, or Nostr]({{< ref "/about.md#how-to-contact-me" >}}).
