# ayugram-overlay

![AyuGram](https://github.com/AyuGram/AyuGramDesktop/raw/dev/.github/AyuGram.png)
![AyuChan](https://github.com/AyuGram/AyuGramDesktop/raw/dev/.github/AyuChan.png)
<img src="https://wiki.gentoo.org/images/d/dd/Genchu.png" width="145"/>

Unofficial Portage overlay for [AyuGram Desktop](https://github.com/AyuGram/AyuGramDesktop)

## Setup

```bash
sudo eselect repository add ayugram https://github.com/Gur0v/ayugram-gentoo.git
sudo emaint sync --repo ayugram
```

## Installation

### Binary (recommended for most users)

Fastest option, no compilation required. Requires x86_64-v2 CPU (Intel/AMD 2008+).

```bash
echo "=net-im/ayugram-desktop-bin-6.7.8 **" | sudo tee -a /etc/portage/package.accept_keywords/ayugram
sudo emerge -av =net-im/ayugram-desktop-bin-6.7.8
```

### Source (6.7.8)

```bash
echo "=net-im/ayugram-desktop-6.7.8 **" | sudo tee -a /etc/portage/package.accept_keywords/ayugram
sudo emerge -av =net-im/ayugram-desktop-6.7.8
```

### Live (9999)

> [!NOTE]
> This method installs the live, unmasked version directly from the development branch. Intended for developers and testers.

```bash
echo "net-im/ayugram-desktop **" | sudo tee -a /etc/portage/package.accept_keywords/ayugram
sudo emerge -av net-im/ayugram-desktop::ayugram
```

## tg_owt

Upstream WebRTC broke repeatedly against newer PipeWire due to SPA header changes. This overlay ships a patched version to work around this.

As of `0_pre20260309`, upstream now includes these fixes. Try that first:

```bash
sudo emerge -av1 ">=media-libs/tg_owt-0_pre20260309"
```

If the build fails, fall back to the overlay version:

```bash
sudo emerge -av1 media-libs/tg_owt::ayugram
```

## Packages

* `net-im/ayugram-desktop` - Source build (full USE flag support)
* `net-im/ayugram-desktop-bin` - Pre-built x86_64-v2 binary (2008+ CPU required)
* `media-libs/tg_owt` - WebRTC with PipeWire/SPA compatibility patches

## Notes

* GCC recommended. Clang/ThinLTO builds may fail in some configurations.

## Credits

* [OverLessArtem](https://codeberg.org/OverLessArtem) - original ebuilds for 6.3.10
