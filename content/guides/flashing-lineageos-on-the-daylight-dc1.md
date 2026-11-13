---
title: "Flashing LineageOS on the Daylight DC-1"
date: "2026-08-23T10:15:00-04:00"
author: "Seth For Privacy"
summary: "Bring a modern, monthly-patched Android to the best screen in tech -- a step-by-step guide to flashing the community LineageOS 23.2 build on a stock Daylight DC-1."
draft: false
showToc: true
tags:
- Android
- LineageOS
- Daylight DC-1
- privacy
---

## Introduction

I've been [enamored with the Daylight DC-1]({{< ref "/posts/daylight-dc1-magical-imperfection.md" >}}) since the day I picked it up, and that hasn't changed. What *has* changed is the gap between the hardware and the software running on it -- the stock DC-1 ships an Android 13 base, and Android 13 is a long way behind on security patches at this point.

The good news is that the DC-1 is a MediaTek device with strong chipset support. That makes it a near-perfect GSI target, and there is now a maintained community build for it: an unrooted [LineageOS 23.2 (Android 16) GSI](https://github.com/sethforprivacy/dc1-lineage-gsi) with the DC-1-specific bits (amber frontlight, refresh rate, display geometry, grayscale) baked into the image.

This guide walks through taking a stock DC-1 and getting that build onto it, start to finish, including the one device-specific quirk that will bite you if you follow a generic GSI guide instead.

Note that this guide assumes the following:

- You have a Daylight DC-1 running stock software (`ro.product.device=jagar`) with a locked bootloader
- You have `adb` and `fastboot` on your computer, from the [Android platform-tools](https://developer.android.com/tools/releases/platform-tools)
- You have a USB-C cable that carries data, not just power
- You are comfortable with a terminal, and you accept that this wipes the tablet

{{< notice warning >}}
Unlocking the bootloader on the DC-1 **erases everything on the tablet** -- apps, files, notes, drawings. Back up anything you care about *before* you start, and expect to set the device up from scratch afterwards.
{{< /notice >}}

The upstream documentation for the build lives in the repo, and is worth keeping open in another tab: [flashing docs](https://github.com/sethforprivacy/dc1-lineage-gsi/blob/main/docs/flash.md), [amber frontlight details](https://github.com/sethforprivacy/dc1-lineage-gsi/blob/main/docs/amber.md), and [why LineageOS was chosen](https://github.com/sethforprivacy/dc1-lineage-gsi/blob/main/docs/rom-choice.md).

## What you actually get

A stock GSI on the DC-1 boots, but it boots *wrong* -- no amber light, wrong screen geometry, color settings that make no sense on a monochrome panel. The DC-1 build fixes those in the image itself, so there's nothing to configure after first boot:

- **Amber frontlight without root.** The `Amber` app gives you a cool-to-warm slider that crossfades the white backlight down as amber comes up, savable presets, and a Quick Settings tile. It works from first boot -- no Magisk, no `su`, no adb one-liners.
- **120Hz that actually works,** with proper hardware composition rather than a fallback path.
- **UI inset from the bezel.** The outer 8px of the panel sits under the glass; the build insets the UI so nothing important lands under it. Stock papered over this with a scaled hack.
- **Grayscale-appropriate settings.** The panel is monochrome, so the build stops offering you Colors, Night Light, and the rest of the color-management menus that do nothing here.
- **No phantom camera or telephony.** The stock vendor image wrongly declares both; masking them fixes apps that go looking for a camera, and has the pleasant side effect of making the setup wizard skip its SIM screen entirely.
- **Quieter logs.** The MediaTek wifi driver's log spam is muted and the log buffers are bigger, which matters the first time you have to actually debug something.

And the reason for all of this: LineageOS merges the Android Security Bulletin into its release branches monthly, on schedule, and has done so for years. That's the strongest patch cadence in the Android ecosystem outside of GrapheneOS (which unfortunately won't work on this hardware), and it's a large step up from where stock currently sits.

Worth being clear about what you *don't* get: the build is unrooted, with SELinux enforcing. Kernel and vendor partitions are untouched by a GSI flash, which is exactly why the panel and the amber LED keep working.

## Choose and verify your image

Two variants are published on the [Releases page](https://github.com/sethforprivacy/dc1-lineage-gsi/releases):

- **vanilla** -- no Google apps or services at all
- **gapps** -- [MindTheGapps](https://wiki.lineageos.org/gapps/) merged in, so the Play Store and Play services are there on first boot

Pick one. I'd nudge most people toward vanilla, and plenty of DC-1 owners specifically want the tablet to *not* have Play services on it -- but if you rely on Play-distributed apps, take the gapps image and save yourself the trouble.

{{< notice info >}}
On any non-stock Android build, Play Protect reports the device as "uncertified" -- true of every custom ROM, including official LineageOS. This used to be cosmetic; since mid-2026 Google now blocks app installs and updates on uncertified devices. If you take the gapps image, budget for one extra step after flashing: a ten-minute registration of the device on Google's side, covered in [Play Store certification](#play-store-certification-gapps-image) below. Apps that demand strict hardware-backed Play Integrity (banking, Google Wallet) are a separate, harder story for every custom ROM.
{{< /notice >}}

Whichever you pick, verify it before you flash it. Each release publishes a sha256 alongside the image -- compare, don't skip:

```bash
sha256sum lineage-dc1-*.img
```

## Optional: test the image with DSU first

Before you unlock anything, you can *test-boot* the image from Android with DSU. It runs the GSI from a temporary slot without unlocking the bootloader or touching your installed system, and it's the cheapest possible way to find out that something is broken.

1. Enable Developer options (Settings, then tap Build number seven times) and turn on **USB debugging**
2. Install [DSU Sideloader](https://github.com/VegaBobo/DSU-Sideloader) and grant it the DSU writer permission
3. Point it at the downloaded image, confirm the DSU slot, and reboot
4. Check the things that matter: display, touch, wifi, the Amber tile, refresh rate
5. Reboot back to stock -- the DSU slot is discarded, and your stock install was never touched

If you're happy with what you saw, continue below for the permanent install.

## Prepare the device and back up stock

1. Enable Developer options

    - Settings, then tap Build number seven times

2. In Developer options, enable both **OEM unlocking** and **USB debugging**

    - If OEM unlocking is grayed out, connect to wifi first and try again

3. Confirm your computer can see the tablet

    - Commands:

        ```bash
        adb devices
        ```

4. Get the stock image that matches this guide in hand *before* you unlock

    - A GSI flash replaces the system partition, so make sure you have Daylight's current consumer image and SP Flash Tool downloaded and extracted before you start. See [Flashing back to stock](#flashing-back-to-stock) for the exact files, and for the one download mode you are allowed to use.
    - Do not skip this. It's the difference between "I'll put it back tonight" and "I'll put it back when someone posts an image."

{{< notice info >}}
If your computer has other adb/fastboot devices attached (a phone, an emulator), every command below will either fail or hit the wrong device. Pass `-s <serial>` to each command, or export `ANDROID_SERIAL=<serial>` once for the session. Get the serial from `adb devices` / `fastboot devices`.
{{< /notice >}}

## Unlock the bootloader

{{< notice warning >}}
This step wipes the device. There is no version of this that keeps your data.
{{< /notice >}}

1. Reboot into the bootloader

    - Commands:

        ```bash
        adb reboot bootloader
        ```

2. Unlock, and confirm the prompt on the tablet's screen using the volume and power keys

    - Commands:

        ```bash
        fastboot flashing unlock
        ```

The tablet reboots and wipes itself. From here on it will show an "Orange State" warning at boot -- that's the expected state of an unlocked device, not a problem.

## Flash the GSI

The DC-1 uses dynamic partitions, so the `system` image has to be written from userspace fastboot (fastbootd), not the bootloader.

1. Boot into fastbootd

    - Commands:

        ```bash
        adb reboot bootloader
        fastboot reboot fastboot
        ```

    - You should see "fastbootd" on the tablet's screen. If you land back in the plain bootloader instead, the following flash will fail with a partition-not-found error.

2. Disable Android Verified Boot by flashing an empty vbmeta to both slots

    - An unsigned GSI won't boot with verified boot active, so a vbmeta with no descriptors goes in its place. If the release you downloaded includes a `vbmeta-empty.img`, use it; otherwise generate one with `avbtool` from AOSP's [external/avb](https://android.googlesource.com/platform/external/avb/):

        ```bash
        avbtool make_vbmeta_image --flag 2 --padding_size 4096 --output vbmeta-empty.img
        ```

    - Commands:

        ```bash
        fastboot flash vbmeta_a vbmeta-empty.img --disable-verity --disable-verification
        fastboot flash vbmeta_b vbmeta-empty.img --disable-verity --disable-verification
        ```

3. Flash the system image

    - Decompress the image you downloaded and verified above, then flash it (gapps users: substitute the gapps filename)

    - Commands:

        ```bash
        xz -d lineage-23.2-20260824-dc1-vanilla.img.xz
        fastboot flash system lineage-23.2-20260824-dc1-vanilla.img
        ```

4. Wipe userdata -- **from the bootloader, not from fastbootd**

    - Commands:

        ```bash
        fastboot reboot bootloader
        fastboot -w
        ```

5. Reboot into your new install

    - Commands:

        ```bash
        fastboot reboot
        ```

First boot takes a few minutes -- longer than you'll be comfortable with. Let it sit.

## First boot and setup

The LineageOS setup wizard runs as you'd expect on any tablet, minus the SIM steps (the build doesn't declare telephony, so the wizard skips them on its own). Walk through it normally.

The amber frontlight comes up **on, at full warmth, very early in the boot process** -- that's the intended default, and it means the first thing you see is the warm reading light rather than a blue-white glare.

Once you're at the launcher:

- Open the **Amber** app from the launcher, or long-press the Amber Quick Settings tile, to drive the cool-to-warm slider. As amber rises, the white backlight crossfades down.
- Save the positions you actually use as presets, so you can jump between "outdoors", "desk", and "midnight" without fiddling.
- The normal brightness slider still controls the white backlight independently when you're at the cool end of the range.

That's the whole setup. Everything else is a normal, current Android tablet.

## Play Store certification (gapps image)

If you went with the gapps image, the first thing the Play Store will tell you is *"This device isn't Play Protect certified"*. As of 2026 that stopped being a cosmetic banner: Google now refuses app installs and updates on uncertified devices, which makes the store about as useful as an unlit lamp.

The fix is Google's own, pointed exactly at us: custom ROM users are invited to register the device's Google Services Framework ID (GSF ID) on their [uncertified-device page](https://www.google.com/android/uncertified/). At least one DC-1 owner has already run this end to end and the block lifted; the flow below includes the sharp edges that cost them time.

What you should know before you start:

- Certification attaches to the **installation**, not the hardware. The GSF ID is minted the first time Play services checks in, and it survives every ROM re-flash -- you only ever re-do this after a factory reset, and each Android user profile mints its own.
- There's no ROM-side alternative. Certification requires manufacturer-level compatibility testing plus a GMS license, and official LineageOS hits the same wall. The registration page is Google's sanctioned door for custom-ROM users.

1. Read off the GSF ID

    - Commands:

        ```bash
        adb shell content query --uri content://com.google.android.gsf.gservices --where "name='android_id'" --projection value
        ```

    - On recent Play services builds this can come back empty even though everything is fine -- Google filters the ID out of casual callers, which is also why the "Device ID" apps that used to do this job stopped working on Google Play services 26.x. If the query returns nothing, the [repo doc](https://github.com/sethforprivacy/dc1-lineage-gsi/blob/main/docs/play-certification.md) lists the remaining extraction routes.

2. Register it

    - Open [google.com/android/uncertified](https://www.google.com/android/uncertified/) in any browser, sign in with the **same account that's on the tablet**, paste the ID, solve the captcha, hit Register.

    - Propagation runs from minutes to hours -- one DC-1 install measured about three -- so don't panic-refresh while it "isn't working yet".

3. Flush the state and reboot

    - Commands:

        ```bash
        adb shell pm clear com.android.vending
        adb shell pm clear com.google.android.gms
        ```

    - Safe as written: clearing Play services does **not** mint a new GSF ID, so you won't be registering twice.

4. Verify the honest way

    - The label under Play Store → Settings → About can keep saying "uncertified" long after the block has lifted. Open **Gmail** cold instead: certified, it goes straight to your inbox; not certified, it bounces you through a compliance screen. Then install and update something for real.

{{< notice info >}}
Registration buys Play Store function: installs and updates. It does not buy **Play Integrity** -- the separate, hardware-backed attestation that banking apps and Google Wallet check. On most custom ROMs those apps stay out, though this particular tablet may get lucky: its bootloader reportedly still reports locked and green-status even when unlocked, and at least one DC-1 install stuck certification with no Play-Integrity workarounds at all. Treat any strict app as per-app until you've tried it, and report what you find.
{{< /notice >}}

The full write-up -- extraction fallbacks, the debugging trail, and why this step exists at all -- lives at [docs/play-certification.md](https://github.com/sethforprivacy/dc1-lineage-gsi/blob/main/docs/play-certification.md).

## Troubleshooting

**"android.process.media has stopped working", over and over.** 

You flashed over a kept `/data` (or the wipe didn't take). The old OS left a newer `downloads.db` schema behind and the download provider refuses to downgrade it, so the shared media process crash-loops. No wipe needed to fix it:

```bash
adb shell pm clear com.android.providers.downloads
```

You lose the old download history and the provider rebuilds a compatible database immediately.

**Bootloop, stuck at the Orange State screen.** 

Verified boot is still active. Re-flash the empty vbmeta to both slots with the disable flags, exactly as in the flashing step above, then reboot.

**`fastboot -w` says the wipe task partition isn't found.** 

You're in fastbootd. Run `fastboot reboot bootloader` (or `adb reboot bootloader` if the device is booted) and do the wipe there.

**Commands hit the wrong device or hang.** 

Another adb device is attached; use `-s <serial>` or `ANDROID_SERIAL`.

## Flashing back to stock

Two reasons to go back: an RMA or warranty conversation, or — more likely — Daylight's Android 16 build. **There is no tested way to flash Android 16 straight onto a unit running this GSI.** Daylight's update server recognises units by the build they report, and a tablet that has been on a custom ROM for months simply isn't in their rollout; their tested path is stock Android 13 → `1.0.18` → Android 16, entirely through their own OTA.

That also makes a plain fastboot reflash of your saved `system` and `vbmeta` a dead end for this purpose: it leaves a non-stock boot chain (unlocked bootloader, verity disabled in the GSI's `vbmeta`) and doesn't put the tablet back on Daylight's update server. To genuinely return to stock you need MediaTek's SP Flash Tool.

### What you need

- **An x86_64 Linux machine.** SP Flash Tool ships for Windows and Linux only. There is no macOS build, and a VM with USB passthrough is not a reliable way to talk to a device in BROM mode — the handshake is timing-sensitive and passthrough drops it. I did this from Debian.
- **Daylight's current consumer image** from their [flashing and recovery page](https://daylightco.notion.site/Daylight-Flashing-and-Recovery-Tool-3db0b673e0bf802baa0ac4f79a05575d) — the `*-0.9.9.58.prod.2-signed-image.zip`, about 3 GB.
- **`SP_Flash_Tool_v6.2228_Linux.zip`** from the same page.
- A USB data cable and a charged tablet.

Extract both. The image unpacks to a `*.jagar.user-image/` directory holding `MT6789_Android_scatter.xml`, a ~4.7 GB `super.img`, and a `download_agent/` folder with `flash_signedDA.xml` and `authsv5_jagar.auth`. Keep that folder intact — the flash XML points at the scatter through a relative path.

{{< notice warning >}}
**Use Download Only. Never use Format All.**

SP Flash Tool offers four operations, and the difference between them is the difference between "back to stock" and "back to stock with no serial number". In `MT6789_Android_scatter.xml`, `nvram`, `nvdata`, `proinfo`, `protect1`, `protect2`, `seccfg` and `otp` are all marked `is_download=false`, and the zip contains no images for them. Download Only honours those flags and never touches them. Format All erases the **whole chip** first and then writes the image — and since the image carries no `nvram` payload, there is nothing to write back. Your serial number and radio calibration are gone, and only Daylight can re-provision them. That is one dropdown selection away, and there is no recovery from it.
{{< /notice >}}

### The steps

1. Stop ModemManager and add the tool's udev rule

    - The kernel otherwise hands the preloader port to ModemManager, which breaks the download-agent handshake.

    - Commands:

        ```bash
        sudo systemctl stop ModemManager
        sudo install -m644 99-ttyacms.rules /etc/udev/rules.d/
        sudo udevadm control --reload-rules
        ```

2. Start the flash in console mode, Download Only

    - `-c download` *is* Download Only. The tool also accepts `format`, `format-download` and `firmware-upgrade`; you want none of them. Use the console mode rather than the GUI so the mode can't be misclicked and the run is loggable.

    - Commands:

        ```bash
        cd SP_Flash_Tool_v6.2228_Linux
        sudo ./SPFlashToolV6 \
          -f ../fw/*.jagar.user-image/download_agent/flash_signedDA.xml \
          -a ../fw/*.jagar.user-image/download_agent/authsv5_jagar.auth \
          -c download -t with
        ```

3. Power the tablet fully off, then plug in USB

    - Start the tool *first* and let it scan. The tablet appears as `0e8d:2000 MediaTek MT65xx Preloader` and the tool takes over from there — no key combination. It takes about five minutes and reboots on its own; hold the top-right power button until the Daylight splash if it stays dark.

4. Expect the first boot to land in recovery — tap **Factory data reset**

    - The tablet stops at *"Can't load Android system. Your data may be corrupt"* with **Try again** / **Factory data reset**. "Try again" loops forever.

    - Download Only writes a blank `userdata.img`, but `metadata` is `is_download=false` too, so the GSI's file-based-encryption keys survive. Stock cannot initialise against keys belonging to a different system image. Recovery's factory reset formats `userdata` **and** `metadata` together, which is the pairing the stock build needs.

### What you keep, and what you don't

- **Kept:** the serial number, WiFi/Bluetooth MAC and IMEI-derived state — none of those partitions are ever downloaded.
- **Lost:** `/sdcard` (notes, PDFs, downloads, screenshots), all apps and app data. Coming from a custom ROM there is nothing worth preserving here anyway, so don't try unchecking `userdata` to save it — you'll trade a clean restore for a boot loop you then have to clear.
- **Bootloader:** comes back **locked and green on its own**, with no `fastboot flashing lock` needed. The stock signed `vbmeta`, `vbmeta_system` and `vbmeta_vendor` images replace the verity-disabled ones the GSI required, and the lock state lives in `seccfg`, which Download Only never writes. My unit came back reporting `ro.boot.verifiedbootstate=green`, `ro.boot.vbmeta.device_state=locked`, on fingerprint `Daylight/vext_jagar/jagar:13/TP1A.220624.014/2602101745:user/release-keys`.

### Then hand it to Daylight's updater

1. Plug in the charger

    - Android refuses to apply an OTA on a low battery, and this is a multi-gigabyte install. Mine booted at 12%.

2. Connect Wi-Fi, open **Software Updates**, tap Update

    - That takes you to `1.0.18`, the build carrying their new updater. Give it a few minutes online first — a tablet their server hasn't heard from in months isn't offered the update immediately.

3. Tell Daylight you're on `1.0.18`

    - They move the unit onto Android 16 and it arrives as a normal "Update available" notification.

{{< notice info >}}
The full procedure, with the partition-table evidence behind each warning above, is in [`docs/restore-stock.md`](https://github.com/sethforprivacy/dc1-lineage-gsi/blob/main/docs/restore-stock.md) in the port's repo. [`tools/flash-stock.sh`](https://github.com/sethforprivacy/dc1-lineage-gsi/blob/main/tools/flash-stock.sh) wraps the whole thing, with Download Only hard-coded so it can't be changed by accident — `sudo DC1_STOCK=~/dc1-stock tools/flash-stock.sh`.
{{< /notice >}}

## Conclusion

The DC-1's hardware was always the point, and it deserves an OS that keeps getting security patches. Between the monthly LineageOS cadence and having the amber light, refresh rate, and display geometry handled in the image itself, this is the DC-1 I wanted from the start -- same magical screen, current Android underneath, and no Google services unless I ask for them.

## Feedback, bugs, and getting in touch

This is an early release that has been validated on a small number of units so far, which makes reports from *your* DC-1 genuinely valuable -- successes included.

- **Something broke, or behaves oddly?** [Open an issue](https://github.com/sethforprivacy/dc1-lineage-gsi/issues/new) on the build repo. Include the release version you flashed, what you did, and what happened; if the device is up, `adb logcat -d` output around the problem turns a vague report into a fixable one.
- **It just works?** That's worth an issue or a note too -- "flashed on my unit, no problems" from a handful of people is what moves this from *early* to *recommended*.
- **Want to improve the build?** Pull requests to [dc1-lineage-gsi](https://github.com/sethforprivacy/dc1-lineage-gsi) are very welcome, and `docs/build.md` will get you from zero to a compiled image.

If you have any questions from this post or would like more information on a specific aspect, please reach out via [Signal, SimpleX, X, or Nostr]({{< ref "/about.md#how-to-contact-me" >}}).
