#!/bin/bash
# Created on: 17-May-2020, 01:17 pm EDT
# Added by: mitthu (Aditya Basu)
# ----
# Use:
# - Trim URLs down to domains

text=$1

# Extract URL components
domain=$(echo $text | awk -F[/:] '{print $4}')
l1=$(echo $text | awk -F[/:] '{print $5}')

# Exit if not a url
[ "$domain" = "" ] && 
	zenity --error --text "Only URLs can be formatted." &&
	echo -n $text &&
	exit 1

# Prompt for choosing style
read -r -d "" INFOTEXT <<EOF
<b>Input text:</b>
$text
EOF
modtext=$(\
	zenity --list --radiolist \
	--title "Format URL" \
	--text "$INFOTEXT" \
	--column "" --column "Choose style" \
	TRUE "$domain" \
	FALSE "$domain/$l1" \
)

if [[ $? == 1 ]]; then
	# Cancel is pressed, then preserve original & quit  
	echo -n $text
else # format the modified form
	echo -n "[[$text|$modtext]]"
fi
