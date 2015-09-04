# $OpenBSD: Makefile,v 1.209 2015/04/04 09:21:04 ajacoutot Exp $

ONLY_FOR_ARCHS=		i386 amd64
DPB_PROPERTIES=		parallel

COMMENT=		Dart programming language

V=			1.10.0
DISTNAME=		dart-${V}

CATEGORIES=		lang

HOMEPAGE=		https://www.dartlang.org/

MAINTAINER=		Adam Wolk <adam.wolk@koparo.com>

# BSD-like
PERMIT_PACKAGE_CDROM=	patents # TODO: check this
PERMIT_PACKAGE_FTP =	Yes     # TODO: check this
PERMIT_DISTFILES_FTP =	Yes	# TODO: check this
MASTER_SITES=	http://gsdview.appspot.com/dart-archive/channels/stable/raw/45396/src/

MAKE_ENV+=		V=1

MODULES=		gcc4 lang/python
MODGCC4_ARCHS=		*
MODGCC4_LANGS=		c c++
MODGCC4_VERSION=	4.9

MODPY_RUNDEP=	No

WANTLIB += X11 Xext Xfixes Xrender Xss c cairo cups dbus-1 event
WANTLIB += execinfo expat fontconfig freetype gconf-2 gdk-x11-2.0
WANTLIB += gdk_pixbuf-2.0 glib-2.0 gobject-2.0 gtk-x11-2.0
WANTLIB += m pango-1.0 pangocairo-1.0
WANTLIB += png pthread speex
WANTLIB += xml2 xslt
WANTLIB += usb-1.0 sndio
WANTLIB += Xcomposite
WANTLIB += stdc++
WANTLIB += Xi Xtst
WANTLIB += Xdamage
WANTLIB += Xcursor Xrandr gio-2.0
WANTLIB += jpeg nspr4 nss3 nssutil3 plc4 smime3

RUN_DEPENDS=	devel/xdg-utils \
		devel/desktop-file-utils \
		graphics/libexif \
		x11/gnome/libgnome-keyring \
		x11/gtk+3,-guic
BUILD_DEPENDS=	archivers/bzip2 \
		devel/gperf \
		devel/gmake \
		devel/bison \
		devel/flex \
		devel/yasm \
		shells/bash \
		sysutils/flock \
		sysutils/pciutils \
		x11/gnome/libgnome-keyring

LIB_DEPENDS=	devel/libexecinfo \
		devel/libusb1 \
		security/nss \
		devel/gconf2 \
		textproc/libxslt \
		x11/gtk+2 \
		audio/speex \
		print/cups,-libs

do-configure:
	@cd ${WRKSRC} && env -i ${CONFIGURE_ENV} /usr/local/bin/python2.7 ./dart/tools/compiler_scripts/generate_my_projects.py && \
	env -i ${CONFIGURE_ENV} /usr/local/bin/python2.7 ./dart/editor/build/generate_sources.py && \
	env -i ${CONFIGURE_ENV} /usr/local/bin/python2.7 ./dart/tools/gyp_dart.py

do-build:
	@cd ${WRKSRC}/dart && env -i ${MAKE_ENV} /usr/local/bin/python2.7 ./tools/build.py -m release --arch=x64 runtime

.include <bsd.port.mk>
