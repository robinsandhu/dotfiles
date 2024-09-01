#!/usr/bin/env bash

REALPATH_BIN='/usr/bin/realpath'
RSYNC_BIN='/usr/bin/rsync'
DIRNAME_BIN='/usr/bin/dirname'

SOURCE_DIR="$("${DIRNAME_BIN}" "$("${REALPATH_BIN}" "${0}")")"
DESTINATION_DIR="/tmp/rsandhu"

function syncDotFiles() {
	"${RSYNC_BIN}" --exclude ".git/" \
		       --exclude ".DS_Store" \
		       --exclude ".osx" \
		       --exclude "bootstrap.sh" \
		       --exclude "README.md" \
		       --exclude "LICENSE-MIT.txt" \
		       -avh --no-perms "${SOURCE_DIR}/" "${DESTINATION_DIR}"
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo ""
	if [[ "$REPLY" =~ ^[Yy]$ ]]; then
		syncDotFiles
	fi
fi

unset syncDotFiles

