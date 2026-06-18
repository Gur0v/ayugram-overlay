# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

inherit xdg

DESCRIPTION="Desktop Telegram client with good customization and Ghost mode (binary package)"
HOMEPAGE="https://github.com/AyuGram/AyuGramDesktop"

MY_PV="${PV}"
SRC_URI="https://github.com/Gur0v/ayugram-overlay/releases/download/v${PVR}/ayugram-desktop-${PV}.gpkg.tar -> ${PF}.gpkg.tar"

S="${WORKDIR}"
LICENSE="BSD GPL-3-with-openssl-exception LGPL-2+"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="mirror strip"
QA_PREBUILT="usr/bin/AyuGram"

RDEPEND="
	!net-im/ayugram-desktop
	!net-im/telegram-desktop
	!net-im/telegram-desktop-bin
	app-arch/lz4:=
	dev-cpp/abseil-cpp:=
	dev-cpp/ada:=
	dev-cpp/cld3:=
	>=dev-cpp/glibmm-2.77:2.68
	dev-libs/glib:2
	dev-libs/libdispatch
	dev-libs/openssl:=
	>=dev-libs/protobuf-21.12
	dev-libs/qr-code-generator:=
	dev-libs/xxhash
	>=dev-qt/qtbase-6.5:6=[gui,network,opengl,ssl,widgets,X]
	>=dev-qt/qtimageformats-6.5:6
	>=dev-qt/qtsvg-6.5:6
	kde-frameworks/kcoreaddons:6
	media-libs/libjpeg-turbo:=
	media-libs/openal
	media-libs/opus
	media-libs/rnnoise
	>=media-libs/tg_owt-0_pre20241202:=[X]
	>=media-video/ffmpeg-6:=[opus,vpx]
	net-libs/tdlib:=[tde2e]
	virtual/minizip:=
	>=app-text/hunspell-1.7:=
	x11-libs/libxcb:=
	x11-libs/xcb-util-keysyms
"

src_unpack() {
	tar -xOf "${DISTDIR}/${A}" --wildcards '*/image.tar.zst' \
		| tar --zstd -xf - -C "${WORKDIR}" \
		|| die "Failed to unpack binary image from gpkg"
}

src_prepare() { default; }
src_configure() { :; }
src_compile()   { :; }

src_install() {
	local d
	for d in usr etc opt; do
		[[ -d "image/${d}" ]] || continue
		cp -pPR "image/${d}" "${ED}/" || die
	done

	local upstream_doc="${ED}/usr/share/doc/ayugram-desktop-${PV}"
	if [[ -d "${upstream_doc}" ]]; then
		mv "${upstream_doc}" "${ED}/usr/share/doc/${P}" || die
		local f
		for f in "${ED}/usr/share/doc/${P}"/*.bz2; do
			[[ -f "${f}" ]] && bzip2 -d "${f}" || die
		done
	fi
}

pkg_postinst() { xdg_pkg_postinst; }
pkg_postrm()   { xdg_pkg_postrm;  }
