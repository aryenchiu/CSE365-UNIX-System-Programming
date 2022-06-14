1{ /^\([nsewud][ew]\{,1\}\)\>.*/bZ
     i@
     n
     z
     :Y
       /->/z
       /total/z
       s/.* //
       $d
       n
       bY
 }
:Z
1s//\1/
s/^d..*/&->/
s/ ->.*/->/
s/.*\///
s/.* //
H
$!d
g
s/.//
h
/^\([^\n]*\)\n.*\n\1\>/{
   s//\1/
   s/\n.*//
   s/\(.*\)->.*/cd \1/p
   s/^[^c]/cat &/p
   d
}
s/[^\n]*\n//
x
s/\n.*//
y/nsweud/snewdu/
G
/^\([^\n]*\)\n\1\>/ccd ..
/^c/!cecho You can\\\'t go that way.
