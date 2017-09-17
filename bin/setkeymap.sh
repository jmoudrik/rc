#!/bin/sh

setxkbmap -option grp:ctrl_shift_toggle 'us,cz(qwerty)'
#setxkbmap -option grp:ctrl_shift_toggle 'us,cz(qwerty),ru'
xmodmap -e 'keycode 66= Escape'
xmodmap -e 'clear Lock'
xmodmap -e "keycode 166=Prior"
xmodmap -e "keycode 167=Next"
xmodmap -e "keycode 96=BackSpace"
xmodmap -e "remove Mod1 = Alt_R"
xmodmap -e "add Mod3 = Alt_R"
#xinput --disable 11
