PORTNAME=	doveguard
DISTVERSION=	1.0.1
CATEGORIES=	security

MAINTAINER=	sam@sheridan.uk
COMMENT=	Lightweight Dovecot brute-force protector for FreeBSD
WWW=		https://github.com/sheridans/doveguard

LICENSE=	BSD2CLAUSE
LICENSE_FILE=	${WRKSRC}/LICENSE.md

USES=		cargo
USE_GITHUB=	yes
GH_ACCOUNT=	sheridans
GH_TAGNAME=	v${DISTVERSION}
USE_RC_SUBR=	doveguard

SUB_FILES=	doveguard pkg-message

USERS=		doveguard
GROUPS=		doveguard

.include "${.CURDIR}/Makefile.crates"

PLIST_FILES=	"@dir(doveguard,doveguard,) /var/db/doveguard" \
		"@dir(doveguard,doveguard,) /var/log/doveguard" \
		"@sample etc/doveguard.conf.sample" \
		sbin/doveguard \
		share/man/man8/doveguard.8.gz

do-install:
	${INSTALL_PROGRAM} ${CARGO_TARGET_DIR}/release/${PORTNAME} ${STAGEDIR}${PREFIX}/sbin
	${MKDIR} ${STAGEDIR}${PREFIX}/share/man/man8
	${INSTALL_MAN} ${FILESDIR}/doveguard.8 ${STAGEDIR}${PREFIX}/share/man/man8

post-install:
	${MKDIR} ${STAGEDIR}${PREFIX}/etc
	${INSTALL_DATA} ${FILESDIR}/doveguard.conf.sample ${STAGEDIR}${PREFIX}/etc/doveguard.conf.sample
	${MKDIR} ${STAGEDIR}/var/db/doveguard
	${MKDIR} ${STAGEDIR}/var/log/doveguard

.include <bsd.port.mk>
