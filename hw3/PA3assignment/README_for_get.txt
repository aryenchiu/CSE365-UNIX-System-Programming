The approach of get is to first handle printing the appropriate message, and
then to handle moving the appropriate file(s). 

The format is:
alias get='(cat >../obj;cd ->~/X;(mv __1a__ __1b__ ~/D/get &>~/X; __2__ || (cd ~/D/get; __3__ && (__4__) || (__5__ || __6__))); (cd ~/D; __7__ ; __8__ ; __9__ ; __10__ ; cd get; mv `cat ../obj` ../inv)&>~/X;mv ~/D/get/* .)2>~/X <'

Step 1: Identify 2 wild card patterns __1a__ and __1b__ that together identify
        every synonym of every gettable object, and no other objects.
	To test patterns, these try this:
          % cd ~/PA2assignment/allroomdirsandfile/
          % ls __a__ __b__
          acid      bone      chip     food       key      nitric  silver
          amethyst  bracelet  cpu      glycerine  lamp     ruby
          board     card      emerald  jar        license  shovel
          %

        Then, using patterns __1a__ & __1b__, move all of the gettable objects
	into the provide ~/D/get directory.

__2__: If there is a file in the current room that has the same name as the
       contents of "~/D/obj", then that means you tried to get an ungettable
       object, so print an error message. For example, if you entered the room
       with the bear for the first time and you typed "get bear", like this:
         % bash
         % source ./PA3.sh
         Museum station
         You are at the Museum subway stop.  A passage leads off to the north.
         >cd ~/D/rooms/n/n/u/w/s/w/w/s/se/s/e/s/s/sw/sw/se/se/; ls
         bear  descriptionY  key  se  sw
         >touch .v; cd ~/D/objs; l
         Bear hangout
         You are standing at the end of a road.  A passage leads back to the
         northwest.
         There is a bear here.
         There is a key here.
         >get bear
         You cannot take that.
         >cat ~/D/obj
         bear
         >ls ~/D/get
         >

       In the above: 
       - The current room has a bear
         - And that bear isn't getable so it did not get moved into ~/D/get
           - And so, after the move, the current room still had a bear
             - And so the error message printed. 

       But let's talk about what happened to the key, during all of this: 
       - The current room has a key
         - And that key IS getable so it DID get moved into ~/D/get
           - And so, after the move, the current room had no key
             - Then a later part of the "get" alias moved the key back to the
               current room. (This move-back was done by the "mv ~/D/get/* ."
               part of the template shown at the top of this file.) 

__3__: Test whether the ~/D/obj file contains "all"

__4__: At this point, we know the user typed "all", and we are in "~/D/get".
       Remember that, at the top of this README file, it said that messages
       come first, with the actual moving of the files being done later.
       So the job of __4__ is just to print the message for "get all".
       And what is that message?
       - It could be an error message, if "~/D/get" is an empty directory.
       - Or it could print the list of taken objects. This is done by listing
         the files from ~/D/get (but only one file per object -- no synonyms),
         then using that list as arguments to "echo Taken:", then passing the
         result into fold to format the lines to break at spaces.

__5__: At this point, we know the user typed an object (ie, didn't type all).
       The question is whether the object they typed is one that was present
       and getable. In other words, does "~/D/obj" contain the name of a file
       that is in "~/D/get"? If so, the job of __5__ is to print "Taken."
       
__6__: echo I do not see that here.    <== Type this as-as.
       This is the final possible message. Therefore, starting at __7__,
       we will be implementing the getting of objects, with no displaying.

__7__, __8__, __9__: Remember the __1__, __2__, and __3__ that you implemented
       for drop? Insert those same pieces of code into these places here.

__10__:This is very similar to __7__/__8__/__9__, but is for the case that
       "~/D/obj" contains "all". In this case, "~/D/obj" should be changed to
       contain just a "*".
