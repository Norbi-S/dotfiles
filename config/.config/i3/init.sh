#!/usr/bin/env zsh

(sleep 1; /$HOME/.config/polybar/launch.sh) &

pkill conky 

conky -c ~/.conky/horical.conkyrc 
conky -c ~/.conky/syclo-crimson-bottomleft.conkyrc
conky -c  ~/.conky/shailen.conf 
compstrt 

