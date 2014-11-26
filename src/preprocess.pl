#!/usr/bin/perl

$file = "letter_x.tex";

open(IN, "$file") or die "Can't open $file";

$line = <IN>;

while($line)
{
	#chop($line);
	
	
	
	$line = <IN>;	
}

