#!/bin/bash
# the simpsons
# by me
gis1=51.91
a1=54.27
b1=61.74
h1=63.33
c2=65.41
cis2=68.90
d2=73.42
dis2=77.78
e2=82.41
f2=87.31
fis2=92.50
g2=98.00
gis2=103.83
a2=110.00
b2=116.54
h2=123.47
c3=130.81
cis3=138.59
d3=146.83
dis3=155.56
e3=164.81

function play {
	SLPTIME=`echo $2 / 1000 | bc -l`
	setterm -blength $2
	setterm -bfreq $1
	echo -n -e "\a"
	sleep $SLPTIME
}
function pause {
	sleep `echo $1 / 1000 | bc -l`
}
play $d2 500
pause 250
play $fis2 250
pause 250
play $gis2 150
pause 350
play $h2 250
play $a2 500
pause 250
play $fis2 250
pause 250
play $d2 250
pause 250
play $h1 250
play $gis1 250
play $gis1 250
play $gis1 250
play $a1 250
pause 1125
play $gis1 250
play $gis1 250
play $gis1 250
play $a1 250
play $cis2 750
pause 125
play $d2 250
play $d2 250
play $d2 250
play $d2 250

function test {
	play $1 1000
}
#test $gis
#test $a
#test $ais
#test $C2
#test $C21
