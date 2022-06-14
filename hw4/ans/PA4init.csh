ls ~/X >& /dev/null || ln -s /dev/null ~/X
rm -f ~/D >&/dev/null; ln -s ~/PA4assignment/PA4dunnet ~/D
alias hereitems 'ls --color=never [dbagjarflask]*[^gut][pterodactylA-Z] | sed "/^n.*/d;s/^"\$"/jar/;s/^[ag][cl]/packet of &/;s/acid/nitric &/;s/^[ra][um]/valuable &/;s/jar/glass &/;s/^board/CPU card/;s/^be/ferocious &/;s/^bon/dinosaur &/;s/key/shiny brass &/;s/bracelet/emerald &/;s/^bou/large &/;s/^li/bus driver'\''s &/;s/ilver/& bar/;s/lamp/& nearby./;s/^/There is a /;s/[^.]"\$"/& here./;s/a \([aeiou]\)/an \1/;s/.*:.*/The jar contains:/"    |   tr \\n @    |    sed  -n  "s/[^@]*:@"\$"//;s/\(:.*@\)T/\1     T/;s/\(:.*@\)T/\1     T/;s/[^@]*[bd][peril][sonar][pc][ork ][^@]*@//g;s/@/\n/gp"'

# For full points, the character length of __1__ must be as short as
# possible. Also note that cannot use any sed commands except for "s".
#
# To remind: Here is how each one prints:
#   "A silver bar.", "A glass jar.", "A computer board.", "A brass key.",
#   "Some nitric acid.", "Some glycerine.", "Some food.", "An amethyst.",
#   "A lamp.", "A license.", "A bone.", "A ruby.", "A bracelet.", and
#   "A shovel."
alias invitems 'touch X && ls --color=never [^cen]* | sed s_^\$_jar_";s/^n.*//;s/^ac/nitric &/;s/./A &/;s/.*X//;s/.*:/The jar contains:/;s/A\( [ngf]\)/Some\1/;s/A a/An a/;s/j/glass &/;s/boa/computer &/;s/k/brass &/;s/ver/& bar/"|grep .|tr \\n @|sed "s/:@/:6     /;s/:[^@]*@/&     /;s/ *"\$"//;s/[@6]/\n/g;s_[^\n]*:."\$__;rm X'

alias disp 'ls .v >&~/X && sed 2,/^.ty/d <de*||cat de*;echo >.v;hereitems'

alias cdcont 'cd - >& ~/X && continue'

cd ~/PA4assignment
rm -rf PA4dunnet
tar -xf PA4dunnet.tar
cd ~/D/rooms
disp
