# ayugram-overlay

![AyuGram](https://github.com/AyuGram/AyuGramDesktop/raw/dev/.github/AyuGram.png)
![AyuChan](https://github.com/AyuGram/AyuGramDesktop/raw/dev/.github/AyuChan.png)
<img src="https://wiki.gentoo.org/images/d/dd/Genchu.png" width="145"/>

> [!WARNING]
> ## Archived and no longer maintained
>
> **ayugram-overlay is archived. New development and package maintenance have moved to [gurov-overlay](https://github.com/Gur0v/gurov-overlay).**
>
> This repository will not receive ongoing updates for `net-im/ayugram-desktop`, and the `-bin` and `9999` packages are no longer maintained here.
>
> The old installation instructions are kept below for users who deliberately want to remain on this overlay, but the recommended path is to migrate to `gurov-overlay`.
>
> The main reason for this change is maintenance overhead. Keeping a separate binary package and live ebuild for AyuGram requires continuous CI rebuilds and extra maintenance. AyuGram also uses Qt Private APIs, which makes prebuilt binaries particularly sensitive to Qt minor-version changes on the user's system.

## Recommended: migrate to gurov-overlay

`gurov-overlay` is now the maintained overlay for AyuGram Desktop. It provides the source ebuild and will be kept up to date without maintaining a separate `-bin` package or `9999` live ebuild.

### 1. Add gurov-overlay

The easiest way is with `eselect repository`:

```bash
sudo eselect repository enable gurov-overlay
sudo emaint sync -r gurov-overlay
````

If `eselect repository` is not installed:

```bash
sudo emerge app-eselect/eselect-repository
```

See the [gurov-overlay README](https://github.com/Gur0v/gurov-overlay) for the current setup instructions.

### 2. Remove the old overlay

Once `gurov-overlay` is working, remove the archived overlay so Portage does not have two repositories providing the same package:

```bash
sudo eselect repository remove ayugram-overlay
```

### 3. Install or update AyuGram

Allow the testing keyword on amd64 and install the maintained source ebuild:

```bash
echo "net-im/ayugram-desktop ~amd64" | sudo tee -a /etc/portage/package.accept_keywords/ayugram
sudo emerge -av net-im/ayugram-desktop
```

If AyuGram is already installed from this overlay, simply re-emerge it after switching repositories:

```bash
sudo emerge -av net-im/ayugram-desktop
```

## Deprecated: old ayugram-overlay setup

These instructions are intentionally preserved for users who, for whatever reason, want to remain on this archived overlay. They are not recommended and packages here may become stale or stop building as dependencies change.

### Setup

```bash
sudo eselect repository add ayugram-overlay git https://github.com/Gur0v/ayugram-overlay.git
sudo emaint sync --repo ayugram-overlay
```

## Installation

### Source

Standard build from source. Linked against your local libraries.

```bash
echo "net-im/ayugram-desktop ~amd64" | sudo tee -a /etc/portage/package.accept_keywords/ayugram
sudo emerge -av net-im/ayugram-desktop
```

### Binary

Built via CI. Requires an **x86-64-v2** capable CPU (Intel Nehalem / AMD Jaguar and newer).

> [!CAUTION]
> These binaries are linked against system libraries. Because AyuGram uses **Qt Private APIs**, a minor update to `dev-qt/qtbase` on your system can cause an ABI mismatch and a crash. For example, a binary built against Qt 6.10 is not necessarily compatible with Qt 6.11. This package is no longer rebuilt here.

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
* **ABI Stability:** AyuGram relies on **Qt Private APIs** for custom text rendering. These internal interfaces can change between Qt minor releases.

  * Running a binary built against a different Qt minor version can cause heap corruption and a crash.
  * For binaries, the build needs to be synchronized with the Qt version installed on the system.
  * The maintained `gurov-overlay` deliberately focuses on the source ebuild instead of carrying a separate `-bin` package.

## Credits

* [AyuGram Team](https://github.com/AyuGram)
* [OverLessArtem](https://codeberg.org/OverLessArtem) — original 6.3.10 ebuilds.
