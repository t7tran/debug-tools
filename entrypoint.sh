#!/usr/bin/env sh

if [[ $# -eq 1 && -f "$1" ]]; then
	. "$1"
else
	exec "$@"
fi
