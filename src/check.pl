#!/usr/bin/perl

open(IN,"A/texfiles/letter_a.tex") or die("A/texfiles/letter_a.tex");

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
	elsif($line =~ /\\bnum/)
	{
		$count++;
	}
	elsif($line =~ /\\enum/)
	{
		$count--;
	}
	elsif($line =~ /\\eentry/)
	{
		if($count != 0)
		{
			print $lno . "\n";
		}
	}
	
	
	$line = <IN>;
	$lno++;
}
