Your new "i" command will look like this:
alias i='(cd ~/D/inv>~/X;echo -n "You currently have: "; ls [abfgjklrs]*[^s] 2> ~/X | __1__)|__2__;echo'

As we can see above, this new version of the "i" command has all of the code
from the PA2 solution, but it also has added some new code in two places.
To understand the difference, it helps to show the effect of the difference.
To show this, my version of PA3 (you don't need to put it into your version)
has an alias for the PA2's "i" also. Let's compare their outputs:
  % bash
  % source ./teachersPA3.sh
  Museum station
  You are at the Museum subway stop.  A passage leads off to the north.
  >cd ~/D/inv
  >touch amethyst glycerine nitric acid jar ruby bone silver license cpu chip card board shovel key food emerald bracelet
  >ls
  acid      bone      chip     food       key      nitric  silver
  amethyst  bracelet  cpu      glycerine  lamp     ruby
  board     card      emerald  jar        license  shovel
  >iFromPA2
  You currently have: acid          board  bracelet  glycerine  key   license  shovel
  amethyst  bone   food      jar        lamp  ruby     silver
  >i
  You currently have: acid, amethyst, board, bone, bracelet, food, glycerine,
  jar, key, lamp, license, ruby, shovel, silver.
  >

As you can see, the new output looks better. So, how to do it? In answering
that, it is helpful to see what the behavior would be without the __1__ or
__2__. But we can't just leave those parts empty, because they are each fed
by a pipe. That is to say, "i" is defined above as: '(cd ~/D/inv>~/X;echo -n
"You currently have: "; ls [abfgjklrs]*[^s] 2> ~/X | __1__)|__2__;echo'.

So we don't want empty __1__ or __2__, but rather versions that pass on their
inputs. If you think about it, that effect can be achieved with a "grep ^".
So my version of PA3 (you don't need to put it into your version) has defined
different versions of "i" to see their effects. Let's see that (assuming the
directory is still ~/D/inv, from the running the commands presented earlier):
  >ls
  acid      bone      chip     food       key      nitric  silver
  amethyst  bracelet  cpu      glycerine  lamp     ruby
  board     card      emerald  jar        license  shovel
  >iButWith__1__and__2__BothJustPassingOnTheirInput
  You currently have: acid
  amethyst
  board
  bone
  bracelet
  food
  glycerine
  jar
  key
  lamp
  license
  ruby
  shovel
  silver
  
  >iWith__1__implementedButWith__2__JustPassingOnItsInput
  You currently have: acid, amethyst, board, bone, bracelet, food, glycerine, jar, key, lamp, license, ruby, shovel, silver
  .

  >

THE DISCUSSION OF __1__:
From the above, we see that the __1__ is responsible for separating the items
by commas. This is a three-step process: 1) Turn each "\n" into a ", ", then
2) remove the final ", " after the last item, and then 3) add a ".".

As for 1): Use "u2d" and "tr" to accomplish this.

As for 2): This is harder. What we want is to remove the final two characters
           from the received text line. But to accomplish this, we can only
           use commands that we have already discussed in lecture.
           How to do it?
             Well, the "cut" command seems promising. It can remove specific
             characters from the input line. For example, if we use the proper
             arguments and flags, we can tell "cut" to remove the FIRST TWO
             characters of the line.
           But, how to get it to remove the LAST TWO characters?
             This is harder, because we do not know how many characters will
             be in the line (since the contents of the inventory can change).
             The answer is to use the "rev" command to move the characters
             from the end of the line over to the front, then to run "cut",
             and then to use "rev" again to put the line back in proper order.
             (Lecture 1, slide 21, introduced "rev", calling it one of the
             "commands which can be useful, but which I won't put on the exam"
             So the homework can use "rev", I just won't put it on the exam.)

As for 3): Just "echo .". But don't pipe the input into this echo.


THE DISCUSSION OF __2__:
To see what the __2__ does, let's see its effect:
  >iWith__1__implementedButWith__2__JustPassingOnItsInput
  You currently have: acid, amethyst, board, bone, bracelet, food, glycerine, jar, key, lamp, license, ruby, shovel, silver
  .

  >i
  You currently have: acid, amethyst, board, bone, bracelet, food, glycerine,
  jar, key, lamp, license, ruby, shovel, silver.
  >

From the above, we see that the __2__ moved the "." onto the same line as the
items, and it fixed the formatting, so a long list of items nicely wraps onto
two lines (i.e., it doesn't split words, but instead splits lines at spaces).
You will accomplish this by using "fold". (As with "rev", so also was "fold"
introduced in Lecture 1 slide 21, as one of the "commands which can be useful,
but which I won't put on the exam." So the homework can use "fold", I just
won't put it on the exam.)
