#!/bin/bash

c=0
for i in $(ls E/Pictures/main/*.jpg); 
	do 
		#~ c=`expr $c + 1`;
		#~ result=`expr $c % 3`
		jpgfilename=`basename $i`
		echo $jpgfilename
		convert -resize 40x $i E/Pictures/thumbs/$jpgfilename; 
	done


