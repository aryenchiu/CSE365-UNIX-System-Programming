ls ~/X &> /dev/null || ln -s /dev/null ~/X
ls ~/D &> /dev/null || ln -s ~/PA2assignment/dunnet ~/D

alias x='(cat >../obj;cd ->~/X;cat `cat ~/D/obj` || (cd ~/D/inv && cat `cat ~/D/obj`)||echo "I do not see that here.")2>~/X < '
alias i='(cd ~/D/inv>~/X;echo -n "You currently have: "; ls [abfgjklrs]*[^s] 2> ~/X | u2d | tr '\r\n' ', '| rev | cut --complement -c1-2 | rev; echo . )| fold -w56 -s; echo'
alias drop='(cat >../obj; (cd ..; grep '^[an].*[cd]$' obj &>~/X && echo '[an]*[cd]' > obj; grep '.*e[lm]e.*[td]$' obj &>~/X && echo '*e[lm]e*[td]' > obj; grep '^[bc][ohap].*[dpu]$' obj &>~/X && echo '[bc][ohap]*[dpu]' > obj); cd ->~/X; mv ~/D/inv/`cat ~/D/obj` . && echo Dropped. || echo You do not have that.)2>~/X <'
alias hereitems='(rm -f ~/D/T*/*;cp `ls -d * | grep '^[abfglrs][^k]*[cyeaodlinuv][isarneogmb][tdrepylr]$' | tr \\n \ ` ~/D/T* &>~/X; cd ~/D;ls T*/* 2>~/X | u2d | tr '\r' '@' | grep -ion -e 'There is a' -e '/.*' | grep -io -e 'there is a' -e ':/[aeiou]@$' -e '/[^aeiou]@$' | tr -d \\n | tr @ \\n | tr ':/' 'n ')'
alias get='(cat >../obj;cd ->~/X;(mv *[cyolhijkauv][sanloimpeb][ryutped] [bclns][oaih][arcot][rdevr]* ~/D/get &>~/X; ls `cat ~/D/obj` &>~/X && echo You cannot take that. || (cd ~/D/get; grep 'all' ~/D/obj &>~/X && (ls * &>~/X && ls| xargs echo 'Taken:' | fold -w56 -s || echo Nothing to take.) || (ls ~/D/get/`cat ~/D/obj` &>~/X && echo Taken. || echo I do not see that here.))); (cd ~/D; grep '^[an].*[cd]$' obj &>~/X && echo '[an]*[cd]' > obj; grep '.*e[lm]e.*[td]$' obj &>~/X && echo '*e[lm]e*[td]' > obj; grep '^[bc][ohap].*[dpu]$' obj &>~/X && echo '[bc][ohap]*[dpu]' > obj; grep 'all' obj &>~/X && echo '*' > obj; cd get; mv `cat ../obj` ../inv)&>~/X;mv ~/D/get/* .)2>~/X <'
alias disp='(ls .v &>~/X && head -1 de*||cat de*;echo >.v;hereitems;ls>~/X)'
alias l='(cd ->~/X;rm .v;disp)'

alias cleanup='rm temp 2>~/X && echo "You cannot go that way.";cd `pwd -P`;cd ~/D/objs'
alias n='cd ->~/X;cd n 2>~/X && disp || cat n 2>~/X || echo >temp; rm ../s/temp 2>~/X && cd .. && disp; cleanup'
alias s='cd ->~/X;cd s 2>~/X && disp || echo >temp; rm ../n/temp 2>~/X && cd .. && disp; cleanup'
alias e='cd ->~/X;cd e 2>~/X && disp || cat e 2>~/X || echo >temp; rm ../w/temp 2>~/X && cd .. && disp; cleanup'
alias w='cd ->~/X;cd w 2>~/X && disp || echo >temp; rm ../e/temp 2>~/X && cd .. && disp; cleanup'
alias u='cd ->~/X;cd u 2>~/X && disp || echo >temp; rm ../d/temp 2>~/X && cd .. && disp; cleanup'
alias d='cd ->~/X;cd d 2>~/X && disp || echo >temp; rm ../u/temp 2>~/X && cd .. && disp; cleanup'
alias nw='cd ->~/X;cd nw 2>~/X && disp||cat nw 2>~/X||echo >temp; rm ../se/temp 2>~/X &&cd .. && disp; cleanup'
alias sw='cd ->~/X;cd sw 2>~/X && disp||echo >temp; rm ../ne/temp 2>~/X &&cd .. && disp; cleanup'
alias ne='cd ->~/X;cd ne 2>~/X && disp||cat ne 2>~/X||echo >temp; rm ../sw/temp 2>~/X &&cd .. && disp; cleanup'
alias se='cd ->~/X;cat se 2>~/X&&exit; cd se 2>~/X && disp||echo >temp; rm ../nw/temp 2>~/X &&cd .. && disp; cleanup'

cd ~/PA2assignment
rm -rf dunnet
tar -xf PA1.tar
cd ~/D/rooms
disp
cd ~/D/objs
PS1=">"
