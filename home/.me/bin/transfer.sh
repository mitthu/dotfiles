#!/bin/bash
# Created on: 05-Mar-2015, 06:48 pm IST
# Added by:   mitthu (Aditya Basu)
# ----
# Use:    Upload files or piped text to _transfer.sh_ for sharing.
# Source: https://transfer.sh/

if [ $# -eq 0 ]; then
	echo -ne "No arguments specified. Usage:\ntransfer /tmp/test.md\ncat /tmp/test.md | transfer test.md\n"
	return 1
fi

tmpfile=$( mktemp -t transferXXX )
if tty -s; then
	basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g')
	curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile
else 
	curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile
fi

cat $tmpfile
rm -f $tmpfile
