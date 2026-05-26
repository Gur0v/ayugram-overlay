# ayugram-gentoo

![AyuGram](https://github.com/AyuGram/AyuGramDesktop/raw/dev/.github/AyuGram.png)
![AyuChan](https://github.com/AyuGram/AyuGramDesktop/raw/dev/.github/AyuChan.png) <img src="https://www.gentoo.org/assets/img/logo/gentoo-signet.png" alt="Gentoo" width="128"/>

**Unofficial Gentoo overlay for AyuGram Desktop**

Upstream: [https://github.com/AyuGram/AyuGramDesktop](https://github.com/AyuGram/AyuGramDesktop)

## About this overlay

This overlay provides AyuGram Desktop and a patched WebRTC stack (`media-libs/tg_owt`).

The included `tg_owt` version contains PipeWire/SPA compatibility fixes required on modern systems where upstream WebRTC builds may fail due to API changes.

## Package list

* net-im/ayugram-desktop
* media-libs/tg_owt

## Installation

### 1. Add overlay

```bash
emerge --ask app-eselect/eselect-repository

eselect repository add ayugram https://github.com/Gur0v/ayugram-gentoo.git

emaint sync --repo ayugram
```

### 2. Install dependency

Install the patched WebRTC stack provided by this overlay:

```bash
emerge --ask --verbose --oneshot media-libs/tg_owt
```

This version is required for correct PipeWire/SPA compatibility on modern systems.

### 3. Install AyuGram

#### Stable release (example)

```bash
echo "=net-im/ayugram-desktop-6.7.8 **" >> /etc/portage/package.accept_keywords/ayugram-desktop

emerge --ask --verbose =net-im/ayugram-desktop-6.7.8
```

#### Live version (9999)

```bash
echo "net-im/ayugram-desktop **" >> /etc/portage/package.accept_keywords/ayugram-desktop

emerge --ask --verbose =net-im/ayugram-desktop-9999
```

## Notes

### tg_owt

Upstream WebRTC/tg_owt frequently breaks with newer PipeWire releases due to SPA header changes.
This overlay ships a patched build to maintain compatibility.

Use the overlay-provided `media-libs/tg_owt`. Mixing with system or upstream variants may result in build or runtime issues.

### Compiler

GCC is the most tested configuration.

Clang and ThinLTO builds may fail in some configurations. If issues occur, switch to GCC.

## Legacy versions

* 6.3.10 is included for debugging and historical purposes only.
