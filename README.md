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

### Source (Recommended)
Standard build from source. Linked against your local libraries.
```bash
echo "net-im/ayugram-desktop ~amd64" | sudo tee -a /etc/portage/package.accept_keywords/ayugram
sudo emerge -av net-im/ayugram-desktop
```

### Binary
Built via CI. Requires an **x86-64-v2** capable CPU (Intel Nehalem / AMD Jaguar and newer).

> [!CAUTION]
> These binaries are linked against system libraries. Because AyuGram uses **Qt Private APIs**, any minor update to `dev-qt/qtbase` on your system (e.g. 6.10 -> 6.11) will cause an ABI mismatch and a crash. If this happens, wait for a CI rebuild or switch to the source ebuild.

```bash
echo "net-im/ayugram-desktop-bin ~amd64" | sudo tee -a /etc/portage/package.accept_keywords/ayugram
sudo emerge -av net-im/ayugram-desktop-bin
```

### Live
Installs directly from the development branch.
```bash
echo "=net-im/ayugram-desktop-9999 **" | sudo tee -a /etc/portage/package.accept_keywords/ayugram
sudo emerge -av =net-im/ayugram-desktop-9999
```

## Implementation Notes

* **LTO and Compilers:** GCC is the recommended compiler. **LTO is highly discouraged** for both `net-im/ayugram-desktop` and `media-libs/tg_owt`. These codebases are massive; enabling LTO typically leads to memory exhaustion (OOM) during linking, compiler crashes, or unpredictable runtime logic errors due to ODR violations.
* **ABI Stability:** AyuGram relies on **Qt Private APIs** for custom text rendering. These internal interfaces change memory offsets between minor Qt releases (e.g., 6.10.x to 6.11.x). 
    * Running a binary built against a different Qt minor version causes **immediate heap corruption** (`free(): invalid pointer`) and a crash. 
    * If you update Qt, you must re-emerge the package to pull a build synced with the new ABI.

## Credits
* [AyuGram Team](https://github.com/AyuGram)
* [OverLessArtem](https://codeberg.org/OverLessArtem) — original 6.3.10 ebuilds.
