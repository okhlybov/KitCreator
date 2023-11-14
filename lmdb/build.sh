#! /usr/bin/env bash

# BuildCompatible: KitCreator

version="0.4.2"
url="https://github.com/ray2501/tcl-lmdb/archive/${version}.tar.gz"
sha256='2b9132e2a049a93d731c8de7806924d55bc41bc7438db2dc727a8f79459cb13d'

function postinstall() {
	local name
	local isWindows

	# Windows-only
	isWindows='false'
	case "${KC_CROSSCOMPILE_HOST_OS}" in
		*-cygwin|*-mingw32|*-mingw32-*|*-cygwin-*)
			isWindows='true'
			;;
	esac

	if [ "${isWindows}" = 'true' ]; then
		find "${installdir}" -type -f -name '*.a' | while IFS='' read -r name; do
			echo '-lntdll' > "${name}.linkadd"
		done
	fi
}
