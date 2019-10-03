#!/bin/bash

bash -c "xsel -c --clipboard"

main() {
	cat hira | dmenu -i -l 5 -fn Monospace-14 -p "$type: $(xsel -o --clipboard)" | while IFS= read -r line
	do
		str=`xsel -o --clipboard`
		if [ "$line" == "*DEL" ]
		then
			bash -c "echo '${str::-1}' | tr -d '\n' | xsel --clipboard"
			main
		else
			bash -c "echo '$line' | tr -d ' [:alpha:]\n' | xsel -a --clipboard"
			main
		fi
		
	done
}
type="H" # Defines whether to load Hiragana (H) or Katakana (K)
if [ $type == "H" ]
then
	main
else
	echo
	# load Katakana stuff here
fi

if [ "$(xsel -o --clipboard)" ]
then
	pgrep -x dunst >/dev/null && notify-send "$(xsel -o --clipboard) copied." -t 3000
fi
