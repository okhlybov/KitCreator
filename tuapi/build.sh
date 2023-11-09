#! /usr/bin/env bash

# BuildCompatible: KitCreator

version='0.12'
url="http://rkeene.org/devel/tuapi-${version}.tar.gz"
sha256='dec1017e016c2ac2b0cea361a9556ea195b0c7f3c3c1765cdc95f1e422ee7d25'

function configure() {
	:
}

function build() {
	(
		. build-common.sh

		eval ${TCL_CC} ${TCL_DEFS} ${TCL_INCLUDE_SPEC} -o tuapi.o -c tuapi.c || exit 1

		${AR:-ar} rcu libtuapi.a tuapi.o || exit 1

		${RANLIB:-ranlib} libtuapi.a || exit 1

		echo 'package ifneeded tuapi '"${tuapi_version}"' [list load {} tuapi]' > pkgIndex.tcl
	) || return 1
}

function install() {
	mkdir -p "${installdir}/lib/tuapi${version}" || return 1

	cp libtuapi.a pkgIndex.tcl "${installdir}/lib/tuapi${version}" || return 1
}
