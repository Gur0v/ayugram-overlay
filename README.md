# ayugram-overlay
![AyuGram](https://github.com/AyuGram/AyuGramDesktop/raw/dev/.github/AyuGram.png)
![AyuChan](https://github.com/AyuGram/AyuGramDesktop/raw/dev/.github/AyuChan.png)
<img src="https://wiki.gentoo.org/images/d/dd/Genchu.png" width="145"/>

Unofficial Portage overlay for [AyuGram Desktop](https://github.com/AyuGram/AyuGramDesktop).

## Setup
```bash
sudo eselect repository add ayugram-overlay git https://github.com/Gur0v/ayugram-overlay.git
sudo emaint sync --repo ayugram-overlay
```

## Installation

### Source (recommended)
Full USE flag support, optimized for your machine, compiled with your flags.
```bash
echo "net-im/ayugram-desktop ~amd64" | sudo tee -a /etc/portage/package.accept_keywords/00ayugram
sudo emerge -av net-im/ayugram-desktop
```

### Binary
For when you don't feel like waiting. Requires an x86_64-v2 CPU (Intel/AMD 2008+).

> [!WARNING]
> Binaries are **not statically linked**. If AyuGram fails to launch with a library error, your system libraries have drifted out of sync with the build environment. Recompile from source.

```bash
echo "net-im/ayugram-desktop-bin ~amd64" | sudo tee -a /etc/portage/package.accept_keywords/00ayugram
sudo emerge -av net-im/ayugram-desktop-bin
```

### Live
> [!NOTE]
> Installs directly from the development branch. Intended for developers or early adopters.

```bash
echo "net-im/ayugram-desktop **" | sudo tee -a /etc/portage/package.accept_keywords/00ayugram
sudo emerge -av net-im/ayugram-desktop::ayugram-overlay
```

## Packages
* `net-im/ayugram-desktop` - Source build (full USE flag support)
* `net-im/ayugram-desktop-bin` - Pre-built x86_64-v2 binary (2008+ CPU required)
* `media-libs/tg_owt` - WebRTC with PipeWire/SPA compatibility patches

## Notes
* GCC recommended. Clang/ThinLTO builds may fail in some configurations.
* This overlay ships a patched `tg_owt` to work around upstream WebRTC breakage against newer PipeWire due to SPA header changes. As of `0_pre20260309`, upstream includes these fixes, so try that first:
  ```bash
  sudo emerge -av1 ">=media-libs/tg_owt-0_pre20260309"
  ```
  If the build fails, fall back to the overlay version:
  ```bash
  sudo emerge -av1 media-libs/tg_owt::ayugram-overlay
  ```

## Credits
* [OverLessArtem](https://codeberg.org/OverLessArtem) - original ebuilds for 6.3.10
