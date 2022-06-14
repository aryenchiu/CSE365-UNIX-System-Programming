#!/usr/bin/tcsh
#If needed, the above line may be changed to #!/usr/bin/csh, #!/bin/tcsh, etc.
#The following two lines are included to remind you to use them for debugging:
#  set echo
#  set verbose

source ~/PA4assignment/PA4init.csh

while ( 1 )

  #Section For Command Input:
  while ( 1 )
    echo -n ">"
    set com = $<:q
    set com = ( $com )
    if ( $#com > 0 ) break
  end

  #Section For Movement:
  if ( ( $com[1] =~ "[nsweud]" ) || ( $com[1] =~ "[ns][ew]" ) ) then
    if ( -f $com[1] ) then
      if ( ( -f ../w/vax ) && ( -f ~/D/inv/key ) ) then
        cd ..; cd `pwd -P`; disp
      else
	cat $com[1]
        expr $com[1] == se >~/X && exit
      endif
    else if ( ( -d $com[1] ) || ( -l $com[1] ) ) then
      cd $com[1]; cd `pwd -P`; disp
    else if ( `pwd | sed 's_.*/__'|tr nsewud snwedu` == $com[1] ) then
      cd ..; disp
    else
      echo You cannot go that way.
    endif
    continue

  #Section for All Other Argument-Free Commands
  else if ( $com[1] == quit ) then
    echo @You have scored 0 out of a possible 90 points.|tr @ \\n && exit
  else if ( ( $com[1] == i) || ( $com[1] == inventory ) ) then
    cd ~/D/inv; echo "You currently have:"; invitems; cdcont
  else if ( ( ( $com[1] == l) || ( $com[1] == look ) || \
              ( $com[1] == x) || ( $com[1] == examine ) ) && $#com == 1 ) then
    rm .v >& ~/X; disp; continue
  else if ( $com[1] == dig ) then
    if ( ( -e ~/D/inv/shovel ) && ( -e .cpu ) ) then
      mv .cpu cpu; cp cpu board; cp cpu card; cp cpu chip
      echo I think you found something. && continue
    else if ( -e ~/D/inv/shovel ) then
      echo Digging here reveals nothing. && continue
    else
      echo You have nothing with which to dig. && continue
    endif
  endif
  
  #Section To Check For A Valid Command:
  foreach c ( l look x examine drop throw take get i inventory put )
    if ( $c == $com[1] ) break
  end
  if ( $c != $com[1] ) then
    echo I don\'t understand that. && continue
  endif

  #Section To Check For A Valid Object:
  if ( $#com == 1 ) then
     echo You must supply an object. && continue
  else if ( ( ! -e ~/D/objs/$com[2] ) || \
            ( ( $com[2] == all ) && ( $c !~ "[gt][ea]*" ) ) ) then
     echo I do not know what that is. && continue
  else if ( ( $c =~ "[dpt][rhu]*" ) &&  ( ! ( -e ~/D/inv/$com[2] ) ) ) then
     echo You don\'t have that. && continue
  else if ( ! ( -e $com[2] ) ) then
     if ( $c =~ "[gt][ea]*" ) then
        if ( $com[2] != all ) then
	   if ( ! -e ~/D/inv/jar/$com[2] ) then
              echo I do not see that here. && continue
           endif
        endif
     else if ( ( ! ( -e ~/D/inv/$com[2]) ) && \
               ( ! ( -e ~/D/inv/jar/$com[2]) ) ) then
        echo I don\'t see that here. && continue
     endif
  endif

  #Section To Operate On An Object:
  switch ( $c )
  
    #Section To handle "x" (and its synonyms):
    case l:
    case look:
    case x:
    case examine:
      if ( $com[2] == jar ) echo It is a plain glass jar.
      if ( -f $com[2] ) cat $com[2]
      if ( -f ~/D/inv/$com[2] ) cat ~/D/inv/$com[2]
      if ( -f ~/D/inv/jar/$com[2] ) cat ~/D/inv/jar/$com[2]
      continue

    #Section To handle "drop" (and its synonym):
    case drop:
    case throw:
      mv ~/D/inv/$com[2] . && echo Done.
      if ( ( $com[2] == food ) && ( -e bear ) ) then
        rm f* se bear &&mv .key key &&echo The bear takes the food and runs \
                                      away with it.  He left something behind.
      else if ( $com[2] == jar ) then
        if ( `ls jar | wc -l` == 3 ) then
          rm -R jar && echo As the jar impacts the ground it explodes into \
	                  many pieces.
	endif
      endif
      continue
      
    #Section To handle "get" (and its synonym):
    case get:
    case take:
      # Section To Handle Getting Something Out Of The Jar.
      # Note: I have tested the original game, and you can only get things out
      # of the jar if you are holding the jar.
      mv ~/D/inv/jar/$com[2] ~/D/inv/$com[2] >& ~/X && \
          echo You remove it from the jar. && continue

      mv [bceln][ahiom][^n]*[^nsrt] *[^handrest]?[dirtypuddle] ~/D/get >& ~/X
      if ( -e $com[2] ) then
        mv ~/D/get/* . >& ~/X
	echo You cannot take that. && continue
      endif
      cd ~/D/get
      # Section To Handle "get all"
      # In the code below, __1__ checks for "all", __2__ checks whether the
      # present directory (~/D/get) is empty, __3__ is many sed "s" commands
      # for displaying the objects (eg, "acid" -> "Some nitric acid: Taken."),
      # and __4__ moves the objects into the inventory.
      if ( $com[2] == all ) then
        expr `ls | wc -l` == 0 >& ~/X && echo Nothing to take. && cdcont
        (invitems) | sed 's/$/: Taken./;/^[T ]/d' && mv * ~/D/inv && cdcont
      endif
      
      # Section To Handle All Other Gets.
      # To remind, the code in PA3 for handling objects with aliases was:
      #  (cd ~/D;grep "^[cb][apho].*[upd]$" obj &&echo "[cb][apho]*[upd]">obj;
      #          grep "^[be][mr].*" obj&& echo "[be][mr]*">obj;
      #          grep "^[na][ic].*" ~/D/obj && echo "[na][ic]*" > obj; ...
      #          cd get; mv `cat ../obj` ../inv ) &>~/X; mv ~/D/get/*
      # Now in this new homework, there is no ~/D/obj file. Instead the name
      # of the object is identified as the 2nd element of the command array.
      # The wildcard patterns to put in the blanks below are similar to the
      # regular expression patterns used in PA3 (ie, the "^[cb][apho]*[upd]$",
      # "^[be][mr].*", and "^[na][ic].*" patterns I just reminded you about).
      echo Taken.
      if ( $com[2] =~ "[be][mr]*" ) then
         mv [be][mr]* ~/D/inv
      else if ( $com[2] =~ "[na][ic]*" ) then
         mv [na][ic]* ~/D/inv
      else if ( $com[2] =~ "[cb][apho]*[upd]" ) then
         mv [cb][apho]*[upd] ~/D/inv
      else 
         mv $com[2] ~/D/inv
      endif
      cd - >&~/X;
      mv ~/D/get/* . >& ~/X
      continue
      
    #Section To handle "put":
    case put:
      #Section To test the indirect object
      if ( $#com < 4 ) then
        echo You must supply an indirect object. && continue
      else if ( ! -e ~/D/objs/$com[4] ) then
        echo I do not know what that indirect object is. && continue
      endif
      unset indpath
      if ( -e $com[4] ) set indpath = ./
      if ( -e ~/D/inv/$com[4] ) set indpath = ~/D/inv/
      expr $?indpath == 0 >& ~/X && echo That indirect object is not here. &&\
         continue
      if ( ( $com[4] =~ "[ivc][bao][mxb]*" ) && ($com[2] =~ "[cb][aohp][riu]*" ) ) then
         echo As you put the CPU board in the computer, it immediately springs to life.
         echo The lights start flashing, and the fans seem to startup.
         rm ~/D/inv/[cb][aohp][riu]*
         sed 's/steady.*/flashing in a seemingly organized pattern./'>X <des*
	 mv X descriptionR
      else if ( ( $com[4] != jar ) || ($com[2] !~ "[agn][cli]*" ) ) then
         echo I don\'t know how to combine those objects.  Perhaps you should
         echo just try dropping it.
      else if ( $com[2] == glycerine ) then
         mv ~/D/inv/$com[2] $indpath/jar && echo Done.
      else
         mv ~/D/inv/[na][ic]* $indpath/jar && echo Done.
      endif
      continue
  endsw
end
