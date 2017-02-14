# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit apache-module git-r3

DESCRIPTION="A program to efficiently render and serve map tiles for www.openstreetmap.org map using Apache and Mapnik."
HOMEPAGE="https://github.com/openstreetmap/mod_tile"
EGIT_REPO_URI="https://github.com/openstreetmap/mod_tile.git"

APACHE2_MOD_DEFINE="TILE"

LICENSE="GPL-2"
SLOT="0/9999"
KEYWORDS=""

IUSE="test"

RDEPEND=""
DEPEND=""

need_apache2

src_prepare () {
    default
    epatch "$FILESDIR/geometry.patch"
    ./autogen.sh || die "autogen failed"
}

src_compile() {
    emake || die "make failed"
}

src_test() {
    emake test || die "test failed"
}

src_install () {
    emake DESTDIR="$D" install || die "install failed"
    emake DESTDIR="$D" install-mod_tile || die "install mod tile failed"
}
