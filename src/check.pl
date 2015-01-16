#!/usr/bin/perl

open(IN,"B/texfiles/letter_b.tex") or die("B/texfiles/letter_b.tex");

$line = <IN>;
$count = 0;
$lno = 1;

while($line)
{
	chop($line);
	
	if($line =~ /\\bentry/)
	{
		$count = 0;
	}
	elsif($line =~ /\\pron/)
	{
		$count++;
	}
	#~ elsif($line =~ /\\bnum/)
	#~ {
		#~ $count++;
	#~ }
	#~ elsif($line =~ /\\enum/)
	#~ {
		#~ $count--;
	#~ }
	elsif($line =~ /\\eentry/)
	{
		if($count == 0)
		{
			print $lno . "\n";
		}
	}
	
	
	$line = <IN>;
	$lno++;
}
