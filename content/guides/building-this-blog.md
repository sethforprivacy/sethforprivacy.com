---
author: Seth For Privacy
comments: false
date: "2020-11-30T12:08:53-05:00"
summary: In this post I’ll detail how I spun up my blog specifically and how you
  can do the same easily.
draft: false
hidemeta: false
showToc: true
tags:
- Hugo
- NGINX
- Tor
- Blog
title: Building this blog
---

# Introduction

I figured the second post I made should be about this blog in general, as it has been a long time coming. I've been 
planning this for months, but due to some life events, I've been quite busy and unable to pursue this. Now that I have 
some more free time, I was inspired to finally take the dive and start it up after [SerHack](https://serhack.me) reached
 out asking for some feedback on his own blog.
 
After chatting with him a bit I decided to dive into the tool he had used to build a clean, static, fast blog; a tool 
called [Hugo](https://gohugo.io/about/). Hugo allows you to simply spin up and host a static blog using (primarily) 
MarkDown, a format that is familiar to many who have worked with Github in the past.

In this post I'll detail how I spun up my blog specifically and detail some next steps I have planned as well.

For the entire source code behind this site, see the Github repo below:

<https://github.com/sethforprivacy/sethforprivacy.com>

***NOTE: This blog post is a bit outdated now as I have moved to a full Docker + Traefik setup, but I hope to update it soon.***

# Hosting

For hosting my blog I decided to go with a well known cloud provider, [Linode](https://www.linode.com/?r=c956dbb75d14063251557a0e5003efb5ceacc74d),
 and spin up a basic Debian VM to build on top of. A few of the things that I set up on a new host like this are:
 
- [UFW](https://www.digitalocean.com/community/tutorials/how-to-setup-a-firewall-with-ufw-on-an-ubuntu-and-debian-cloud-server)
 for simple firewall setup
- [Oh My ZSH](https://ohmyz.sh/) for a better terminal experience
- [Zabbix](https://www.zabbix.com/) for operational host monitoring
- [NGINX](https://www.nginx.com/) for a web server
- [Tor](https://www.torproject.org/) for hosting hidden services/SOCKS proxy

Once I had these basics installed, it was time to dive into Hugo and learn my way around it.

# Installing Hugo

While I could have installed Hugo via apt, I decided to compile from the source to get the latest features and improved 
theme support. Hugo made this simple with their clear and detailed docs, so I simply followed [their "Installing"](https://gohugo.io/getting-started/installing) docs.

The first step was [installing Go](https://golang.org/doc/install):

```bash
  mkdir build
  cd ~/build
  wget https://golang.org/dl/go1.15.5.linux-amd64.tar.gz
  sudo tar -C /usr/local -xzf go1.15.5.linux-amd64.tar.gz
  echo "path+=('/usr/local/go/bin')" >> ~/.zshrc
  echo "path+=('/home/user/go/bin')" >> ~/.zshrc
```

Once I had Go installed and working (test with `go version`), it was time to build Hugo from source:

```bash
  cd ~/build
  git clone https://github.com/gohugoio/hugo.git
  cd hugo
  go install --tags extended
```

The build takes a bit depending on resources, but installs the latest Hugo directly to a directory we just added to $PATH.

To update Hugo later on, simply run the following commands:

```bash
  cd ~/build/hugo
  git pull
  go install --tags extended
```

Now it was time to spin up a test site and play around with themes.

# Starting my new Hugo site

Hugo's docs again came in handy here, as they have a great [quick start guide](https://gohugo.io/getting-started/quick-start/)
 that makes it easy to get your test site up and running. Once I had simple site up, I tried out a few themes and 
eventually settled on ["Terminal"](https://github.com/panr/hugo-theme-terminal) by [@panr](https://twitter.com/panr). Not only was the theme very 
minimal and dark by default, but it had a great Monero-like color scheme to choose from.

One of the best features of Hugo is that it is *extremely* simple to test out changes to your site/posts as you go, 
since you can simply run `hugo server -D` to serve a copy locally that auto-refreshes with each change you make.

All it took to start up a new blog post was:

```bash
  hugo new content/posts/comparing-private-spends.md
```

Then I just edited the MarkDown and alt+tabbed to FireFox to check my changes as I went!

# Deploying the site publicly with NGINX

The above is all that is needed to see the site for yourself, but obviously the end goal is to share this with others. To 
do that I chose to deploy NGINX, which is a very simple and easy to use web server that is widely available.

[This post](https://gideonwolfe.com/posts/sysadmin/hugonginx/) by Gideon Wolfe came in handy, and gave me the building 
blocks I needed to customize my NGINX configuration to match the way Hugo works.

## Installing NGINX from their apt repos

To install NGINX I chose to install the latest from their own repositories, as I wanted to be sure to have compatibility 
with the latest security standards. [Their docs](https://www.nginx.com/resources/wiki/start/topics/tutorials/install/#official-debian-ubuntu-packages) 
are a great guide here, and should be all you need to get started.

## Creating a custom server configuration

I like to use [Mozilla's SSL config generator](https://ssl-config.mozilla.org/) as the core of any NGINX configuration to make sure I have the proper security and SSL settings configured, and this 
time was no different. Make sure to customize the certificate placement to match your own, and add in the unique lines 
for your Hugo deployment and hostname to the new site config file (located at `/etc/nginx/conf.d/name-me.conf` for my NGINX version). My unique lines are similar to the below, and are the core of what I had to add to the generated config from Mozilla:

```shell
  server_name sethforprivacy.com;

  root /var/www/sethforprivacy.com/public/; #Absolute path to where your hugo site is
  index index.html; # Hugo generates HTML

  error_page   404  =  /404.html;

  location / {
        try_files $uri $uri/ =404;
  }
```

I navigated to [sethforprivacy.com](https://sethforprivacy.com) and validated that the blog loaded up.

**Note: I had SSL certificates for very cheap with my domain purchase and used those, but for most people getting certs from [LetsEncrypt](https://letsencrypt.org/getting-started/) is a better choice all around. See ["Using Free Let’s Encrypt SSL/TLS Certificates with NGINX"](https://www.nginx.com/blog/using-free-ssltls-certificates-from-lets-encrypt-with-nginx/) for more details on how to setup LetsEncrypt with NGINX.**

## Enabling native Tor support  

I knew from the outset that I wanted to also host my blog as a native Hidden Service on Tor, so I'll go over how I did 
that here. Thankfully, it's very simple with NGINX and only took a few quick configuration edits.

I used [this old but great blog post](https://blog.notmyhostna.me/posts/setting-up-a-tor-hidden-service-with-nginx/) as 
a base to go off of, starting with installing Tor:

```bash
  sudo apt install tor
```

Then I just had to edit the Tor configuration file at `/etc/tor/torrc` and add in the following lines (replace "sethforprivacy.com" with your site name or other preferred name):

```shell
  HiddenServiceDir /var/lib/tor/sethforprivacy.com/
  HiddenServiceVersion 3
  HiddenServicePort 80 127.0.0.1:80
```

Once that was added, I simply restarted tor (`sudo systemctl restart tor`) and cat the file to get the .onion domain (replace "sethforprivacy.com" with what you chose above as the directory name):

```bash
  cat /var/lib/tor/sethforprivacy.com/hostname        
  6idyd6chquyis57aavk3nhqyu3x2xfrqelj4ay5atwrorfcpdqeuifid.onion
```

The next (and last) step was to add a new server block to my NGINX configuration, telling NGINX to serve a copy of the blog 
on localhost so that Tor could share it as a hidden service:

```shell
server {

    listen 127.0.0.1:80;
    server_name 6idyd6chquyis57aavk3nhqyu3x2xfrqelj4ay5atwrorfcpdqeuifid.onion;

    root /var/www/sethforprivacy.com/tor/;
    index index.html;
    error_page 404 = 404.html;
    location / {

    try_files $uri $uri/ =404;

    }

}
```

*Note: To properly serve over Tor you need to set the baseURL to the .onion address while also setting a unique publishDir in a different configuration file for Hugo. You can see my full config.yaml files below.*

{{< collapse summary="clearnet_config.yml" >}}

```yaml
baseURL: 'https://sethforprivacy.com/'
languageCode: en-us
title: sethforprivacy.com
theme: PaperMod

enableRobotsTXT: true
buildDrafts: false
buildFuture: false
buildExpired: false

minify:
  disableXML: true
  minifyOutput: true

params:
  # env: production
  title: sethforprivacy.com
  description: "A simple blog about privacy, Monero, and self-hosting"
  author: sethforprivacy
  DateFormat: "January 2, 2006"
  defaultTheme: dark
  disableThemeToggle: false

  ShowReadingTime: true
  ShowShareButtons: false
  ShowPostNavLinks: true
  ShowBreadCrumbs: true
  ShowCodeCopyButtons: true
  disableSpecial1stPost: false
  disableScrollToTop: false
  comments: false
  hidemeta: false
  hideSummary: false
  showtoc: true
  tocopen: true

  mainSections: posts

  assets:
    disableHLJS: true
    # disableFingerprinting: true

  label:
    text: "Home"
    icon: /favicon.ico
    iconHeight: 35
  
  homeInfoParams:
    Title: "Welcome to Seth For Privacy's blog! \U0001F44B"
    Content: >
      - Take a look at "Posts" for blog posts, "Guides" for guides on self-hosting and Monero, and "Opt Out Podcast" for content related to Opt Out.

      -

      - ***To contact me, use one of the methods below or [an alternative](/about/#how-to-contact-me).***

  socialIcons:
    - name: email
      url: "mailto:seth@sethforprivacy.com"
    - name: twitter
      url: "https://twitter.com/sethforprivacy"
    - name: matrix
      url: "https://matrix.to/#/@sethsimmons:monero.social"
    - name: reddit
      url: "https://www.reddit.com/user/fort3hlulz"
    - name: github
      url: "https://github.com/sethforprivacy"
    - name: monero
      url: "monero:86JzKKyZvtEC98y6zJxCCVfcA3r75XngPBjpYDE6zRR36keNGMHwZomDjMCv1oCYB2j9myiFqEJQF3JtnhKdfX546T91eaY"
    - name: bitcoin
      url: "https://paynym.is/+fallingrecipe6C9"
    - name: rss
      url: "/index.xml"

  cover:
    hidden: true # hide everywhere but not in structured data
    hiddenInList: true # hide on list pages and home
    hiddenInSingle: true # hide on single page

  editPost:
    URL: "https://github.com/sethforprivacy/sethforprivacy.com/blob/master/content"
    Text: "Suggest Changes To This Post" # edit text
    appendFilePath: true # to append file path to Edit link

  # for search
  # https://fusejs.io/api/options.html
  fuseOpts:
    isCaseSensitive: false
    shouldSort: true
    location: 0
    distance: 1000
    threshold: 0.4
    minMatchCharLength: 0
    keys: ["title", "permalink", "summary", "content"]

outputs:
    home:
        - HTML
        - RSS
        - JSON # is necessary

menu:
  main:
    - identifier: posts
      name: Posts
      url: /posts
      weight: 1
    - identifier: guides
      name: Guides
      url: /guides
      weight: 2
    - identifier: podcast
      name: Opt Out Podcast
      url: "https://dev.optoutpod.com"
      weight: 3
    - identifier: about
      name: About
      url: /about
      weight: 4
    - identifier: search
      name: Search
      url: /search
      weight: 5

privacy:
  disqus:
    disable: true
  googleAnalytics:
    anonymizeIP: false
    disable: true
    respectDoNotTrack: false
    useSessionStorage: false
  instagram:
    disable: true
    simple: false
  twitter:
    disable: false
    enableDNT: false
    simple: true
  vimeo:
    disable: true
    enableDNT: false
    simple: false
  youtube:
    disable: true
    privacyEnhanced: false
markup:
  tableOfContents:
    endLevel: 2
    ordered: false
    startLevel: 1
  goldmark:
    renderer:
      unsafe: true
  highlight:
    # anchorLineNos: true
    codeFences: true
    guessSyntax: true
    lineNos: false
    # noClasses: false
    style: solarized-dark

```

{{< /collapse >}}
{{< collapse summary="tor_config.yml" >}}

```yaml
baseURL: 'http://sfprivg7qec6tdle7u6hdepzjibin6fn3ivm6qlwytr235rh5vc6bfqd.onion/'
publishDir: tor
languageCode: en-us
title: sethforprivacy.com
theme: PaperMod

enableRobotsTXT: true
buildDrafts: false
buildFuture: false
buildExpired: false

minify:
  disableXML: true
  minifyOutput: true

params:
  env: production
  title: sethforprivacy.com
  description: "A simple blog about privacy, Monero, and self-hosting"
  author: sethforprivacy
  DateFormat: "January 2, 2006"
  defaultTheme: dark
  disableThemeToggle: false

  ShowReadingTime: true
  ShowShareButtons: false
  ShowPostNavLinks: true
  ShowBreadCrumbs: true
  ShowCodeCopyButtons: true
  disableSpecial1stPost: false
  disableScrollToTop: false
  comments: false
  hidemeta: false
  hideSummary: false
  showtoc: true
  tocopen: true

  mainSections: posts

  assets:
    disableHLJS: true
    # disableFingerprinting: true

  label:
    text: "Home"
    icon: /favicon.ico
    iconHeight: 35
  
  homeInfoParams:
    Title: "Welcome to Seth For Privacy's blog! \U0001F44B"
    Content: >
      - Take a look at "Posts" for blog posts, "Guides" for guides on self-hosting and Monero, and "Opt Out Podcast" for content related to Opt Out.

      -

      - ***To contact me, use one of the methods below or [an alternative](/about/#how-to-contact-me).***

  socialIcons:
    - name: email
      url: "mailto:seth@sethforprivacy.com"
    - name: twitter
      url: "https://twitter.com/sethforprivacy"
    - name: matrix
      url: "https://matrix.to/#/@sethsimmons:monero.social"
    - name: reddit
      url: "https://www.reddit.com/user/fort3hlulz"
    - name: github
      url: "https://github.com/sethforprivacy"
    - name: monero
      url: "monero:86JzKKyZvtEC98y6zJxCCVfcA3r75XngPBjpYDE6zRR36keNGMHwZomDjMCv1oCYB2j9myiFqEJQF3JtnhKdfX546T91eaY"
    - name: bitcoin
      url: "https://paynym.is/+fallingrecipe6C9"
    - name: rss
      url: "/index.xml"

  cover:
    hidden: true # hide everywhere but not in structured data
    hiddenInList: true # hide on list pages and home
    hiddenInSingle: true # hide on single page

  editPost:
    URL: "https://github.com/sethforprivacy/sethforprivacy.com/blob/master/content"
    Text: "Suggest Changes To This Post" # edit text
    appendFilePath: true # to append file path to Edit link

  # for search
  # https://fusejs.io/api/options.html
  fuseOpts:
    isCaseSensitive: false
    shouldSort: true
    location: 0
    distance: 1000
    threshold: 0.4
    minMatchCharLength: 0
    keys: ["title", "permalink", "summary", "content"]

outputs:
    home:
        - HTML
        - RSS
        - JSON # is necessary

menu:
  main:
    - identifier: posts
      name: Posts
      url: /posts
      weight: 1
    - identifier: guides
      name: Guides
      url: /guides
      weight: 2
    - identifier: podcast
      name: Opt Out Podcast
      url: "http://optoutkoplzfgs7wl3gkg5nmtrrs7ki6ljcguf7c4w7rdsrtozlghxad.onion"
      weight: 3
    - identifier: about
      name: About
      url: /about
      weight: 4
    - identifier: search
      name: Search
      url: /search
      weight: 5

privacy:
  disqus:
    disable: true
  googleAnalytics:
    anonymizeIP: false
    disable: true
    respectDoNotTrack: false
    useSessionStorage: false
  instagram:
    disable: true
    simple: false
  twitter:
    disable: false
    enableDNT: false
    simple: true
  vimeo:
    disable: true
    enableDNT: false
    simple: false
  youtube:
    disable: true
    privacyEnhanced: false
markup:
  tableOfContents:
    endLevel: 2
    ordered: false
    startLevel: 1
  goldmark:
    renderer:
      unsafe: true
  highlight:
    # anchorLineNos: true
    codeFences: true
    guessSyntax: true
    lineNos: false
    # noClasses: false
    style: solarized-dark

```

{{< /collapse >}}

A simple `nginx -t` to verify the configuration was valid, a restart of NGINX via `sudo systemctl restart nginx`, and I 
was up and running on both clearnet and Tor!

I also added in the [appropriate header](https://community.torproject.org/onion-services/advanced/onion-location/) to 
prompt Tor users who navigate to the clearnet site to use the native Tor site instead. Simply add a similar line to the
 below to your NGINX configuration file, under the same server block as your clearnet HTTPS server:

```shell
  add_header Onion-Location http://6idyd6chquyis57aavk3nhqyu3x2xfrqelj4ay5atwrorfcpdqeuifid.onion$request_uri;
```

My full NGINX configuration file is below:

{{< collapse summary="nginx.conf" >}}

```conf
# generated 2020-11-29, Mozilla Guideline v5.6, nginx 1.18, OpenSSL 1.1.1d, intermediate configuration, no OCSP
# https://ssl-config.mozilla.org/#server=nginx&version=1.18&config=intermediate&openssl=1.1.1d&ocsp=false&guideline=5.6

# Setup client-side caching
map $sent_http_content_type $expires {
    default                    off;
    text/html                  epoch;
    text/css                   max;
    application/javascript     max;
    ~image/                    max;
}

server {
# Server block to redirect any non-HTTPS queries to HTTPS

    listen 80 default_server;
    listen [::]:80 default_server;

    if ($request_method !~ ^(GET|HEAD|POST)$ ) {
        return 444;
    }

    return 301 https://$host$request_uri;
}

server {
# Server block for serving sethforprivacy.com as a Tor Hidden Service

    listen 127.0.0.1:80;
    server_name 6idyd6chquyis57aavk3nhqyu3x2xfrqelj4ay5atwrorfcpdqeuifid.onion;

    if ($request_method !~ ^(GET|HEAD|POST)$ ) {
        return 444;
    }
   
    # Enable compression for all types of files 
    gzip_static  always;
    gzip_proxied expired no-cache no-store private auth;
    gunzip       on;

    # Enable client-side caching
    expires $expires;

    root /var/www/sethforprivacy.com/tor/;
    index index.html;
    error_page 404 = /404.html;

    # Block site from being framed with X-Frame-Options and CSP
    add_header Content-Security-Policy "frame-ancestors 'none'; default-src 'none'; img-src 'self'; script-src 'self'; style-src 'self'; form-action 'none'; base-uri 'none'";
    add_header X-Frame-Options "DENY";

    # Security headers
    add_header X-Content-Type-Options "nosniff";
    add_header X-XSS-Protection "1; mode=block";

    # Privacy headers
    add_header Referrer-Policy "no-referrer";
    add_header Permissions-Policy "accelerometer=(), camera=(), geolocation=(), gyroscope=(), magnetometer=(), microphone=(), speaker=(), usb=(), vibrate=(), sync-xhr=()";

    location / {

    try_files $uri $uri/ =404;

    }

}

server {
# Server block for monitoring NGINX status via Zabbix

    listen 127.0.0.1:8080;
    location /basic_status {
        stub_status;
        allow 127.0.0.1;        #only allow requests from localhost
        deny all;               #deny all other hosts
    }

}

server {
# Server block for serving sethforprivacy.com as an HTTPS site

    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name sethforprivacy.com;

    if ($request_method !~ ^(GET|HEAD|POST)$ ) {
        return 444;
    }

    # Enable compression for all types of files
    gzip_static  always;
    gzip_proxied expired no-cache no-store private auth;
    gunzip       on;

    # Enable client-side caching
    expires $expires;

    root /var/www/sethforprivacy.com/public/; #Absolute path to where your hugo site is
    index index.html; # Hugo generates HTML

    ssl_certificate /etc/nginx/ssl/sethforprivacy.com.crt;
    ssl_certificate_key /etc/nginx/ssl/sethforprivacy.com.key;
    ssl_session_timeout 1d;
    ssl_session_cache shared:MozSSL:10m;  # about 40000 sessions
    ssl_session_tickets off;

    # curl https://ssl-config.mozilla.org/ffdhe2048.txt > /path/to/dhparam
    ssl_dhparam /etc/nginx/ssl/dhparam;

    # intermediate configuration
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384;
    ssl_prefer_server_ciphers off;

    # HSTS (ngx_http_headers_module is required) (63072000 seconds)
    add_header Strict-Transport-Security "max-age=63072000" always;
    add_header Onion-Location http://6idyd6chquyis57aavk3nhqyu3x2xfrqelj4ay5atwrorfcpdqeuifid.onion$request_uri;

    # Block site from being framed with X-Frame-Options and CSP
    add_header Content-Security-Policy "frame-ancestors 'none'; default-src 'none'; img-src 'self'; script-src 'self'; style-src 'self'; form-action 'none'; base-uri 'none'";
    add_header X-Frame-Options "DENY";

    # Security headers
    add_header X-Content-Type-Options "nosniff";
    add_header X-XSS-Protection "1; mode=block";

    # Privacy headers
    add_header Referrer-Policy "no-referrer";
    add_header Permissions-Policy "accelerometer=(), camera=(), geolocation=(), gyroscope=(), magnetometer=(), microphone=(), speaker=(), usb=(), vibrate=(), sync-xhr=()";

    error_page   404  =  404.html;

    location / {
            try_files $uri $uri/ =404;
    }
}
```

{{< /collapse >}}

# Writing workflow  

A quick note on my workflow, as this was one of the primary drivers to choosing Hugo in the first place. Hugo enables 
very quick and easy testing of changes via the native `localhost` server, and is easy to deploy with Github.

## Adding a new blog post  

Whenever I want to add a new blog post, I simply open up the directory where I keep my Github repo and do the following:

```bash
  git pull
  hugo new content/posts/post-name.md
  hugo server -D
```

That creates the new post and starts a local server that displays draft pages (which all posts start out as). As I go, 
the changes are automatically refreshed in my local browser, so it's easy to make sure formatting is what I want before I 
publish them.

Once I'm done with the post, I simply edit the top of it to `draft=false`, push the changes to Github, and then pull the 
latest changes on my web server with the following script:

```bash
cd /var/www/sethforprivacy.com/

# Pull the latest changes from Github
git pull

# Build the clearnet static site
hugo --config clearnet_config.toml

# Build the Tor static site
hugo --config tor_config.toml

# Compress the clearnet static site
cd /var/www/sethforprivacy.com/public
for file in $(find . -type f)
do
    zopfli "$file"
    rm "$file"
    touch -r "$file".gz "$file"
done

# Compress the Tor static site
cd /var/www/sethforprivacy.com/tor
for file in $(find . -type f)
do
    zopfli "$file"
    rm "$file"
    touch -r "$file".gz "$file"
done
cd ~
```

All it takes are those three commands and my latest changes are live in seconds! It's simple to work on the blog from any device, push the 
changes to Github, and then deploy in seconds.

# Helpful Hugo Pages

Here are a few Hugo pages I found useful as I was customizing my site, and they may be interesting to you as well:

- [Privacy settings](https://gohugo.io/about/hugo-and-gdpr/)
  - Allows disabling excess features and using simple/no-JS versions of embedding etc.
- [Tweet shortcodes](https://gohugo.io/content-management/shortcodes/#tweet)
  - Highlights Tweets cleanly within posts when used
- [All shortcodes](https://gohugo.io/content-management/shortcodes/)
  - Useful ways to highlight or embed
- [Using git info for page metadata](https://gohugo.io/variables/git/)
  - Uses git info to set last update date among other data
- [Page variables](https://gohugo.io/variables/page/)
  - I used info from this page to set data like keywords, tags, and description (for a selected short description used on the homepage instead of the "first 70 word" default)

# Next Steps  

The biggest new features I'd like to add to my site are:

- Automatic deployments whenever a new commit is pushed to my repo
- Simple search

Thanks for reading, and please don't hesitate to reach out via [Signal, Matrix, Threema, or email]({{< ref "/content/about.md#how-to-contact-me" >}}) if you have any questions or would like more detail!
