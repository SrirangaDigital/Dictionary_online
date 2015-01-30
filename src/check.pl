#!/usr/bin/perl

open(IN,"D/texfiles/letter_d.tex") or die("C/texfiles/letter_d.tex");

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
	#~ elsif($line =~ /\\numi\{/)
	#~ {
		#~ $count++;
	#~ }
	#~ elsif($line =~ /\\numie/)
	#~ {
		#~ $count--;
	#~ }
	#~ elsif($line =~ /\\pron/)
	#~ {
		#~ $count++;
	#~ }
	elsif($line =~ /\\bnum/)
	{
		$count++;
	}
	elsif($line =~ /\\enum/)
	{
		$count--;
	}
	#~ elsif($line =~ /\\num/)
	#~ {
		#~ if($count == 0)
		#~ {
			#~ print $lno . "\n";			
		#~ }
	#~ }
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
