#!/bin/bash
cd
pwd

ls ~/X &> /dev/null || ln -s /dev/null ~/X
ls ~/D &> /dev/null || ln -s ~/PA2assignment/dunnet ~/D

alias l='cd ->~/X; rm .v 2>~/X; disp; cd ~/D/objs'
alias disp='(ls .v &> ~/X && head -1 description? 2>~/X || cat description? 2>~/X; touch .v; hereitems; echo 0 &>~/X)'
alias hereitems='ls *[jkuevcdhnio][aoeisban][rpylrde] &>~/X || ls ?me* &>~/X && echo Here there is: `ls *[jkuevcdhnio][aoeisban][rpylrde] [ael]*m* 2>~/X`'

alias i='echo You currently have: `(cd ~/D/inv; ls *[ojkailnuv][aoecnsbm][rdlirpety]*)`'
alias x='(cat > ../obj; (cd ~/D/inv>~/X; cat `cat ~/D/obj`) || (cd ->~/X; cat `cat ~/D/obj`) || echo I do not see that here)2>~/X < '

alias u='cd ->~/X; cd u &> ~/X && disp || touch temp; rm ../d/temp 2> ~/X && cd .. && disp; cleanup'
alias d='cd ->~/X; cd d &> ~/X && disp || touch temp; rm ../u/temp 2> ~/X && cd .. && disp; cleanup'
alias cleanup='rm temp 2> ~/X && echo You cannot go that way; cd `pwd -P`; cd ~/D/objs'

alias n='cd ->~/X; cd n &>~/X && disp || cat n 2>~/X || touch temp; rm ../s/temp 2> ~/X && cd .. && disp; cleanup'
alias s='cd ->~/X; cd s &>~/X && disp || cat s 2>~/X || touch temp; rm ../n/temp 2> ~/X && cd .. && disp; cleanup'
alias w='cd ->~/X; cd w &>~/X && disp || cat w 2>~/X || touch temp; rm ../e/temp 2> ~/X && cd .. && disp; cleanup'
alias e='cd ->~/X; cd e &>~/X && disp || cat e 2>~/X || touch temp; rm ../w/temp 2> ~/X && cd .. && disp; cleanup'
alias ne='cd ->~/X; cd ne &>~/X && disp || cat ne 2>~/X || touch temp; rm ../sw/temp 2> ~/X && cd .. && disp; cleanup'
alias sw='cd ->~/X; cd sw &>~/X && disp || cat sw 2>~/X || touch temp; rm ../ne/temp 2> ~/X && cd .. && disp; cleanup'
alias nw='cd ->~/X; cd nw &>~/X && disp || cat nw 2>~/X || touch temp; rm ../se/temp 2> ~/X && cd .. && disp; cleanup'
alias se='cd ->~/X; cat se 2>~/X && exit || cd se 2>~/X && disp || touch temp; rm ../nw/temp 2> ~/X && cd .. && disp; cleanup'

cd ~/PA2assignment
rm -rf dunnet
tar -xf PA1.tar
cd ~/D/rooms
disp
cd ~/D/objs
PS1=">"
