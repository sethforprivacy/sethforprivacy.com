---
author: Seth For Privacy
comments: false
date: "2021-08-17T10:00:00-04:00"
summary: It's been a long time coming, but it's finally here. You can, *today*,
  swap Bitcoin <> Monero directly peer-to-peer, over Tor, with no custodian or trusted
  3rd-party, no KYC (Know Your Customer) info, nothing.
draft: false
hidemeta: false
showToc: true
tags:
- Atomic swaps
- Bitcoin
- Monero
title: Performing Bitcoin <> Monero Atomic Swaps
---

# Introduction

It's been a long time coming, but it's finally here. You can, *today*, swap Bitcoin <> Monero directly peer-to-peer, over Tor, with no custodian or trusted 3rd-party, no KYC (Know Your Customer) info, nothing. This guide will walk you through being the XMR buyer, or selling Bitcoin to the Monero provider.

This is the future of cross-chain swaps, and it's possible today.

Atomic swaps open up a wide variety of cross-chain use-cases, but the key thing is that they are trustless, uncensorable, and completely anonymous/pseuodonymous.

For more info on atomic swaps, check out the links below:

- <https://localmonero.co/knowledge/monero-atomic-swaps>
- <https://www.monerooutreach.org/stories/monero-atomic-swaps.html>
- <https://github.com/comit-network/xmr-btc-swap>
- <https://comit.network/blog/2020/10/06/monero-bitcoin/>

# The tools

For this particular atomic swap implementation we'll be using the tools provided and built by the [COMIT network](https://comit.network/), available via the releases section of their Github repository:

<https://github.com/comit-network/xmr-btc-swap/releases>

I (and hopefully others, soon) am running the `asb` tool that provides the Monero-side of the swap, so in order to dive in and buy Monero you'll just need to download the latest version of the `swap` tool provided.

The instructions I provide will assume you are using Linux, but Windows/macOS should be similar.

# Getting the tools

1. Download the latest release of the `swap` tool, i.e. `swap_0.11.0_Linux_x86_64.tar`

    <https://github.com/comit-network/xmr-btc-swap/releases/latest>

2. Extract the swap binary
    Open the Terminal and run the following commands:

    ```bash
    cd ~/Downloads
    tar xvf swap_0.11.0_Linux_x86_64.tar
    ```

3. Verify the binary is working properly

    ```bash
    ./swap --version
    ```

# Making the swap (CLI)

1. List sellers and select one (you can skip this step if you know the peer you'd like to swap with)

    Original testing rendezvous point:

    ```bash
    ./swap list-sellers --rendezvous-point /dnsaddr/rendezvous.coblox.tech/p2p/12D3KooWQUt9DkNZxEn2R5ymJzWj15MpG6mTW84kyd8vDaRZi46o
    ```

    My production rendezvous point:

    ```bash
    ./swap list-sellers --rendezvous-point /dnsaddr/swap.sethforprivacy.com/p2p/12D3KooWCULyZKuV9YEkb6BX8FuwajdvktSzmMg4U5ZX2uYZjHeu
    ```

    Other recommended rendezvous nodes:

    ```bash
    /dns4/rendezvous.xmr.radio/tcp/8888/p2p/12D3KooWN3n2MioS515ek6LoUBNwFKxtG2ribRpFkVwJufSr7ro7
    ```

    This command will list available sellers, their min/max trade amounts, and the current price they are offering

    {{< figure src="/bitcoin-monero-atomic-swaps/list-sellers.png" align="center" style="border-radius: 8px;" >}}

2. Start the swap (my peer is used here, replace with the preferred peer as-needed)

    ```bash
    ./swap buy-xmr --receive-address <YOUR MONERO ADDRESS> --change-address <YOUR BITCOIN CHANGE ADDRESS> --seller <SELLER ADDRESS>
    ```

    ***Don't forget to replace the Monero and Bitcoin address placeholders with your own!***

    {{< figure src="/bitcoin-monero-atomic-swaps/buy-xmr.png" align="center" style="border-radius: 8px;" >}}

3. Deposit Bitcoin to the provided address, making sure you send more than the minimum to cover fees for the swap transactions
4. Watch the process of the swap

    Logs will be displayed showing the steps that are happening, be patient as confirmations are required on both the Bitcoin and Monero side and can take some time

5. Profit

# Making the swap (web UI)

1. Go to <https://unstoppableswap.net/>
2. Select the preferred swap provider
3. Enter the preferred amount of Bitcoin or Monero you'd like to swap within the minimum and maximum set by the swap provider

    {{< figure src="/bitcoin-monero-atomic-swaps/swap_web.png" align="center" style="border-radius: 8px;" >}}

4. Enter the appropriate Monero and Bitcoin addresses you control

    {{< figure src="/bitcoin-monero-atomic-swaps/addresses_web.png" align="center" style="border-radius: 8px;" >}}

5. Follow the instructions to open the terminal

    {{< figure src="/bitcoin-monero-atomic-swaps/instructions_web.png" align="center" style="border-radius: 8px;" >}}

6. Copy and paste the provided command into your terminal and run the command

    {{< figure src="/bitcoin-monero-atomic-swaps/cli_web.png" align="center" style="border-radius: 8px;" >}}

7. Deposit Bitcoin to the provided address, making sure you send more than the minimum to cover fees
8. Watch the process of the swap
    Logs will be displayed showing the steps that are happening, be patient as confirmations are required on both the Bitcoin and Monero side and can take some time

    {{< figure src="/bitcoin-monero-atomic-swaps/cli_swap_web.png" align="center" style="border-radius: 8px;" >}}

9. Profit

    {{< figure src="/bitcoin-monero-atomic-swaps/success_web.png" align="center" style="border-radius: 8px;" >}}

# What to do if the swap fails

It's important to realize that if the swap fails *after you have sent Bitcoin*, you need to ensure that you do the following two steps in a timely manner:

1. Attempt to resume the swap

    ```bash
    ./swap resume --swap-id <SWAP ID>
    ```

2. If the resume fails, wait for 72 confirmations on the Bitcoin deposit transaction
3. Cancel the swap after 72 confirmations on the Bitcoin deposit transaction

    ```bash
    ./swap cancel --swap-id <SWAP ID>
    ```

4. Refund the swap immediately after publishing the cancel transaction, and *before* 72 confirmations on the Bitcoin cancel transaction

    ```bash
    ./swap refund --swap-id <SWAP ID>
    ```

If the steps above do not properly cancel and refund the transaction, and you're sure you waited the required period, please file an [issue in Github](https://github.com/comit-network/xmr-btc-swap/issues) or reach out in Matrix (`#comit-monero:matrix.org`) for help *ASAP*.

For more details on the swap protocol's steps, see <https://comit.network/blog/2020/10/06/monero-bitcoin/#long-story-short>.

***NOTE: If 72 confirmations pass after performing the cancel, the ASB can choose to punish the swap for not properly following through, allowing them to take the Bitcoin as punishment for you failing to properly respond. Be sure to perform the refund step within the 72 confirmation period after initiating the cancel.***

# Things to know

- Price is gathered automatically from Kraken and updates regularly, with an added spread on top of market price set by the ASB runner.
- The Bitcoin change address you provide should be an *unused* address for privacy reasons.
- The Bitcoin change address will be used in the case of a swap failure to return the funds to your own wallet.
- The Monero receive address should be a subaddress per swap peer (or per swap), ideally.
- 2 confirmations on the Bitcoin side and 10 on the Monero side are required, so be patient during the swap process and let the `swap` tool do its thing. If you have to stop it during a swap you can use the `./swap resume` feature, but the ideal thing to do is leave the tool open until the swap is completed.
- For more information on the swap protocol and steps involved, see <https://comit.network/blog/2020/10/06/monero-bitcoin/>.
- If you have issues with the swap, file an [issue in Github](https://github.com/comit-network/xmr-btc-swap/issues) or reach out in Matrix (`#comit-monero:matrix.org`) for help.

# Disclaimer

While this software has worked well for me and is good to go for mainnet, it is of course not foolproof and is still in active development. Swaps should always end in either a complete swap or both parties getting funds back, but be aware that bugs may exist and you're *very* early to atomic swaps in general.

I am not responsible for any lost funds or issues you may have with handling of Bitcoin/Monero involved in the swaps, but will try to help as much as possible if you do run into issues.

# Conclusion

Hopefully this has been a nice simple guide to get you started trustlessly swapping Bitcoin for Monero via atomic swaps! Atomic swaps are an essential tool to removing trust from exchanges and removing the power of potential future regulation, so I'm beyond excited that they are finally possible and work quite well.

If you have specific questions or need some help, please reach out via [Signal, SimpleX, X, or Nostr]({{< ref "/about.md#how-to-contact-me" >}}).
