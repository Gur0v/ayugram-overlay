# ayugram-gentoo

![AyuGram](https://github.com/AyuGram/AyuGramDesktop/raw/dev/.github/AyuGram.png)
![AyuChan](https://github.com/AyuGram/AyuGramDesktop/raw/dev/.github/AyuChan.png) <img src="https://www.gentoo.org/assets/img/logo/gentoo-signet.png" alt="Gentoo" width="128"/>

**Unofficial AyuGram Desktop overlay for Gentoo Linux**

→ Upstream: [https://github.com/AyuGram/AyuGramDesktop](https://github.com/AyuGram/AyuGramDesktop)

## Repository Structure

This overlay provides the following packages:

* **net-im/ayugram-desktop**: Core AyuGram desktop client
* **media-libs/tg_owt**: Custom-patched fork of WebRTC used by Telegram/AyuGram for calling and media

### Why a custom `tg_owt`?

The official WebRTC/tg_owt sources frequently fail to compile against newer PipeWire versions due to breaking SPA header changes.

This overlay includes:

`tg_owt-0_pre20250515-pipewire-spa-compat.patch`

to maintain compatibility with modern system libraries while upstream fixes are still in progress.

## Installation

### 1. Enable the repository

First ensure `eselect-repository` is installed, then add and sync the overlay:

```bash
emerge --ask app-eselect/eselect-repository

eselect repository add ayugram https://github.com/Gur0v/ayugram-gentoo.git

emaint sync --repo ayugram
```

### 2. Unmask and install

Because these ebuilds do not define stable keywords, you must explicitly accept them in Portage.

> ⚠️ **Important dependency step**
>
> To avoid dependency conflicts with the main Gentoo tree, you must install (`--oneshot`) the custom `media-libs/tg_owt` from this overlay before installing AyuGram 6.7+ or the live version.

### Option A: Install a specific release (e.g. 6.7.8)

Add package keywords:

```bash
echo "=net-im/ayugram-desktop-6.7.8 **" >> /etc/portage/package.accept_keywords/ayugram-desktop
echo "media-libs/tg_owt ~amd64" >> /etc/portage/package.accept_keywords/ayugram-desktop
```

Install dependency first:

```bash
emerge --ask --verbose --oneshot media-libs/tg_owt
```

Install AyuGram:

```bash
emerge --ask --verbose =net-im/ayugram-desktop-6.7.8
```

*(Adjust `~amd64` for your architecture if needed.)*

### Option B: Install live branch (9999)

Enable live build:

```bash
echo "net-im/ayugram-desktop **" >> /etc/portage/package.accept_keywords/ayugram-desktop
echo "media-libs/tg_owt ~amd64" >> /etc/portage/package.accept_keywords/ayugram-desktop
```

Install dependency first:

```bash
emerge --ask --verbose --oneshot media-libs/tg_owt
```

Install AyuGram:

```bash
emerge --ask --verbose =net-im/ayugram-desktop-9999
```

### Note on version 6.3.10

The `6.3.10` ebuild is kept only for legacy and debugging purposes. It is not intended for daily use.

## Important compilation notes

### Compiler support

Historically, builds have failed at link time when using Clang or ThinLTO.

This fork includes fixes for GCC 16 and Clang 20 via `tg_owt` patches, but:

* GCC remains the recommended and most tested compiler
* If Clang produces linking errors, switch to GCC
