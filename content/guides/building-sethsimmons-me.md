+++
title = "Building sethsimmons.me"
date = 2020-11-30T12:08:53-05:00
author = "Seth Simmons"
authorTwitter = "sethisimmons" #do not include @
cover = ""
tags = ["Hugo", "NGINX", "Tor", "Blog"]
keywords = ["Hugo", "Markdown", "NGINX", "Tor", "blog"]
description = "In this post I’ll detail how I spun up my blog specifically and how you can do the same easily."
summary = "In this post I’ll detail how I spun up my blog specifically and how you can do the same easily."
showFullContent = false
toc = true
draft = false
+++

# Introduction  
I figured the second post I made should be about this blog in general, as it has been a long time coming. I've been 
planning this for months, but due to some life events, I've been quite busy and unable to pursue this. Now that I have 
some more free time, I was inspired to finally take the dive and start it up after [SerHack](https://serhack.me) reached
 out asking for some feedback on his own blog.
 
After chatting with him a bit I decided to dive into the tool he had used to build a clean, static, fast blog; a tool 
called [Hugo](https://gohugo.io/about/). Hugo allows you to simply spin up and host a static blog using (primarily) 
MarkDown, a format that is familiar to many who have worked with Github in the past.

In this post I'll detail how I spun up my blog specifically and detail some next steps I have planned as well.

Let's dive in.

# Hosting  

For hosting my blog I decided to go with a well known cloud provider, [Linode](https://www.linode.com/?r=c956dbb75d14063251557a0e5003efb5ceacc74d),
 and spin up a basic Debian VM to build on top of. The basic things that I set up on a new host like this are:
 
- [UFW](https://www.digitalocean.com/community/tutorials/how-to-setup-a-firewall-with-ufw-on-an-ubuntu-and-debian-cloud-server)
 for simple firewall setup
- [Oh My ZSH](https://ohmyz.sh/) for a better terminal experience
- [Zabbix](https://www.zabbix.com/) for operational host monitoring
- [NGINX](https://www.nginx.com/) for a web server
- [Tor](https://www.torproject.org/) for hosting hidden services/SOCKS proxy

Once I had these basics installed, it was time to dive into Hugo and learn my way around it.

# Installing Hugo  

While I could have installed Hugo via apt, I decided to compile from the source to get the latest features and improved 
theme support. Hugo made this simple with their clear and detailed docs, so I simply followed [their "Installing"](https://gohugo.io/getting-started/installing)
 docs.
 
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

The build takes a bit depending on resources, but installs the latest Hugo directly to a directory we just added to 
$PATH.

Now it was time to spin up a test site and play around with themes.

# Starting my new Hugo site  

Hugo's docs again came in handy here, as they have a great [quick start guide](https://gohugo.io/getting-started/quick-start/)
 that makes it easy to get your test site up and running. Once I had simple site up, I tried out a few themes and 
eventually settled on ["Terminal"](https://github.com/panr/hugo-theme-terminal) by panr. Not only was the theme very 
minimal and dark by-default, but it had a great Monero-like color scheme to choose from!

One of the best features of Hugo is that it is *extremely* simple to test out changes to your site/posts as you go, 
since you can simple run `hugo server -D` to host a copy locally that auto-refreshes with each change you make.

All it took to start up a new blog post was:

```bash
  hugo new content/posts/comparing-private-spends.md
```

Then I just edited the MarkDown and alt+tabbed to FireFox to check my changes as I went!

# Deploying the site publicly with NGINX  

The above is all thats needed to see the site for yourself, but obviously the end goal is to share this with others. To 
do that I chose to deploy NGINX, which is a very simple and easy to use web server that is widely available.

[This post](https://gideonwolfe.com/posts/sysadmin/hugonginx/) by Gideon Wolfe came in handy, and gave me the building 
blocks I needed to customize my NGINX configuration to match the way Hugo works.

## Installing NGINX from their apt repos  

To install NGINX I chose to install the latest from their own repositories, as I wanted to be sure to have compatibility 
with the latest security standards. [Their docs](https://www.nginx.com/resources/wiki/start/topics/tutorials/install/#official-debian-ubuntu-packages) 
are a great guide here, and should be all you need to get started.

## Creating a custom server configuration

I use [Mozilla's SSL config generator](https://ssl-config.mozilla.org/) as the core of any NGINX configuration, and this 
time was no different. Make sure to customize the certificate[^1] placement to match your own, and add in the unique lines 
for your Hugo deployment and hostname to the new site config file (located at `/etc/nginx/conf.d/name-me.conf` for my NGINX version). My unique lines are similar to the below, and are the core of what I had to add to the generated config from Mozilla:

```shell
  server_name sethsimmons.me;

  root /var/www/sethsimmons.me/public/; #Absolute path to where your hugo site is
  index index.html; # Hugo generates HTML

  error_page   404  =  /404.html;

  location / {
        try_files $uri $uri/ =404;
  }
```

I navigated to [sethsimmons.me](https://sethsimmons.me) and validated that the blog loaded up, and we were off to the 
races!

[^1]: I had SSL certificates for very cheap with my domain purchase and used those, but for most people getting certs 
from [LetsEncrypt](https://letsencrypt.org/getting-started/) is a better choice all around.

## Enabling native Tor support  

I knew from the outset that I wanted to also host my blog as a native Hidden Service on Tor, so I'll go over how I did 
that here. Thankfully, it's very simple with NGINX and only took a few quick configuration edits.

I used [this old but great blog post](https://blog.notmyhostna.me/posts/setting-up-a-tor-hidden-service-with-nginx/) as 
a base to go off of, starting with installing Tor:

```bash
  sudo apt install tor
```

Then I just had to edit the Tor configuration file at `/etc/tor/torrc` and add in the following lines:

```shell
  HiddenServiceDir /var/lib/tor/sethsimmons.me/
  HiddenServiceVersion 3
  HiddenServicePort 80 127.0.0.1:80
```

Once that was added, I simply restarted tor (`sudo systemctl restart tor`) and cat'd the file to get the .onion domain:

```bash
  cat /var/lib/tor/sethsimmons.me/hostname        
  6idyd6chquyis57aavk3nhqyu3x2xfrqelj4ay5atwrorfcpdqeuifid.onion
```

Next (and last) step was to add a new server block to my NGINX configuration, telling NGINX to serve a copy of the blog 
on localhost so that Tor could share it as a hidden service:

```shell
server {

    listen 127.0.0.1:80;
    server_name 6idyd6chquyis57aavk3nhqyu3x2xfrqelj4ay5atwrorfcpdqeuifid.onion;

    root /var/www/sethsimmons.me/public/;
    index index.html;
    error_page 404 = 404.html;
    location / {

    try_files $uri $uri/ =404;

    }

}
```

A simple `nginx -t` to verify the configuration was valid, a restart of NGINX via `sudo systemctl restart nginx`, and I 
was up and running on both clearnet and Tor!

I also added in the [appropriate header](https://community.torproject.org/onion-services/advanced/onion-location/) to 
prompt Tor users who navigate to the clearnet site to use the native Tor site instead. Simply add a similar line to the
 below to your NGINX configuration file, under the same server block as your clearnet HTTPS server:

```shell
  add_header Onion-Location http://6idyd6chquyis57aavk3nhqyu3x2xfrqelj4ay5atwrorfcpdqeuifid.onion$request_uri;
```

# Writing workflow  

A quick note on my workflow, as this was one of the primary drivers to choosing Hugo in the first place. Hugo enables 
very quick and easy testing of changes via the native `localhost` server, and is easy to deploy with Github.

## Adding a new blog post  

Whenever I want to add a new blog post, I simply do the following:

```bash
  hugo new content/posts/post-name.md
  hugo server -D
```

That creates the new post and starts a local server that displays draft pages (which all post start out as). As I go 
the changes are automatically refreshed in my local browser so it's easy to make sure formatting is what I want before I 
publish them.

Once I'm done with the post, I simple edit the top of it to `draft=false`, push the changes to Github, and then pull the 
latest changes on my web server:

```bash
  cd /var/www/sethsimmons.me/
  git pull
  hugo
```

Those three commands and my latest changes are live in seconds! It's simple to work on the blog from any device, push the 
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

# Sourcecode

The up-to-date sourcecode for all of the Hugo configurations and posts on [sethsimmons.me](https://sethsimmons.me) can be found at [sethsimmons/sethsimmons.me](https://github.com/sethsimmons/sethsimmons.me).

# Next Steps  

The biggest new features I'd like to add to my site are:

- Automatic deployments whenever a new commit is pushed to my repo
- Simple subscriptions so user's can be notified of new posts automatically
- Simple search

Thanks for reading, and please don't hesitate to reach out if you have any questions or would like more detail!
