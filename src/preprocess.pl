#!/usr/bin/perl

$file = "X/texfiles/letter_x.tex";
$output = "X/html/x_uni.html";
$pictfile = "X/texfiles/x_figs_list.tex";
$indexfile = "X/texfiles/indexofletterx.tex";
$label = "xid";

open(IN, "$file") or die "Can't open $file";
open(OUT, ">$output") or die "Can't open $output";
open(IDX, "$indexfile") or die "Can't open $indexfile";

@indexlist = <IDX>;

close(IDX);


$line = <IN>;
$wordid = 0;


$preamble = "<!doctype html>
<html lang=\"en\" class=\"no-js\">
<head>
	<meta charset=\"UTF-8\">
	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
	<link rel=\"stylesheet\" href=\"../../../css/reset.css\"> <!-- CSS reset -->
	<link rel=\"stylesheet\" href=\"../../../css/style.css\"> <!-- Resource style -->
	<script type=\"text/x-mathjax-config\">
	  MathJax.Hub.Config({
		tex2jax: {inlineMath: [[\"\$\",\"\$\"],[\"\\\\(\",\"\\\\)\"]]}
	  });
	</script>
	<script type=\"text/javascript\" src=\"../../../MathJax/MathJax.js?config=TeX-AMS_HTML-full\"></script>
	<title>Univerity of Mysore - English Kannada Dictionary</title>
</head>
<body>
	<header class=\"cd-header\">
		<div id=\"cd-logo\">
			<a href=\"#0\">
				<img src=\"../../../img/logo.png\" alt=\"Logo\">
				<span>UNIVERSITY OF MYSORE</span>
			</a>
		</div>

		<nav class=\"cd-main-nav\">
			<ul>
				<li><a href=\"#0\">Home</a></li>
				<li><a href=\"#0\">Dictionary</a></li>
			</ul>
		</nav> <!-- cd-main-nav -->
	</header>

	<main class=\"cd-main-content\">
		<div class=\"cd-scrolling-bg cd-color-2\">
			<div class=\"cd-container\">
				<h1 class=\"clr1\">English - Kannada Dictionary</h1>
                <h2>ಇಂಗ್ಲಿಷ್ - ಕನ್ನಡ ನಿಘಂಟು</h2>";

$post = "			</div> <!-- cd-container -->
		</div> <!-- cd-scrolling-bg -->
	</main> <!-- cd-main-content -->
</body>
</html>";

print OUT $preamble . "\n";

while($line)
{
	chop($line);

	$line =~ s/\\,//g;
	$line =~ s/\\;//g;
	$line =~ s/\\kern1pt//g;
	$line =~ s/\\quad//g;
	$line =~ s/[\s]+/ /g;

	#$line =~ s/\\hyperlink\{(.*)\}\{\\raisebox\{(.*)\}\[(.*)\]\[(.*)\]\{\\pdfimage(.*)\{([A-Z]_Pictures)\/(.*).jpg}}}/\6\/\7.jpg/g;
	
	if($line =~ /\\bentry/)
	{
		$wordid++;
		print OUT "<div class=\"word\">\n";
	}
	elsif($line =~ /\\eentry/)
	{
		print OUT "</div>\n";
	}
	elsif($line =~ /\\word\{(.*)\}/)
	{
		print OUT "<div class=\"whead\" id=\"". $label . $wordid . "\">\n";
			print OUT "\t<span class=\"engWord clr1\">".  $1 ."</span>\n";
	}
	elsif($line =~ /\\word\[(.*)\]\{(.*)\}/)
	{
		print OUT "<div class=\"whead\" id=\"". $label . $wordid . "\">\n";
			print OUT "\t<span class=\"engWord clr1\">".  $2 ."</span>\n";
	}
	elsif($line =~ /\\wordwithhyphen\{(.*)\}\{(.*)\}/)
	{
		print OUT "<div class=\"whead\" id=\"". $label . $wordid . "\">\n";	
			print OUT "\t<span class=\"engWord clr1\">".  $2 ."</span>\n";
	}	
	elsif($line =~ /\\wordnospeech\{(.*)\}\{(.*)\}/)
	{
		print OUT "<div class=\"whead\" id=\"". $label . $wordid . "\">\n";			
			print OUT "\t<span class=\"engWord clr1\">".  $2 ."</span>\n";
	}
	elsif($line =~ /\\pron\{(.*)\}/)
	{
		$pron = $1;
		if($pron ne "?")
		{			
			if($pron =~ /Z|Yx/)
			{
				if(!(-e "X/pronunciation/". $label . $wordid . ".png"))
				{
					gen_png($pron);
				}
				$pron =~ s/Z//g;
				$pron =~ s/Yx/yx/g;
				$pront =~ s/\\kern1pt//g;
				
				print OUT "\t<span class=\"kanWord\"><img src=\"../pronunciation/" . $label . $wordid . ".png\" alt=\"". gen_unicode($pron) ."\" /></span><br />\n";
			}
			else
			{
				print OUT "\t<span class=\"kanWord\">". gen_unicode($pron) ."</span><br />\n";
			}
		}
		else
		{
			print OUT "\t<span class=\"kanWord\"></span><br />\n";
		}
		#print OUT "<span class=\"kanWord\">". gen_unicode($1) ."</span>\n";
	}
	elsif($line =~ /\\gl\{(.*)\}/)
	{
		$gl = preprocess($1);
		$gl = gen_unicode($gl);
		print OUT "\t<span class=\"grammarLabel\">". $gl ."</span>\n";
		print OUT "</div>\n";
	}
	elsif($line =~ /\\bmng/)
	{
		print OUT "<div class=\"wBody\">\n";	
	}
	elsif($line =~ /\\emng/)
	{
		print OUT "</div>\n";	
	}
	elsif($line =~ /\\bnum/)
	{
		print OUT "<ol>\n";	
	}
	elsif($line =~ /\\enum/)
	{
		print OUT "</ol>\n";	
	}
	elsif($line =~ /\\banum/)
	{
		print OUT "<ol class=\"alph\">\n";	
	}
	elsif($line =~ /\\eanum/)
	{
		print OUT "</ol>\n";	
	}
	elsif($line =~ /\\num\{[0-9]+\}(.*)/)
	{
		$numline = preprocess($1);
		$numline = gen_unicode($numline);
		print OUT "<li>". $numline  ."</li>\n";
	}
	elsif($line =~ /\\alnum\{[a-z]\}(.*)/)
	{
		$numline = preprocess($1);
		$numline = gen_unicode($numline);
		print OUT "<li>". $numline  ."</li>\n";
	}
	elsif($line =~ /^%/)
	{
		
	}
	else
	{
		if(!($line =~ /^[\s]+$|^$/))
		{
			$line = preprocess($line);
			$line = gen_unicode($line);
			print OUT "<p>" . $line . "</p>\n";		
		}
	}
	
	$line = <IN>;	
}


output_pictures();

print OUT $post;

close(IN);
close(OUT);

sub output_pictures()
{
	open(FIGS, "$pictfile") or die "Can't open $pictfile\n";
	
	$pictline = <FIGS>;
	
	print OUT "<div class=\"images_list\">\n";
	
	while($pictline)
	{
		chop($pictline);
		
		if($pictline =~ /\\hypertarget\{(.*)\}\{\}/)
		{			
			$pictid = $1;
			print OUT "\t<div class=\"img_display\" id=\"$pictid\">\n";
				
		}
		elsif($pictline =~ /\\pdfimage\{([A-Z])_Pictures\/(.*)\.jpg\}\}\\hfill\}/)
		{
			$pictalpha = $1;
			$pictname = $2;
			print OUT "\t\t<div><img src=\"../Pictures/$pictname.jpg\" alt=\"$pictname\"/></div>\n";
		}
		elsif($pictline =~ /\\caption\{\\eng\{(.*)\}\}/)
		{
			$caption = $1;
			print OUT "\t\t<div class=\"fig_caption\">$caption</div>\n";
			print OUT "\t</div>\n";
		}
	
		$pictline = <FIGS>;
	}
	
	print OUT "</div>\n";
	close(FIGS);
}

sub gen_unicode()
{	
	my($kan_str) = @_;
	open(TMP, ">tmp.txt") or die "Can't open tmp.txt\n";
	my ($tmp,$flg,$i,$endash_uni,$endash,$flag);
	$flg = 1;

	$kan_str =~ s/\\bf//g;
	$kan_str =~ s/\{\\yoghsymb\\char178\}/!E!&#x021D;!K!/g;
	$kan_str =~ s/\\num\{(.*?)\}//g;
	$kan_str =~ s/\\ralign\{(.*?)\}/!E! $ralign_btag !K! $1 !E! $ralign_etag !K! /g;
	$kan_str =~ s/\\char'263/!E!&#x0CBD;!K!/g;
	$kan_str =~ s/\\char'365/!E!&#x0CC4;!K!/g;
	$kan_str =~ s/\\char'273/!E!&#x0CB1;!K!/g;
	$kan_str =~ s/\\s /!E!&#x0CBD;!K!/g;
	$kan_str =~ s/RV/VR/g;
	$kan_str =~ s/qq/q/g;
	$kan_str =~ s/Ryx/yxR/g;
	$kan_str =~ s/RyX/yxR/g;
	$kan_str =~ s/Rq/qR/g;
	$kan_str =~ s/RY/YR/g;
	$kan_str =~ s/\\cdots/!E!&#x2026;!K!/g;

	$flag = 1;
	while($flag)
	{
		#print "HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH\n";
		if($kan_str =~ /\{\\rm (.*?)\}/)
		{
			$kan_str =~ s/\{\\rm (.*?)\}/!E!\1!K!/;
		}
		elsif($kan_str =~ /\\eng\{(.*?)\}/)
		{
			$kan_str =~ s/\\eng\{(.*?)\}/!E!\1!K!/;
		}
		elsif($kan_str =~ /\\imglink\{(.*)\}\{\\raisebox(.*)\{([A-Z])_Pictures\/(.*)\.jpg\}\}\}/)
		{
			$kan_str =~ s/\\imglink\{(.*?)\}\{\\raisebox(.*?)\{([A-Z])_Pictures\/(.*?)\.jpg\}\}\}/!E!<span class="crossref"><a href="#\4fig">Figure<\/a><\/span>!K!/;
		}
		elsif($kan_str =~ /\\ecrlink\{(.*?)\}\{(.*?)\}/)
		{
			$word = $1;
			$id = get_index($word);
			
			$kan_str =~ s/\\ecrlink\{(.*?)\}\{(.*?)\}/!E!<span class="crossref"><a href="#$id">\2<\/a><\/span>!K!/;
		}
		elsif($kan_str =~ /\\ecrref\{kandict_[a-z]\.pdf\}\{[A-Z]\}\{(.*?)\}\{(.*?)\}/)
		{
			$kan_str =~ s/\\ecrref\{kandict_[a-z]\.pdf\}\{[A-Z]\}\{(.*?)\}\{(.*?)\}/!E!<span class="crossref"><a href="#">\2<\/a><\/span>!K!/g;
		}
		#~ elsif($kan_str =~ /\$(.*?)\$/)
		#~ {
			#~ $kan_str =~ s/\$(.*?)\$/!E! \1 !K!/;
			#~ $kan_str =~ s/\^\\circ/&#xB0;/g;
		#~ }
		else
		{
			$flag = 0;
		}
	}

	$kan_str =~ s/\{//g;
	$kan_str =~ s/\}//g;

	
	#print $kan_str . "\n";
	
	#$endash = "&#x2014";
	#$endash_uni = chr(hex($endash));
	
	print TMP $kan_str;
	close(TMP);
	
	system("./tmp.o tmp.txt > tmp1.txt");
	open(UN, "tmp1.txt") or die "Can't open tmp1.txt\n";	
	my $uni_str = <UN>;
	close(UN);
	
	#print FOUT $uni_str . "\n";
	
	
	
	my($decval,$val,$p);
	$uni_str =~ s/<br>//g;
	$uni_str =~ s/<\/br>//g;
	$uni_str =~ s/---/&#x2014;/g;
	$uni_str =~ s/--/&#x2013;/g;
	$uni_str =~ s/\|/&#x007C;/g;
	$uni_str =~ s/``/&#x201C;/g;	
	$uni_str =~ s/''/&#x201D;/g;
	$uni_str =~ s/`/&#x2018;/g;
	$uni_str =~ s/'/&#x2019;/g;
	$uni_str =~ s/&nbsp;/&#xa0;/g;
	#$uni_str =~ s/(&#x0CCD;)(&#x200C;)(&#x0C97;)(&#x0CCD;)/\1\3\4/;
		
	while($flg)
	{
		if($uni_str =~ /&#x([0-9A-F]+);/)
		{
			$val = $1;	
			$p = chr(hex($val));
			$uni_str =~ s/&#x$val;/$p/g;
		}
		else
		{
			$flg = 0;
		}
	}	

	#$uni_str =~ s/\bಸರ್‍\b/ಸರ್/g;
	
	return $uni_str;
}

sub get_index()
{
	my($word) = @_;
	my($i);
	
	for($i=0;$i<@indexlist;$i++)
	{
		if($indexlist[$i] =~ /\{$word\}/)
		{
			return "$label" . ($i+1);
		}
	}
	
}


sub gen_png()
{
	my($pron) = @_;
	
	open(FOUT,">tmp1.tex") or die "Can' open tmp1.tex";
	
	print FOUT '\documentclass{article}';
	print FOUT '\usepackage{kanlel}';
	print FOUT '\usepackage[active]{preview}';
	print FOUT '\begin{document}';
	print FOUT '\begin{preview}';
	print FOUT '{\bf ' . $pron . '}';
	print FOUT '\end{preview}';
	print FOUT '\end{document}';
	
	close(FOUT);
	
	$pngname = $label . $wordid . ".png";
	system("latex tmp1.tex ;  dvipng -T tight -D 144.54 -o tmp1.png tmp1.dvi ; mv tmp1.png X/pronunciation/$pngname");
	
	
}

sub preprocess()
{
	my($line) = @_;

$line =~ s/\\Ir /\\eng\{Irish\}/g;
$line =~ s/\\Ir\\ /\\eng\{Irish\} /g;
$line =~ s/\\Ir/\\eng\{Irish\}/g;

$line =~ s/\\It /\\eng\{Italian\}/g;
$line =~ s/\\It\\ /\\eng\{Italian\} /g;
$line =~ s/\\It/\\eng\{Italian\}/g;

$line =~ s/\\uparx /\{\\bf utatxraparxtayxya\}/g;
$line =~ s/\\uparx\\ /\{\\bf utatxraparxtayxya\} /g;
$line =~ s/\\uparx/\{\\bf utatxraparxtayxya\}/g;

$line =~ s/\\upa /\{\\bf upasagaR\}/g;
$line =~ s/\\upa\\ /\{\\bf upasagaR\} /g;
$line =~ s/\\upa/\{\\bf upasagaR\}/g;

$line =~ s/\\ucAcx /ucAcxraNe/g;
$line =~ s/\\ucAcx\\ /ucAcxraNe /g;
$line =~ s/\\ucAcx/ucAcxraNe/g;

$line =~ s/\\udA /udAharaNege/g;
$line =~ s/\\udA\\ /udAharaNege /g;
$line =~ s/\\udA/udAharaNege/g;

$line =~ s/\\UK /\\eng\{United Kingdom\}/g;
$line =~ s/\\UK\\ /\\eng\{United Kingdom\} /g;
$line =~ s/\\UK/\\eng\{United Kingdom\}/g;

$line =~ s/\\Eva /Ekavacana/g;
$line =~ s/\\Eva\\ /Ekavacana /g;
$line =~ s/\\Eva/Ekavacana/g;

$line =~ s/\\F /\\eng\{French\}/g;
$line =~ s/\\F\\ /\\eng\{French\} /g;
$line =~ s/\\F/\\eng\{French\}/g;

$line =~ s/\\aupa /aupacArika/g;
$line =~ s/\\aupa\\ /aupacArika /g;
$line =~ s/\\aupa/aupacArika/g;

$line =~ s/\\aushA /auSadhashAsatxrX/g;
$line =~ s/\\aushA\\ /auSadhashAsatxrX /g;
$line =~ s/\\aushA/auSadhashAsatxrX/g;

$line =~ s/\\aMrashA /aMgaracanAshAsatxrX/g;
$line =~ s/\\aMrashA\\ /aMgaracanAshAsatxrX /g;
$line =~ s/\\aMrashA/aMgaracanAshAsatxrX/g;

$line =~ s/\\aM /aMkagaNita/g;
$line =~ s/\\aM\\ /aMkagaNita /g;
$line =~ s/\\aM/aMkagaNita/g;

$line =~ s/\\akirx /\{\\bf akamaRka kirxyApada\}/g;
$line =~ s/\\akirx\\ /\{\\bf akamaRka kirxyApada\} /g;
$line =~ s/\\akirx/\{\\bf akamaRka kirxyApada\}/g;

$line =~ s/\\anw /anwpacArika/g;
$line =~ s/\\anw\\ /anwpacArika /g;
$line =~ s/\\anw/anwpacArika/g;

$line =~ s/\\ame /amerikanf parxyoVga/g;
$line =~ s/\\ame\\ /amerikanf parxyoVga /g;
$line =~ s/\\ame/amerikanf parxyoVga/g;

$line =~ s/\\ati /atishayoVkitx/g;
$line =~ s/\\ati\\ /atishayoVkitx /g;
$line =~ s/\\ati/atishayoVkitx/g;

$line =~ s/\\athaRshA /athaRshAsatxrX/g;
$line =~ s/\\athaRshA\\ /athaRshAsatxrX /g;
$line =~ s/\\athaRshA/athaRshAsatxrX/g;

$line =~ s/\\alaMshA /alaMkArashAsatxrX/g;
$line =~ s/\\alaMshA\\ /alaMkArashAsatxrX /g;
$line =~ s/\\alaMshA/alaMkArashAsatxrX/g;

$line =~ s/\\avayx /\{\\bf avayxya\}/g;
$line =~ s/\\avayx\\ /\{\\bf avayxya\} /g;
$line =~ s/\\avayx/\{\\bf avayxya\}/g;

$line =~ s/\\ashi /ashiSaTx/g;
$line =~ s/\\ashi\\ /ashiSaTx /g;
$line =~ s/\\ashi/ashiSaTx/g;

$line =~ s/\\asaM /asaMsakxqqta/g;
$line =~ s/\\asaM\\ /asaMsakxqqta /g;
$line =~ s/\\asaM/asaMsakxqqta/g;

$line =~ s/\\AMiM /AYxMgolxV iMDiyanf/g;
$line =~ s/\\AMiM\\ /AYxMgolxV iMDiyanf /g;
$line =~ s/\\AMiM/AYxMgolxV iMDiyanf/g;

$line =~ s/\\AKAyx /\{\\bf AKAyxtaka parxyoVga\}/g;
$line =~ s/\\AKAyx\\ /\{\\bf AKAyxtaka parxyoVga\} /g;
$line =~ s/\\AKAyx/\{\\bf AKAyxtaka parxyoVga\}/g;

$line =~ s/\\Agu /\{\\bf AKAyxtaka guNavAcaka\}/g;
$line =~ s/\\Agu\\ /\{\\bf AKAyxtaka guNavAcaka\} /g;
$line =~ s/\\Agu/\{\\bf AKAyxtaka guNavAcaka\}/g;

$line =~ s/\\AtAmx /AtAmxthaRka/g;
$line =~ s/\\AtAmx\\ /AtAmxthaRka /g;
$line =~ s/\\AtAmx/AtAmxthaRka/g;

$line =~ s/\\AmA /ADumAtu/g;
$line =~ s/\\AmA\\ /ADumAtu /g;
$line =~ s/\\AmA/ADumAtu/g;

$line =~ s/\\AyA /AkAshayAna/g;
$line =~ s/\\AyA\\ /AkAshayAna /g;
$line =~ s/\\AyA/AkAshayAna/g;

$line =~ s/\\AseTxrXV /AseTxrXVliya/g;
$line =~ s/\\AseTxrXV\\ /AseTxrXVliya /g;
$line =~ s/\\AseTxrXV/AseTxrXVliya/g;

$line =~ s/\\kanmu /muKayxvAgi/g;
$line =~ s/\\kanmu\\ /muKayxvAgi /g;
$line =~ s/\\kanmu/muKayxvAgi/g;

$line =~ s/\\kanu /utatxra/g;
$line =~ s/\\kanu\\ /utatxra /g;
$line =~ s/\\kanu/utatxra/g;

$line =~ s/\\kaparx /kamaRNiparxyoVga/g;
$line =~ s/\\kaparx\\ /kamaRNiparxyoVga /g;
$line =~ s/\\kaparx/kamaRNiparxyoVga/g;

$line =~ s/\\kAparx /kAvayxparxyoVga/g;
$line =~ s/\\kAparx\\ /kAvayxparxyoVga /g;
$line =~ s/\\kAparx/kAvayxparxyoVga/g;

$line =~ s/\\kiVvi /kiVTavijAcnxna/g;
$line =~ s/\\kiVvi\\ /kiVTavijAcnxna /g;
$line =~ s/\\kiVvi/kiVTavijAcnxna/g;

$line =~ s/\\kirxvi /\{\\bf kirxyAvisheVSaNa\}/g;
$line =~ s/\\kirxvi\\ /\{\\bf kirxyAvisheVSaNa\} /g;
$line =~ s/\\kirxvi/\{\\bf kirxyAvisheVSaNa\}/g;

$line =~ s/\\kirxpU /kirxsatxpUvaR/g;
$line =~ s/\\kirxpU\\ /kirxsatxpUvaR /g;
$line =~ s/\\kirxpU/kirxsatxpUvaR/g;

$line =~ s/\\kirxsha /kirxsatxshaka/g;
$line =~ s/\\kirxsha\\ /kirxsatxshaka /g;
$line =~ s/\\kirxsha/kirxsatxshaka/g;

$line =~ s/\\kirx /\{\\bf kirxyApada\}/g;
$line =~ s/\\kirx\\ /\{\\bf kirxyApada\} /g;
$line =~ s/\\kirx/\{\\bf kirxyApada\}/g;

$line =~ s/\\kerxY /kerxYsatxdhamaR/g;
$line =~ s/\\kerxY\\ /kerxYsatxdhamaR /g;
$line =~ s/\\kerxY/kerxYsatxdhamaR/g;

$line =~ s/\\Kani /KanijashAsatxrX/g;
$line =~ s/\\Kani\\ /KanijashAsatxrX /g;
$line =~ s/\\Kani/KanijashAsatxrX/g;

$line =~ s/\\KaBw /KagoVLa BwtavijAcnxna/g;
$line =~ s/\\KaBw\\ /KagoVLa BwtavijAcnxna /g;
$line =~ s/\\KaBw/KagoVLa BwtavijAcnxna/g;

$line =~ s/\\Kavi /KagoVLa vijAcnxna/g;
$line =~ s/\\Kavi\\ /KagoVLa vijAcnxna /g;
$line =~ s/\\Kavi/KagoVLa vijAcnxna/g;

$line =~ s/\\gaNi /gaNigArike/g;
$line =~ s/\\gaNi\\ /gaNigArike /g;
$line =~ s/\\gaNi/gaNigArike/g;

$line =~ s/\\gaparx /gataparxyoVga/g;
$line =~ s/\\gaparx\\ /gataparxyoVga /g;
$line =~ s/\\gaparx/gataparxyoVga/g;

$line =~ s/\\garxMshA /garxMthAlayashAsatxrX/g;
$line =~ s/\\garxMshA\\ /garxMthAlayashAsatxrX /g;
$line =~ s/\\garxMshA/garxMthAlayashAsatxrX/g;

$line =~ s/\\ga /gaNita/g;
$line =~ s/\\ga\\ /gaNita /g;
$line =~ s/\\ga/gaNita/g;

$line =~ s/\\gArxM /gArxMthika parxyoVga/g;
$line =~ s/\\gArxM\\ /gArxMthika parxyoVga /g;
$line =~ s/\\gArxM/gArxMthika parxyoVga/g;

$line =~ s/\\gArx /gArxmayxparxyoVga/g;
$line =~ s/\\gArx\\ /gArxmayxparxyoVga /g;
$line =~ s/\\gArx/gArxmayxparxyoVga/g;

$line =~ s/\\girxVca /girxVkf cariterx/g;
$line =~ s/\\girxVca\\ /girxVkf cariterx /g;
$line =~ s/\\girxVca/girxVkf cariterx/g;

$line =~ s/\\girxVpu /girxVkf purANa/g;
$line =~ s/\\girxVpu\\ /girxVkf purANa /g;
$line =~ s/\\girxVpu/girxVkf purANa/g;

$line =~ s/\\gu /\{\\bf guNavAcaka\}/g;
$line =~ s/\\gu\\ /\{\\bf guNavAcaka\} /g;
$line =~ s/\\gu/\{\\bf guNavAcaka\}/g;

$line =~ s/\\G /\\eng\{German\}/g;
$line =~ s/\\G\\ /\\eng\{German\} /g;
$line =~ s/\\G/\\eng\{German\}/g;

$line =~ s/\\Gk /\\eng\{Greek\}/g;
$line =~ s/\\Gk\\ /\\eng\{Greek\} /g;
$line =~ s/\\Gk/\\eng\{Greek\}/g;

$line =~ s/\\caci /calanacitarx/g;
$line =~ s/\\caci\\ /calanacitarx /g;
$line =~ s/\\caci/calanacitarx/g;

$line =~ s/\\ca /cariterx/g;
$line =~ s/\\ca\\ /cariterx /g;
$line =~ s/\\ca/cariterx/g;

$line =~ s/\\CaM /CaMdasusx/g;
$line =~ s/\\CaM\\ /CaMdasusx /g;
$line =~ s/\\CaM/CaMdasusx/g;

$line =~ s/\\Ca /CaMdasusx/g;
$line =~ s/\\Ca\\ /CaMdasusx /g;
$line =~ s/\\Ca/CaMdasusx/g;

$line =~ s/\\CA /CAyAcitarxNa/g;
$line =~ s/\\CA\\ /CAyAcitarxNa /g;
$line =~ s/\\CA/CAyAcitarxNa/g;

$line =~ s/\\jiVra /jiVvarasAyana vijAcnxna/g;
$line =~ s/\\jiVra\\ /jiVvarasAyana vijAcnxna /g;
$line =~ s/\\jiVra/jiVvarasAyana vijAcnxna/g;

$line =~ s/\\jiVvi /jiVvavijAcnxna/g;
$line =~ s/\\jiVvi\\ /jiVvavijAcnxna /g;
$line =~ s/\\jiVvi/jiVvavijAcnxna/g;

$line =~ s/\\jAyx /jAyxmiti/g;
$line =~ s/\\jAyx\\ /jAyxmiti /g;
$line =~ s/\\jAyx/jAyxmiti/g;

$line =~ s/\\joyxV /joyxVtiSa/g;
$line =~ s/\\joyxV\\ /joyxVtiSa /g;
$line =~ s/\\joyxV/joyxVtiSa/g;

$line =~ s/\\Jap /\\eng\{japanese\}/g;
$line =~ s/\\Jap\\ /\\eng\{japanese\} /g;
$line =~ s/\\Jap/\\eng\{japanese\}/g;

$line =~ s/\\Da /\\eng\{Danish\}/g;
$line =~ s/\\Da\\ /\\eng\{Danish\} /g;
$line =~ s/\\Da/\\eng\{Danish\}/g;

$line =~ s/\\D /\\eng\{Dutch\}/g;
$line =~ s/\\D\\ /\\eng\{Dutch\} /g;
$line =~ s/\\D/\\eng\{Dutch\}/g;

$line =~ s/\\taMtarx /taMtarx vijAcnxna/g;
$line =~ s/\\taMtarx\\ /taMtarx vijAcnxna /g;
$line =~ s/\\taMtarx/taMtarx vijAcnxna/g;

$line =~ s/\\takaR /takaRshAsatxrX/g;
$line =~ s/\\takaR\\ /takaRshAsatxrX /g;
$line =~ s/\\takaR/takaRshAsatxrX/g;

$line =~ s/\\tara /\{\\bf tararUpa\}/g;
$line =~ s/\\tara\\ /\{\\bf tararUpa\} /g;
$line =~ s/\\tara/\{\\bf tararUpa\}/g;

$line =~ s/\\tama /\{\\bf tamarUpa\}/g;
$line =~ s/\\tama\\ /\{\\bf tamarUpa\} /g;
$line =~ s/\\tama/\{\\bf tamarUpa\}/g;

$line =~ s/\\tashA /tatatxvXshAsatxrX/g;
$line =~ s/\\tashA\\ /tatatxvXshAsatxrX /g;
$line =~ s/\\tashA/tatatxvXshAsatxrX/g;

$line =~ s/\\tu /tucaCxvAgi/g;
$line =~ s/\\tu\\ /tucaCxvAgi /g;
$line =~ s/\\tu/tucaCxvAgi/g;

$line =~ s/\\toV /toVTagArike/g;
$line =~ s/\\toV\\ /toVTagArike /g;
$line =~ s/\\toV/toVTagArike/g;

$line =~ s/\\daMveY /daMtaveYdayx/g;
$line =~ s/\\daMveY\\ /daMtaveYdayx /g;
$line =~ s/\\daMveY/daMtaveYdayx/g;

$line =~ s/\\daqvi /daqgfvijAcnxna/g;
$line =~ s/\\daqvi\\ /daqgfvijAcnxna /g;
$line =~ s/\\daqvi/daqgfvijAcnxna/g;

$line =~ s/\\da /dakiSxNa/g;
$line =~ s/\\da\\ /dakiSxNa /g;
$line =~ s/\\da/dakiSxNa/g;

$line =~ s/\\deVva /deVvatAshAsatxrX/g;
$line =~ s/\\deVva\\ /deVvatAshAsatxrX /g;
$line =~ s/\\deVva/deVvatAshAsatxrX/g;

$line =~ s/\\dhavxni /dhavxnivijAcnxna/g;
$line =~ s/\\dhavxni\\ /dhavxnivijAcnxna /g;
$line =~ s/\\dhavxni/dhavxnivijAcnxna/g;

$line =~ s/\\nAyxshA /nAyxyashAsatxrX/g;
$line =~ s/\\nAyxshA\\ /nAyxyashAsatxrX /g;
$line =~ s/\\nAyxshA/nAyxyashAsatxrX/g;

$line =~ s/\\nA /\{\\bf nAmavAcaka\}/g;
$line =~ s/\\nA\\ /\{\\bf nAmavAcaka\} /g;
$line =~ s/\\nA/\{\\bf nAmavAcaka\}/g;

$line =~ s/\\niVshA /niVtishAsatxrX/g;
$line =~ s/\\niVshA\\ /niVtishAsatxrX /g;
$line =~ s/\\niVshA/niVtishAsatxrX/g;

$line =~ s/\\nuga /\{\\bf nuDigaTuTx\}/g;
$line =~ s/\\nuga\\ /\{\\bf nuDigaTuTx\} /g;
$line =~ s/\\nuga/\{\\bf nuDigaTuTx\}/g;

$line =~ s/\\nw /nwkAyAna/g;
$line =~ s/\\nw\\ /nwkAyAna /g;
$line =~ s/\\nw/nwkAyAna/g;

$line =~ s/\\pagu /\{\\bf padagucaCx\}/g;
$line =~ s/\\pagu\\ /\{\\bf padagucaCx\} /g;
$line =~ s/\\pagu/\{\\bf padagucaCx\}/g;

$line =~ s/\\pUparx /\{\\bf pUvaRparxtayxya\}/g;
$line =~ s/\\pUparx\\ /\{\\bf pUvaRparxtayxya\} /g;
$line =~ s/\\pUparx/\{\\bf pUvaRparxtayxya\}/g;

$line =~ s/\\parxpu /parxthama puruSa/g;
$line =~ s/\\parxpu\\ /parxthama puruSa /g;
$line =~ s/\\parxpu/parxthama puruSa/g;

$line =~ s/\\pari /parisaravijAcnxna/g;
$line =~ s/\\pari\\ /parisaravijAcnxna /g;
$line =~ s/\\pari/parisaravijAcnxna/g;

$line =~ s/\\paveY /pashuveYdayx/g;
$line =~ s/\\paveY\\ /pashuveYdayx /g;
$line =~ s/\\paveY/pashuveYdayx/g;

$line =~ s/\\pashA /pavanashAsatxrX/g;
$line =~ s/\\pashA\\ /pavanashAsatxrX /g;
$line =~ s/\\pashA/pavanashAsatxrX/g;

$line =~ s/\\parx /parxyoVga/g;
$line =~ s/\\parx\\ /parxyoVga /g;
$line =~ s/\\parx/parxyoVga/g;

$line =~ s/\\pa /pashicxma/g;
$line =~ s/\\pa\\ /pashicxma /g;
$line =~ s/\\pa/pashicxma/g;

$line =~ s/\\pu /purANa/g;
$line =~ s/\\pu\\ /purANa /g;
$line =~ s/\\pu/purANa/g;

$line =~ s/\\pU /pUvaR/g;
$line =~ s/\\pU\\ /pUvaR /g;
$line =~ s/\\pU/pUvaR/g;

$line =~ s/\\pUpa /\{\\bf pUvaRpada\}/g;
$line =~ s/\\pUpa\\ /\{\\bf pUvaRpada\} /g;
$line =~ s/\\pUpa/\{\\bf pUvaRpada\}/g;

$line =~ s/\\pArxM /pArxMtiVya parxyoVga/g;
$line =~ s/\\pArxM\\ /pArxMtiVya parxyoVga /g;
$line =~ s/\\pArxM/pArxMtiVya parxyoVga/g;

$line =~ s/\\pArxkatx /pArxkatxnashAsatxrX/g;
$line =~ s/\\pArxkatx\\ /pArxkatxnashAsatxrX /g;
$line =~ s/\\pArxkatx/pArxkatxnashAsatxrX/g;

$line =~ s/\\pArxca /pArxciVna cariterx/g;
$line =~ s/\\pArxca\\ /pArxciVna cariterx /g;
$line =~ s/\\pArxca/pArxciVna cariterx/g;

$line =~ s/\\pArxparx /pArxciVna parxyoVga/g;
$line =~ s/\\pArxparx\\ /pArxciVna parxyoVga /g;
$line =~ s/\\pArxparx/pArxciVna parxyoVga/g;

$line =~ s/\\pArxvi /pArxNivijAcnxna/g;
$line =~ s/\\pArxvi\\ /pArxNivijAcnxna /g;
$line =~ s/\\pArxvi/pArxNivijAcnxna/g;

$line =~ s/\\Per /\\eng\{Persian\}/g;
$line =~ s/\\Per\\ /\\eng\{Persian\} /g;
$line =~ s/\\Per/\\eng\{Persian\}/g;

$line =~ s/\\P /\\eng\{Proprietary name\}/g;
$line =~ s/\\P\\ /\\eng\{Proprietary name\} /g;
$line =~ s/\\P/\\eng\{Proprietary name\}/g;

$line =~ s/\\bava /bahuvacana/g;
$line =~ s/\\bava\\ /bahuvacana /g;
$line =~ s/\\bava/bahuvacana/g;

$line =~ s/\\biVga /biVjagaNita/g;
$line =~ s/\\biVga\\ /biVjagaNita /g;
$line =~ s/\\biVga/biVjagaNita/g;

$line =~ s/\\beY /beYbflf/g;
$line =~ s/\\beY\\ /beYbflf /g;
$line =~ s/\\beY/beYbflf/g;

$line =~ s/\\birx /birxTiSf parxyoVga/g;
$line =~ s/\\birx\\ /birxTiSf parxyoVga /g;
$line =~ s/\\birx/birxTiSf parxyoVga/g;

$line =~ s/\\BAavayx /\{\\bf BAvasUcaka avayxya\}/g;
$line =~ s/\\BAavayx\\ /\{\\bf BAvasUcaka avayxya\} /g;
$line =~ s/\\BAavayx/\{\\bf BAvasUcaka avayxya\}/g;

$line =~ s/\\BAshA /BASAshAsatxrX/g;
$line =~ s/\\BAshA\\ /BASAshAsatxrX /g;
$line =~ s/\\BAshA/BASAshAsatxrX/g;

$line =~ s/\\BUkaq /BUtakaqdaMta/g;
$line =~ s/\\BUkaq\\ /BUtakaqdaMta /g;
$line =~ s/\\BUkaq/BUtakaqdaMta/g;

$line =~ s/\\BUgoV /BUgoVLashAsatxrX/g;
$line =~ s/\\BUgoV\\ /BUgoVLashAsatxrX /g;
$line =~ s/\\BUgoV/BUgoVLashAsatxrX/g;

$line =~ s/\\BUvi /BUvijAcnxna/g;
$line =~ s/\\BUvi\\ /BUvijAcnxna /g;
$line =~ s/\\BUvi/BUvijAcnxna/g;

$line =~ s/\\BU /BUtarUpa/g;
$line =~ s/\\BU\\ /BUtarUpa /g;
$line =~ s/\\BU/BUtarUpa/g;

$line =~ s/\\Bwravi /BwtarasAyana vijAcnxna/g;
$line =~ s/\\Bwravi\\ /BwtarasAyana vijAcnxna /g;
$line =~ s/\\Bwravi/BwtarasAyana vijAcnxna/g;

$line =~ s/\\Bwvi /BwtavijAcnxna/g;
$line =~ s/\\Bwvi\\ /BwtavijAcnxna /g;
$line =~ s/\\Bwvi/BwtavijAcnxna/g;

$line =~ s/\\mavi /manoVvijAcnxNa/g;
$line =~ s/\\mavi\\ /manoVvijAcnxNa /g;
$line =~ s/\\mavi/manoVvijAcnxNa/g;

$line =~ s/\\mashA /manashAshxsatxrX/g;
$line =~ s/\\mashA\\ /manashAshxsatxrX /g;
$line =~ s/\\mashA/manashAshxsatxrX/g;

$line =~ s/\\mAshA /mAnavashAsatxrX/g;
$line =~ s/\\mAshA\\ /mAnavashAsatxrX /g;
$line =~ s/\\mAshA/mAnavashAsatxrX/g;

$line =~ s/\\mimiV /milimiVTarf/g;
$line =~ s/\\mimiV\\ /milimiVTarf /g;
$line =~ s/\\mimiV/milimiVTarf/g;

$line =~ s/\\mo /modalAda/g;
$line =~ s/\\mo\\ /modalAda /g;
$line =~ s/\\mo/modalAda/g;

$line =~ s/\\yaMshA /yaMtarxshAsatxrX/g;
$line =~ s/\\yaMshA\\ /yaMtarxshAsatxrX /g;
$line =~ s/\\yaMshA/yaMtarxshAsatxrX/g;

$line =~ s/\\ravi /rasAyanavijAcnxna/g;
$line =~ s/\\ravi\\ /rasAyanavijAcnxna /g;
$line =~ s/\\ravi/rasAyanavijAcnxna/g;

$line =~ s/\\rAshA /rAjaniVtishAsatxrX/g;
$line =~ s/\\rAshA\\ /rAjaniVtishAsatxrX /g;
$line =~ s/\\rAshA/rAjaniVtishAsatxrX/g;

$line =~ s/\\rUpa /rUpakavAgi/g;
$line =~ s/\\rUpa\\ /rUpakavAgi /g;
$line =~ s/\\rUpa/rUpakavAgi/g;

$line =~ s/\\roVkAyx /roVmanf kAyxtholikf/g;
$line =~ s/\\roVkAyx\\ /roVmanf kAyxtholikf /g;
$line =~ s/\\roVkAyx/roVmanf kAyxtholikf/g;

$line =~ s/\\roVca /roVmanf cariterx/g;
$line =~ s/\\roVca\\ /roVmanf cariterx /g;
$line =~ s/\\roVca/roVmanf cariterx/g;

$line =~ s/\\roVpu /roVmanf purANa/g;
$line =~ s/\\roVpu\\ /roVmanf purANa /g;
$line =~ s/\\roVpu/roVmanf purANa/g;

$line =~ s/\\roVshA /roVgashAsatxrX/g;
$line =~ s/\\roVshA\\ /roVgashAsatxrX /g;
$line =~ s/\\roVshA/roVgashAsatxrX/g;

$line =~ s/\\roV /roVmanf/g;
$line =~ s/\\roV\\ /roVmanf /g;
$line =~ s/\\roV/roVmanf/g;

$line =~ s/\\loVvi /loVhavideyx/g;
$line =~ s/\\loVvi\\ /loVhavideyx /g;
$line =~ s/\\loVvi/loVhavideyx/g;

$line =~ s/\\vaMlAM /vaMshalAMCana videyx/g;
$line =~ s/\\vaMlAM\\ /vaMshalAMCana videyx /g;
$line =~ s/\\vaMlAM/vaMshalAMCana videyx/g;

$line =~ s/\\vakaq /vataRmAna kaqdaMta/g;
$line =~ s/\\vakaq\\ /vataRmAna kaqdaMta /g;
$line =~ s/\\vakaq/vataRmAna kaqdaMta/g;

$line =~ s/\\vAyA /vAyuyAna/g;
$line =~ s/\\vAyA\\ /vAyuyAna /g;
$line =~ s/\\vAyA/vAyuyAna/g;

$line =~ s/\\vAyx /vAyxkaraNa/g;
$line =~ s/\\vAyx\\ /vAyxkaraNa /g;
$line =~ s/\\vAyx/vAyxkaraNa/g;

$line =~ s/\\vAshi /vAsutxshilapx/g;
$line =~ s/\\vAshi\\ /vAsutxshilapx /g;
$line =~ s/\\vAshi/vAsutxshilapx/g;

$line =~ s/\\viduyx /viduyxdivxjAcnxna/g;
$line =~ s/\\viduyx\\ /viduyxdivxjAcnxna /g;
$line =~ s/\\viduyx/viduyxdivxjAcnxna/g;

$line =~ s/\\viparx /viraLa parxyoVga/g;
$line =~ s/\\viparx\\ /viraLa parxyoVga /g;
$line =~ s/\\viparx/viraLa parxyoVga/g;

$line =~ s/\\vivi /vishavxvidAyxnilaya/g;
$line =~ s/\\vivi\\ /vishavxvidAyxnilaya /g;
$line =~ s/\\vivi/vishavxvidAyxnilaya/g;

$line =~ s/\\vi /viSayadalilx/g;
$line =~ s/\\vi\\ /viSayadalilx /g;
$line =~ s/\\vi/viSayadalilx/g;

$line =~ s/\\veYshA /veYdayxshAsatxrX/g;
$line =~ s/\\veYshA\\ /veYdayxshAsatxrX /g;
$line =~ s/\\veYshA/veYdayxshAsatxrX/g;

$line =~ s/\\Russ /\\eng\{Russian\}/g;
$line =~ s/\\Russ\\ /\\eng\{Russian\} /g;
$line =~ s/\\Russ/\\eng\{Russian\}/g;

$line =~ s/\\shavi /shariVra vijAcnxna/g;
$line =~ s/\\shavi\\ /shariVra vijAcnxna /g;
$line =~ s/\\shavi/shariVra vijAcnxna/g;

$line =~ s/\\shaveY /shasatxrXveYdayx/g;
$line =~ s/\\shaveY\\ /shasatxrXveYdayx /g;
$line =~ s/\\shaveY/shasatxrXveYdayx/g;

$line =~ s/\\shashA /shabadxshAsatxrX/g;
$line =~ s/\\shashA\\ /shabadxshAsatxrX /g;
$line =~ s/\\shashA/shabadxshAsatxrX/g;
 
$line =~ s/\\shilapx /shilapxshAsatxrX/g;
$line =~ s/\\shilapx\\ /shilapxshAsatxrX /g;
$line =~ s/\\shilapx/shilapxshAsatxrX/g;

$line =~ s/\\saPxvi /saPxTika vijAcnxna/g;
$line =~ s/\\saPxvi\\ /saPxTika vijAcnxna /g;
$line =~ s/\\saPxvi/saPxTika vijAcnxna/g;

$line =~ s/\\sakirx /\{\\bf sakamaRka kirxyApada\}/g;
$line =~ s/\\sakirx\\ /\{\\bf sakamaRka kirxyApada\} /g;
$line =~ s/\\sakirx/\{\\bf sakamaRka kirxyApada\}/g;

$line =~ s/\\sapUpa /\{\\bf samAsa pUvaRpada\}/g;
$line =~ s/\\sapUpa\\ /\{\\bf samAsa pUvaRpada\} /g;
$line =~ s/\\sapUpa/\{\\bf samAsa pUvaRpada\}/g;

$line =~ s/\\saMavayx /\{\\bf saMyoVjakAvayxya\}/g;
$line =~ s/\\saMavayx\\ /\{\\bf saMyoVjakAvayxya\} /g;
$line =~ s/\\saMavayx/\{\\bf saMyoVjakAvayxya\}/g;

$line =~ s/\\sanA /\{\\bf savaRnAma\}/g;
$line =~ s/\\sanA\\ /\{\\bf savaRnAma\} /g;
$line =~ s/\\sanA/\{\\bf savaRnAma\}/g;

$line =~ s/\\SAfr /\\eng\{South African\}/g;
$line =~ s/\\SAfr\\ /\\eng\{South African\} /g;
$line =~ s/\\SAfr/\\eng\{South African\}/g;

$line =~ s/\\saMkeV /saMkeVta/g;
$line =~ s/\\saMkeV\\ /saMkeVta /g;
$line =~ s/\\saMkeV/saMkeVta/g;

$line =~ s/\\saMkiSx /saMkiSxpatx/g;
$line =~ s/\\saMkiSx\\ /saMkiSxpatx /g;
$line =~ s/\\saMkiSx/saMkiSxpatx/g;

$line =~ s/\\saMpa /saMyukatxpada/g;
$line =~ s/\\saMpa\\ /saMyukatxpada /g;
$line =~ s/\\saMpa/saMyukatxpada/g;

$line =~ s/\\saMboV /saMboVdhane/g;
$line =~ s/\\saMboV\\ /saMboVdhane /g;
$line =~ s/\\saMboV/saMboVdhane/g;

$line =~ s/\\saMshA /saMKAyxshAsatxrX/g;
$line =~ s/\\saMshA\\ /saMKAyxshAsatxrX /g;
$line =~ s/\\saMshA/saMKAyxshAsatxrX/g;

$line =~ s/\\saM /saMgiVta/g;
$line =~ s/\\saM\\ /saMgiVta /g;
$line =~ s/\\saM/saMgiVta/g;

$line =~ s/\\saupa /\{\\bf samAsa utatxra pada\}/g;
$line =~ s/\\saupa\\ /\{\\bf samAsa utatxra pada\} /g;
$line =~ s/\\saupa/\{\\bf samAsa utatxra pada\}/g;

$line =~ s/\\saDi /saDilavAgi/g;
$line =~ s/\\saDi\\ /saDilavAgi /g;
$line =~ s/\\saDi/saDilavAgi/g;

$line =~ s/\\sanA /\{\\bf savaRnAma\}/g;
$line =~ s/\\sanA\\ /\{\\bf savaRnAma\} /g;
$line =~ s/\\sanA/\{\\bf savaRnAma\}/g;

$line =~ s/\\savi /sasayxvijAcnxna/g;
$line =~ s/\\savi\\ /sasayxvijAcnxna /g;
$line =~ s/\\savi/sasayxvijAcnxna/g;

$line =~ s/\\sashA /samAjashAsatxrX/g;
$line =~ s/\\sashA\\ /samAjashAsatxrX /g;
$line =~ s/\\sashA/samAjashAsatxrX/g;

$line =~ s/\\sA /sAmAnayxvAgi/g;
$line =~ s/\\sA\\ /sAmAnayxvAgi /g;
$line =~ s/\\sA/sAmAnayxvAgi/g;

$line =~ s/\\su /sumAru/g;
$line =~ s/\\su\\ /sumAru /g;
$line =~ s/\\su/sumAru/g;

$line =~ s/\\swM /swMdayaRmImAMse/g;
$line =~ s/\\swM\\ /swMdayaRmImAMse /g;
$line =~ s/\\swM/swMdayaRmImAMse/g;

$line =~ s/\\sw /swmoyxVkitx/g;
$line =~ s/\\sw\\ /swmoyxVkitx /g;
$line =~ s/\\sw/swmoyxVkitx/g;

$line =~ s/\\sitxrXV /sitxrXVliMga/g;
$line =~ s/\\sitxrXV\\ /sitxrXVliMga /g;
$line =~ s/\\sitxrXV/sitxrXVliMga/g;

$line =~ s/\\sisi /kUyxbikf seMTimITarf/g;
$line =~ s/\\sisi\\ /kUyxbikf seMTimITarf /g;
$line =~ s/\\sisi/kUyxbikf seMTimITarf/g;

$line =~ s/\\Sc /\\eng\{Scottish\}/g;
$line =~ s/\\Sc\\ /\\eng\{Scottish\} /g;
$line =~ s/\\Sc/\\eng\{Scottish\}/g;

$line =~ s/\\Sp /\\eng\{Spanish\}/g;
$line =~ s/\\Sp\\ /\\eng\{Spanish\} /g;
$line =~ s/\\Sp/\\eng\{Spanish\}/g;

$line =~ s/\\hA /hAsayx parxyoVga/g;
$line =~ s/\\hA\\ /hAsayx parxyoVga /g;
$line =~ s/\\hA/hAsayx parxyoVga/g;

$line =~ s/\\hiV /hiVnAthaRka parxyoVga/g;
$line =~ s/\\hiV\\ /hiVnAthaRka parxyoVga /g;
$line =~ s/\\hiV/hiVnAthaRka parxyoVga/g;

$line =~ s/\\Latin /\\eng\{Latin\}/g;
$line =~ s/\\Latin\\ /\\eng\{Latin\} /g;
$line =~ s/\\Latin/\\eng\{Latin\}/g;

return $line;
}
