# ayugram-ebuild-gentoo

![AyuGram](https://github.com/AyuGram/AyuGramDesktop/raw/dev/.github/AyuGram.png) ![AyuChan](https://github.com/AyuGram/AyuGramDesktop/raw/dev/.github/AyuChan.png) <img src="https://www.gentoo.org/assets/img/logo/gentoo-signet.png" alt="Gentoo BTW" width="128"/>

**Unofficial AyuGram Desktop ebuild for Gentoo Linux**  
Up-to-date dev branch

→ https://github.com/AyuGram/AyuGramDesktop

## Installation

### Installation (Latest stable version)
Ebuild has no preset KEYWORDS for maximum flexibility. To install the package, you need to explicitly allow it in package.accept_keywords for your architecture.

```bash
emerge --ask app-eselect/eselect-repository
eselect repository add ayugram git https://github.com/Gur0v/ayugram-gentoo.git
emaint sync --repo ayugram
# Replace ~amd64 with your architecture (e.g. ~arm64 for aarch64)
echo "net-im/ayugram-desktop ~amd64" | tee /etc/portage/package.accept_keywords/ayugram-desktop
emerge --ask --verbose net-im/ayugram-desktop
```
### Installation (Dev branch / live-9999)
```bash
emerge --ask app-eselect/eselect-repository
eselect repository add ayugram git https://github.com/Gur0v/ayugram-gentoo.git
emaint sync --repo ayugram
echo "net-im/ayugram-desktop **" | tee /etc/portage/package.accept_keywords/ayugram-desktop
emerge --ask --verbose =net-im/ayugram-desktop-9999
```

# CRITICAL — COMPILER
DO NOT use Clang (even with ThinLTO) — it crashes hard at the linking stage.
Only GCC works reliably
