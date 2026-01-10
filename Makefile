
# $FreeBSD$

PORTNAME=	doveguard
DISTVERSION=	1.0.0
CATEGORIES=	security

MAINTAINER=	sam@sheridan.uk
COMMENT=	Lightweight Dovecot brute-force protector for FreeBSD
WWW=		https://github.com/sheridans/doveguard

USE_GITHUB=	yes
GH_ACCOUNT=	sheridans
GH_TAGNAME=	v${DISTVERSION}

LICENSE=	BSD2CLAUSE
LICENSE_FILE=	${WRKSRC}/LICENSE.md

USES=		cargo
USE_RC_SUBR=	doveguard
SUB_FILES=	pkg-message

CARGO_CRATES=	ahash-0.8.12 \
		aho-corasick-1.1.4 \
		allocator-api2-0.2.21 \
		anstream-0.6.21 \
		anstyle-1.0.13 \
		anstyle-parse-0.2.7 \
		anstyle-query-1.1.5 \
		anstyle-wincon-3.0.11 \
		anyhow-1.0.100 \
		arraydeque-0.5.1 \
		async-trait-0.1.89 \
		base64-0.21.7 \
		bitflags-2.10.0 \
		block-buffer-0.10.4 \
		block2-0.6.2 \
		cfg-if-1.0.4 \
		cfg_aliases-0.2.1 \
		clap-4.5.54 \
		clap_builder-4.5.54 \
		clap_derive-4.5.49 \
		clap_lex-0.7.6 \
		colorchoice-1.0.4 \
		config-0.14.1 \
		const-random-0.1.18 \
		const-random-macro-0.1.16 \
		convert_case-0.6.0 \
		cpufeatures-0.2.17 \
		crunchy-0.2.4 \
		crypto-common-0.1.7 \
		ctrlc-3.5.1 \
		deranged-0.5.5 \
		digest-0.10.7 \
		dispatch2-0.3.0 \
		dlv-list-0.5.2 \
		encoding_rs-0.8.35 \
		equivalent-1.0.2 \
		error-chain-0.12.4 \
		generic-array-0.14.7 \
		getrandom-0.2.16 \
		hashbrown-0.14.5 \
		hashbrown-0.16.1 \
		hashlink-0.8.4 \
		heck-0.5.0 \
		hostname-0.3.1 \
		indexmap-2.13.0 \
		ipnet-2.11.0 \
		is_terminal_polyfill-1.70.2 \
		itoa-1.0.17 \
		json5-0.4.1 \
		libc-0.2.180 \
		log-0.4.29 \
		match_cfg-0.1.0 \
		memchr-2.7.6 \
		minimal-lexical-0.2.1 \
		nix-0.30.1 \
		nom-7.1.3 \
		num-conv-0.1.0 \
		num_threads-0.1.7 \
		objc2-0.6.3 \
		objc2-encode-4.1.0 \
		once_cell-1.21.3 \
		once_cell_polyfill-1.70.2 \
		ordered-multimap-0.7.3 \
		pathdiff-0.2.3 \
		pest-2.8.5 \
		pest_derive-2.8.5 \
		pest_generator-2.8.5 \
		pest_meta-2.8.5 \
		powerfmt-0.2.0 \
		proc-macro2-1.0.105 \
		quote-1.0.43 \
		regex-1.12.2 \
		regex-automata-0.4.13 \
		regex-syntax-0.8.8 \
		ron-0.8.1 \
		rust-ini-0.20.0 \
		serde-1.0.228 \
		serde_core-1.0.228 \
		serde_derive-1.0.228 \
		serde_json-1.0.149 \
		serde_spanned-0.6.9 \
		sha2-0.10.9 \
		strsim-0.11.1 \
		syn-2.0.114 \
		syslog-6.1.1 \
		time-0.3.44 \
		time-core-0.1.6 \
		time-macros-0.2.24 \
		tiny-keccak-2.0.2 \
		toml-0.8.23 \
		toml_datetime-0.6.11 \
		toml_edit-0.22.27 \
		toml_write-0.1.2 \
		typenum-1.19.0 \
		ucd-trie-0.1.7 \
		unicode-ident-1.0.22 \
		unicode-segmentation-1.12.0 \
		utf8parse-0.2.2 \
		version_check-0.9.5 \
		wasi-0.11.1+wasi-snapshot-preview1 \
		winapi-0.3.9 \
		winapi-i686-pc-windows-gnu-0.4.0 \
		winapi-x86_64-pc-windows-gnu-0.4.0 \
		windows-link-0.2.1 \
		windows-sys-0.61.2 \
		winnow-0.7.14 \
		yaml-rust2-0.8.1 \
		zerocopy-0.8.33 \
		zerocopy-derive-0.8.33 \
		zmij-1.0.12

USERS=		doveguard
GROUPS=		doveguard

PLIST_FILES=	sbin/doveguard \
		etc/doveguard.conf.sample \
		share/man/man8/doveguard.8.gz \
		"@dir(doveguard,doveguard,) /var/log/doveguard" \
		"@dir(doveguard,doveguard,) /var/db/doveguard"

post-install:
	${MKDIR} ${STAGEDIR}${PREFIX}/etc
	${INSTALL_DATA} ${FILESDIR}/doveguard.conf.sample ${STAGEDIR}${PREFIX}/etc/doveguard.conf.sample
	${MKDIR} ${STAGEDIR}/var/db/doveguard
	${MKDIR} ${STAGEDIR}/var/log/doveguard

do-install:
	${INSTALL_PROGRAM} ${CARGO_TARGET_DIR}/release/${PORTNAME} ${STAGEDIR}${PREFIX}/sbin
	${MKDIR} ${STAGEDIR}${PREFIX}/share/man/man8
	${INSTALL_MAN} ${FILESDIR}/doveguard.8 ${STAGEDIR}${PREFIX}/share/man/man8

.include <bsd.port.mk>
