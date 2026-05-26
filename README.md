# ayugram-ebuild-gentoo

![AyuGram](https://github.com/AyuGram/AyuGramDesktop/raw/dev/.github/AyuGram.png) ![AyuChan](https://github.com/AyuGram/AyuGramDesktop/raw/dev/.github/AyuChan.png) <img src="https://www.gentoo.org/assets/img/logo/gentoo-signet.png" alt="Gentoo BTW" width="128"/>

[English](README-EN.md)

**Неофициальный ebuild AyuGram Desktop для Gentoo Linux**  
Актуальный dev-бранч

→ https://github.com/AyuGram/AyuGramDesktop

## Установка

### Установка (Последняя стабильная версия)
Ebuild не имеет предустановленных KEYWORDS для максимальной гибкости. Чтобы установить пакет, необходимо явно разрешить его в package.accept_keywords для вашей архитектуры.

```bash
emerge --ask app-eselect/eselect-repository
eselect repository add ayugram git https://github.com/Gur0v/ayugram-gentoo.git
emaint sync --repo ayugram
# Замените ~amd64 на вашу архитектуру (например ~arm64 для aarch64)
echo "net-im/ayugram-desktop ~amd64" | tee /etc/portage/package.accept_keywords/ayugram-desktop
emerge --ask --verbose net-im/ayugram-desktop
```

### Установка (Dev-бранч / live-9999)
```bash
emerge --ask app-eselect/eselect-repository
eselect repository add ayugram git https://github.com/Gur0v/ayugram-gentoo.git
emaint sync --repo ayugram
echo "net-im/ayugram-desktop **" | tee /etc/portage/package.accept_keywords/ayugram-desktop
emerge --ask --verbose =net-im/ayugram-desktop-9999
```

# ВАЖНО — КОМПИЛЯТОР
НЕ используйте Clang (даже с ThinLTO) — падает на этапе линковки.
Работает только на GCC
