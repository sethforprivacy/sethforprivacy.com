---
title: "Installing CalyxOS"
date: "2022-02-01T12:08:53-05:00"
tags: []
author: "Seth For Privacy"
description: ""
draft: true
---

# Introduction

## Download the necessary files

1. Download the packages for your specific phone from https://calyxos.org/install/

    Expected directory structure:

    ```bash
    ~/Downloads/calyxos took 5s ❯ tree
    .
    ├── device-flasher.linux
    ├── minisign.pub
    ├── minisign.pub.sig
    ├── oriole-factory-22301010.zip
    └── oriole-factory-22301010.zip.minisig
    ```

2. Verify the zip file using GPG and minisign by following https://calyxos.org/install/verify/

    Commands:

    ```bash
    gpg --search-keys "BC2C B9C4 993C 086F FDAD 8D20 5905 C9C7 4693 488B"
    gpg --verify minisign.pub.sig minisign.pub
    minisign -Vm oriole-factory-22301010.zip -p minisign.pub
    ```

    Expected output:

    {{< figure src="/installing-calyx-os/verification.png" align="center" style="border-radius: 8px;" >}}

3. Enable developer options

4. Enable OEM unlocking

5. Allow the device-flasher script to be run and run it

    Commands:

    ```bash
    chmod +x device-flasher.linux\n
    adb devices
    ./device-flasher.linux
    ```

    Expected output:

    {{< figure src="/installing-calyx-os/flashing.png" align="center" style="border-radius: 8px;" >}}

# Conclusion

If you have any questions from this post or would like more information on a specific aspect of the post, please reach out via [Twitter, Matrix, Threema, or email]({{< ref "/content/about.md#how-to-contact-me" >}}).
