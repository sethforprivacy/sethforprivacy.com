---
title: "Verifying and installing CalyxOS from Linux"
date: "2022-02-01T12:08:53-05:00"
tags: []
author: "Seth For Privacy"
description: "Dive into a more privacy-preserving mobile OS with CalyxOS, and get there using this guide for installing CalyxOS from Linux"
draft: false
---

## Introduction

I recently got a new Pixel and had to go through the process of flashing it again, so I wanted to take the chance to make a companion/alternative guide to the official CalyxOS docs with some videos of the process to help guide you through it.

Note that this guide assumes the following:

- You already have a [supported device](https://calyxos.org/docs/guide/device-support/)
  - Ensure the Pixel you buy *is not* a Verizon phone: [How to identify a Verizon phone](https://calyxos.org/install/verizon/)
- You are running Linux (this guide is specifically done on Pop_OS! 21.10, but should be applicable to most distributions)

If you have any further questions or get stuck following this guide, refer to the official documentation:

- [Install CalyxOS](https://calyxos.org/install/)
- [Verifying CalyxOS builds](https://calyxos.org/install/verify/)

## Download and verify the necessary files

1. Create a new directory to house the files we will need

    - Commands:

        ```bash
        mkdir ~/Downloads/calyxos
        cd ~/Downloads/calyxos
        ```

2. Download the zip and signatures for your specific phone from https://calyxos.org/install/

    - ***Note: The file name "oriole-factory-22301010.zip" may be different for you depending on your phone and the version of CalyxOS you are installing.***

    - Expected directory structure:

        ```bash
        ~/Downloads/calyxos ❯ tree
        .
        ├── device-flasher.linux
        ├── oriole-factory-22301010.zip
        └── oriole-factory-22301010.zip.minisig
        ```

3. Download the necessary signing files from https://calyxos.org/install/verify/

    - Commands:

        ```bash
        wget https://release.calyxinstitute.org/minisign.pub
        wget https://release.calyxinstitute.org/minisign.pub.sig
        ```

    - Expected directory structure:

        ```bash
        ~/Downloads/calyxos took 5s ❯ tree
        .
        ├── device-flasher.linux
        ├── minisign.pub
        ├── minisign.pub.sig
        ├── oriole-factory-22301010.zip
        └── oriole-factory-22301010.zip.minisig
        ```

4. Verify the zip file using GPG and minisign

    - Commands:

        ```bash
        # Compare hash of device-flasher.linux to the digest listed on the install page for your device
        sha256sum device-flasher.linux

        # Import the GPG key used to sign the minisign signatures
        gpg --search-keys "BC2C B9C4 993C 086F FDAD 8D20 5905 C9C7 4693 488B"

        # Verify the minisign signatures
        gpg --verify minisign.pub.sig minisign.pub

        # Download and install minisign
        wget https://github.com/jedisct1/minisign/releases/download/0.10/minisign-0.10-linux.tar.gz
        tar xvf minisign-0.10-linux.tar.gz
        sudo cp minisign-0.10-linux/x86_64/minisign /usr/local/bin
        rm -rf minisign*

        # Replace the file name "oriole-factory-22301010.zip" with your own downloaded file above
        minisign -Vm oriole-factory-22301010.zip -p minisign.pub
        ```

    - Expected output:

        {{< figure src="/installing-calyxos/verification.png" align="center" style="border-radius: 8px;" >}}

## Install CalyxOS

1. Enable developer options

    - This step allows you to toggle OEM unlocking

    {{< video webm="/installing-calyxos/enable-dev-options.webm" preload="false" width="50%" >}}

2. Enable OEM unlocking

    - This step allows you to unlock (and then re-lock) the bootloader of the phone in order to flash CalyxOS
        - ***Note: If this option is grayed out, you may need to connect to WiFi before you can enable OEM unlocking***

    {{< video webm="/installing-calyxos/enable-oem-unlocking.webm" preload="false" width="50%" >}}

3. Allow the device-flasher script to be executed and run it, following all instructions in your terminal

    - Commands:

        ```bash
        chmod +x device-flasher.linux
        ./device-flasher.linux
        ```

    - Expected output (played back at double speed):

        {{< video webm="/installing-calyxos/flashing-calyxos.webm" preload="false" width="100%" >}}

4. Set up your new, de-Googled, privacy-preserving, and data-sovereign phone as you prefer!

## Conclusion

Thankfully, the process above has been made extremely simple by the hard work of the Calyx Institute and CalyxOS team. 

Please consider [donating to the Calyx Institute](https://members.calyxinstitute.org/donate) or [becoming a Calyx Institute member](https://calyxinstitute.org/membership) to help support their work and bring a privacy-preserving mobile OS to more people like you!

If you have any questions from this post or would like more information on a specific aspect, please reach out via [Signal, SimpleX, X, or Nostr]({{< ref "/about.md#how-to-contact-me" >}}).
