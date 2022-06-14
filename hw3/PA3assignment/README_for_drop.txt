The format of the alias for the drop command is:

alias drop='(cat >../obj; (cd ..;__1__; __2__; __3__); cd ->~/X; mv ~/D/inv/`cat ~/D/obj` . && echo Dropped. || echo You do not have that.)2>~/X <'

As you can see, the basic behavior of the command is to try to move the file
indicated by ~/D/obj into the room directory. If this fails, it means that
you did not have the object.

But looking at the above alias command, we see that there is more to it. There
are three blanks to fill in. These blanks are for handling the three getable
objects that have synonyms (other objects, like the "palm trees" or the "mail
drop" also have synonyms, but such other objects won't ever be in you ~/D/inv
directory, because they are not getable (ie, you can't pick them up)).

So there only three getable objects with aliases. For each of these, we cannot
just do the above alias's "mv ~/D/inv/`cat ~/D/obj` .", because we must move
both of the synonyms. For example, if you type either "drop emerald" or "drop
bracelet", then the alias should move BOTH the "emerald" and "bracelet" files
from the inventory to the current room.

So how do __1__, __2__, and __3__ accomplish this? Well each blank handles
one of the three such objects. Each of the blanks has the same two part task:

  1) Determine if ~/D/obj contains one of the synonyms of the given object.
     - But you must use "grep" to make this determination, and you can only
       use one regular expression.
     - And how to know if you have designed a good regular expression?
       Type "cd ~/D/objs; ls | grep <your expression>" and see if it lists
       all of the synonyms of that object, and nothing else.

  2) If so, replace the contents of "~/D/obj" with a wildcard pattern that
     matches to all of the synonyms.
     - See the idea? If "~/D/obj" were to contain a pattern, then the alias's
       "mv ~/D/inv/`cat ~/D/obj`" will move all the synonyms, just like we
       want it to do.
     - But you must replace "~/D/obj" with only a single wildcard pattern.
     - Remember, the set of file names that can be in the inventory is much
       smaller than set of names shown in ~/D/objs, and your pattern only has
       to work for getable objects. So a, "cd ~/D/objs; ls <your pattern>"
       must list ALL the synonyms and must NOT list any other getable object,
       but it doesn't matter if lists any other things (such as "bed" or "pc"
       or "gate" or etc.).

As a final hint, review Lecture 6, slides 151-158, for a discussion of the
difference between a regular expression and a wildcard pattern.