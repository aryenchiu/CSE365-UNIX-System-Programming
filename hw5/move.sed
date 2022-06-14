1s/^[nsweud]$\|^[ns][ew]$/&/
ts2;
2,$bs2;
bs1;

:s1;
1i@
2,3z
s/^[dl\-].*[0-9] //
s/^[nsweud]$\|^[ns][ew]$\|^[nsweud] ->.*$\|^[ns][ew] ->.*$//
$q;n;bs1;

:s2;
s/^d.*/&->/
s/.*[0-9] //
s/^\/.*\///
s/ ->.*/->/
s/^total //
1h; 1!H;
$g; $bs3; d;

:s3;
tf;:f;

s/^\([nsweud]\|[ns][ew]\)\n.\+\(\n.*\)*\<\1->\(\n.*\)*$/cd \1/
tx;
s/^\([nsweud]\|[ns][ew]\)\n.\+\(\n.*\)*\<\1\>\(\n.*\)*$/cat \1/
tx;
bs4;

:x
q;

:s4;
s/^\([nsweud]\|[ns][ew]\)\(\n.*\)*/\1/
y/nsewud/snwedu/
x;
s/^\([nsweud]\|[ns][ew]\)\n\(\(.*\n\)*.*$\)/\2/
x;
G;


:s5;
trs;:rs

s/^\([nsweud]\|[nw][ew]\)\n\1\(\n.*\)\+/cd ../
tx;
s/^.*$/echo You can\'t go that way./
