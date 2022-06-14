Before reading this file, first read "walkthroughComparisonToRealGame.txt", to
understand what hereitems needs to do, and why it needs to behave that way.

So, assuming that you have read and understood that file... we'll move on:

To begin discussing how the "hereitems" command needs to work, let's recall
how PA2 had defined and used the "hereitems" alias:
  % grep hereitems PA2.sh
  alias hereitems='ls *[duh-ov]?[dreply] &> ~/X || ls [able][acme]* &> ~/X && echo Here there is: `ls *[duh-ov]?[dreply] [able][acme]* 2>~/X`'
  alias disp='(ls .v &>~/X && head -1 de*||cat de*;echo >.v;hereitems;ls>~/X)'
  %

As we see above, "hereitems" was called from inside the "disp" command, and it
listed some of the objects in the current room. The displayed objects were all
the getable objects, plus the boulder and the bear. We also see, above, that
two "ls" commands were used because it was not possible to create a single
pattern to list exactly the right items. So, to try out PA2's two patterns:
  % cd ~/PA2assignment/allroomdirsandfile
  % ls
  acid        coconuts      descriptionK  descriptionY  key      skeleton
  amethyst    computer      descriptionL  descriptionZ  lamp     sw
  bear        cpu           descriptionM  dinosaur      license  switch
  bin         d             descriptionN  disposal      mail     tank
  bins        descriptionA  descriptionO  drop          n        tanks
  blackboard  descriptionB  descriptionP  e             ne       tree
  board       descriptionC  descriptionQ  emerald       nitric   trees
  bone        descriptionD  descriptionR  fish          nw       u
  boulder     descriptionE  descriptionS  food          palm     vax
  bracelet    descriptionF  descriptionT  garbage       ruby     w
  cabinet     descriptionG  descriptionU  gate          s
  card        descriptionH  descriptionV  glycerine     se
  chip        descriptionI  descriptionW  ibm           shovel
  coconut     descriptionJ  descriptionX  jar           silver
  % echo Here there is: `ls *[duh-ov]?[dreply] [able][acme]* 2>~/X`
  Here there is: acid amethyst bear bone boulder chip emerald food glycerine jar key lamp license ruby shovel silver
  %

So it did work. But in this new programming assignment, we now know about grep
and regular expressions. Can it be done with a single regular expression? Yes:
  % cd ~/PA2assignment/allroomdirsandfile
  % ls -d * | grep __?__ | tr \\n \ ; echo
  acid amethyst bear board bone boulder bracelet food garbage glycerine lamp license ruby shovel silver
  %

Not only is the above output correct, but it is better than the PA2 solution,
because the noun "bracelet" displayed instead of PA2's "emerald", and the
"board" displayed, instead of PA2's "chip". Looking in more detail at the
commands we typed above, we see an "ls -d *". The "ls" needed this "-d" flag
to prevent it from listing the contents of any subdirectories.

There are rules for the "grep __?__": You must use "grep" and you can't give
"grep" any flags. Also "__?__" must be a single regular expression.

So we now understand about what the "grep __?__" does.

The next topic to discuss is the way "ls" displays the subdirectory contents.
Consider:
  % cd ~/D/objs
  % ls [jk]*
  jar  key
  % cd ~/D
  % ls objs/[jk]* | cat
  objs/jar
  objs/key
  %

From the above, we see that the path to the subdirectory appears in front of
the matching file names. When the output of the "ls" is then piped to a "cat"
(or to a "grep ^"), then each of those matching files display on their own
lines. What is the point of this? Well consider the new provided PA1.tar file.
If you expand it, you will see:
  % tar -xf PA1.tar
  % cd dunnet
  % ls
  'There is a'   get   inv   objs   rooms
  %

The dunnet directory contains a strange subdirectory named "There is a". Why
is it there? It is there so that we can do the following:
  % cd T*
  % ls
  % touch lamp license
  % ls
  lamp  license
  % cd ..
  % ls T*/* | cat
  There is a/lamp
  There is a/license
  %

So now its usefulness should become clear -- it's being used to put some words
before the matching file names. (Note: there are easier ways to put words in
front of each line, but we haven't yet learned those easier ways.)

Consider how this "ls T*/*" idea could help in getting the following output:
  % head -379 walkthroughComparisonToRealGame.txt |tail -15
  >se
  SE/NW road
  You are on a southeast/northwest road.
  There is a food here.
  >se
  Bear hangout
  You are standing at the end of a road.  A passage leads back to the
  northwest.
  There is a bear here.
  There is a key here.
  >sw
  Hidden area
  You are in a well-hidden area off to the side of a road.  Back to the
  northeast through the brush you can see the bear hangout.
  There is a bracelet here.


OK. With the above concepts understood, we are ready to implement "hereitems".
The format is:

alias hereitems='(rm -f ~/D/T*/*;cp `ls -d * | grep __?__ | tr \\n \ ` ~/D/T* &>~/X; cd ~/D;ls T*/* 2>~/X | __1__ | tr -d \\n | tr @ \\n | __2__)'

Let's break down what these parts do:
   (rm -f ~/D/T*/*;
      This part empties any files that a previous "Hereitems" might have left
      in the "There is a" directory.
      It also uses "(" to start a subshell, so that the we will be able to
      temporarily change the directory inside of the subshell, and then revert
      back to the original directory when the ")" is reached.

   `ls -d * | grep __?__ | tr \\n \ `
      This part was discussed on lines 38-52, above.
      
   cp `...` ~/D/T* &>~/X
      This part copies the files that you want to tell the player about, from
      the current directory into the "There is a" directory.

      Note: This is a copy, not a move.
      Note: Not all of the synonyms are copied, only the noun that we want to
            use in the display message.

   cd ~/D;ls T*/* 2>~/X |
      This part lists out the displayed items, with "There is a" at the front.
      This part was discussed on lines 56-111, above.
      
   __1__ | tr -d \\n | tr @ \\n |
      This part is a very complicated way to turn the article "a" into "an".
      More details of how to do this will be described below, with an example.

   __2__)
      This part adds the " here." on the end of each line. More details of how
      to do this will be described below, with an example.


So here is the example:
  % bash
  % source ./PA3.sh
  Museum station
  You are at the Museum subway stop.  A passage leads off to the north.
  >n
  N/S tunnel
  You are in a north/south tunnel.
  >n
  North end of N/S tunnel
  You are at the north end of a north/south tunnel.  Stairs lead up and
  down from here.  There is a garbage disposal here.
  >d
  Bottom of subway stairs
  You are at the bottom of some stairs near the subway station.  There is
  a room to the northeast.
  There is an amethyst here.
  >get amethyst
  Taken.
  >u
  North end of N/S tunnel
  >u
  Top of subway stairs
  You are at the top of some stairs near the subway station.  There is
  a door to the west.
  >w
  Classroom
  You are in a classroom where school children were taught about natural
  history.  On the blackboard is written, ‘No children allowed downstairs.’
  There is a door to the east with an ‘exit’ sign on it.  There is another
  door to the west.
  There is a glycerine here.
  >get glycerine
  Taken.
  >s
  Maintenance room
  You are in some sort of maintenance room for the museum.  There is a
  switch on the wall labeled ‘BL’.  There are doors to the west and north.
  There is an acid here.
  >drop glycerine
  Dropped.
  >drop amethyst
  Dropped.
  >drop lamp
  Dropped.
  >l
  Maintenance room
  You are in some sort of maintenance room for the museum.  There is a
  switch on the wall labeled ‘BL’.  There are doors to the west and north.
  There is an acid here.
  There is an amethyst here.
  There is a glycerine here.
  There is a lamp here.
  >

So from the above, we see that I've put different objects in this room, and
two of these objects need to get the "an" article. Let's discuss this further.
Here we can see exactly what input __1__ receives, and what __1__ produces:
  >cd ~/D; ls T*/* | cat
  'There is a/acid'
  'There is a/amethyst'
  'There is a/glycerine'
  'There is a/lamp'
  >ls T*/* | __1__|tr -d \\n | tr @ \\n
  There is a:/acid
  There is a:/amethyst
  There is a/glycerine
  There is a/lamp
  >

Clearly, it has put a ":" in exactly those spots where an "n" is needed. But
How did it find those spots? Well, let's remove the "|tr -d \\n | tr @ \\n":
  >ls T*/* | cat
  'There is a/acid'
  'There is a/amethyst'
  'There is a/glycerine'
  'There is a/lamp'
  >ls T*/* | __1__
  There is a
  :/acid@
  There is a
  :/amethyst@
  There is a
  /glycerine@
  There is a
  /lamp@
  %

We see that each of the four input lines has become two output lines, with a
"@" marking where the original line had ended.

We notice that the place where each line is broken is right after the "a" --
and consider that the place where the "n" of "an" is inserted is also right
after that "a".

So, how to do __1__? It is a pipe of four commands: __a__|__b__|__c__|__d__:
  __a__: Use "u2d" to put a symbol at the end of each input line.
  __b__: Use "tr" to turn that symbol into a "@". Now the ends of the lines
         have a marker symbol.
  __c__: Use grep to split each line at the "/".
         But how can grep split a line? Well, the -o flag can make it print
	 only the matching part of the line, and the -e flag can let you match
	 multiple expressions. So you need one pattern for the first half of
	 the line, and another for the second half.
	 Also, we want to display line numbers. (We don't really want to know
	 line number, but we do want a ":" to go at the front of each line.
	 Consider: we do not yet know many other ways to put things the front
	 of each input line.)
  __d__: Use "grep" to match to two patterns: 1)All the stuff after the ":" if
         the next character is not an "a", and 2)The ":" and all the stuff
	 after if, if the next character is an "a".
	 Also, you will only print the matching expression.
	 Note: you don't need to worry about any other vowels, because they
         don't happen in this part of the game (eg, we don't have "an egg").


Finally, how to do __2__? This to involves a complex series of "u2d" and "tr"
commands. ("u2d" is the easiest way we know, so far, to put something at the
end of each line.) To understand __2__ better, consider its input and output:
  >ls T*/* | __1__|tr -d \\n | tr @ \\n
  There is a:/acid
  There is a:/amethyst
  There is a/glycerine
  There is a/lamp
  >cd - &>~/x; hereitems
  There is an acid here.
  There is an amethyst here.
  There is a glycerine here.
  There is a lamp here.
  >
