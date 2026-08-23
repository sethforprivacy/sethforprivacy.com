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

The good news is that the DC-1 is a MediaTek MSSI device with A/B slots and dynamic partitions, which means the system partition is swappable by design. That makes it a near-perfect GSI target, and there is now a maintained community build for it: an unrooted [LineageOS 23.2 (Android 16) GSI](https://github.com/sethforprivacy/dc1-lineage-gsi) with the DC-1-specific bits (amber frontlight, refresh rate, display geometry, grayscale) baked into the image.

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

And the reason for all of this: LineageOS merges the Android Security Bulletin into its release branches monthly, on schedule, and has done so for years. That's the strongest patch cadence in the Android ecosystem, and it's a large step up from where stock currently sits.

Worth being clear about what you *don't* get: the build is unrooted, with SELinux enforcing. Kernel and vendor partitions are untouched by a GSI flash, which is exactly why the panel and the amber LED keep working.

## Choose and verify your image

Two variants are published on the [Releases page](https://github.com/sethforprivacy/dc1-lineage-gsi/releases):

- **vanilla** -- no Google apps or services at all
- **gapps** -- [MindTheGapps](https://wiki.lineageos.org/gapps/) merged in, so the Play Store and Play services are there on first boot

Pick one. I'd nudge most people toward vanilla, and plenty of DC-1 owners specifically want the tablet to *not* have Play services on it -- but if you rely on Play-distributed apps, take the gapps image and save yourself the trouble.

{{< notice info >}}
On any non-stock Android build, Play Protect reports the device as "uncertified". In practice nearly everything works, including the Play Store itself; the small set of apps that demand strict hardware-backed Play Integrity may refuse to run. This is true of every custom ROM, not something specific to this build.
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

4. Get a copy of stock in hand *before* you unlock

    - A GSI flash replaces the system partition, so returning to stock means writing the stock `system` and `vbmeta` images back. Have them on disk before you start: either an OTA zip / stock assets from the DC-1 community (daylighthacker.wiki), or Daylight's own OTA tooling ([adiktofsugar/daylight](https://github.com/adiktofsugar/daylight)).
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

    - Replace the filename with the image you downloaded and verified above

    - Commands:

        ```bash
        fastboot flash system lineage-dc1-vanilla.img
        ```

4. Wipe userdata -- **from the bootloader, not from fastbootd**

    {{< notice warning >}}
    This is the DC-1's one real gotcha. Running `fastboot -w` in userspace fastbootd fails on this device with `wipe task partition not found`. You have to be in *bootloader* fastboot for the wipe to work, where it formats userdata as f2fs correctly. Skipping the wipe leaves you with a mismatched `/data` and a stack of strange crashes.
    {{< /notice >}}

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

## Troubleshooting

**"android.process.media has stopped working", over and over.** You flashed over a kept `/data` (or the wipe didn't take). The old OS left a newer `downloads.db` schema behind and the download provider refuses to downgrade it, so the shared media process crash-loops. No wipe needed to fix it:

```bash
adb shell pm clear com.android.providers.downloads
```

You lose the old download history and the provider rebuilds a compatible database immediately.

**Bootloop, stuck at the Orange State screen.** Verified boot is still active. Re-flash the empty vbmeta to both slots with the disable flags, exactly as in the flashing step above, then reboot.

**`fastboot -w` says the wipe task partition isn't found.** You're in fastbootd. Run `fastboot reboot bootloader` (or `adb reboot bootloader` if the device is booted) and do the wipe there.

**Commands hit the wrong device or hang.** Another adb device is attached; use `-s <serial>` or `ANDROID_SERIAL`.

## Getting back to stock

Boot into fastbootd and write back the stock `system` and `vbmeta` images you set aside earlier, or re-image the tablet with Daylight's OTA tooling ([adiktofsugar/daylight](https://github.com/adiktofsugar/daylight)). This is the reason for that backup step -- with a stock image in hand it's a short detour, and without one it's a waiting game.

## Conclusion

The DC-1's hardware was always the point, and it deserves an OS that keeps getting security patches. Between the monthly LineageOS cadence and having the amber light, refresh rate, and display geometry handled in the image itself, this is the DC-1 I wanted from the start -- same magical screen, current Android underneath, and no Google services unless I ask for them.

The build is maintained in the open at [github.com/sethforprivacy/dc1-lineage-gsi](https://github.com/sethforprivacy/dc1-lineage-gsi). Issues, test reports from other units, and pull requests are all very welcome -- the more DC-1s this gets exercised on, the better it gets.

If you have any questions from this post or would like more information on a specific aspect, please reach out via [Signal, SimpleX, X, or Nostr]({{< ref "/about.md#how-to-contact-me" >}}).
