#!/bin/bash
# Created on: 17-May-2020, 01:17 pm EDT
# Added by: mitthu (Aditya Basu)
# ----
# Use:
# - Trim URLs down to domains

APPNAME="Tidy URL Formatter"
text=$1

# Get URL using prompt if none is provided (or selected in Zim)
if [ "$text" = "" ]; then
	text=$(zenity --entry --title "$APPNAME" --text "Enter URL:")
	[ $? -ne 0 ] && exit 0 # exit if cancel is pressed
fi

# Extract URL components
domain=$(echo $text | awk -F[/:] '{print $4}')
domain_nowwww=$(echo $domain | sed -e 's/www.//')
l1=$(echo $text | awk -F[/:] '{print $5}')

# Exit if not a url
[ "$domain" = "" ] &&
	zenity --info --no-wrap --title "$APPNAME" --text "Only urls are supported." &&
	echo -n $text &&
	exit 0

# Create tempfile to hold table
tblfile=$(tempfile)

if [ "$domain" = "$domain_nowwww" ]; then
	cat >$tblfile <<EOF
	TRUE  $domain
	FALSE $domain/$l1
	FALSE $text
EOF
else
	cat >$tblfile <<EOF
	FALSE $domain
	FALSE $domain/$l1
	TRUE $domain_nowwww
	FALSE $domain_nowwww/$l1
	FALSE $text
EOF
fi

# Prompt for choosing style
read -r -d "" INFOTEXT <<EOF
<b>Input text:</b>
$text
EOF
modtext=$(\
	zenity --list --editable --radiolist --height 300 \
	--title "$APPNAME" \
	--text "$INFOTEXT" \
	--column "" --column "Choose display style" \
	$(cat $tblfile)
)

if [ $? -eq 1 ]; then # if cancel is pressed
	echo -n $text # preserve original
else
	echo -n "[[$text|$modtext]]" # style the url
fi

# Remove tempfile
rm $tblfile
