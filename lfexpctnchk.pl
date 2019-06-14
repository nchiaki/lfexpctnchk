#!/usr/bin/perl

$vprt = 0;
$argc = $#ARGV;

$ix = 0;
while ($ix <= $argc) {
	print "$ARGV[$ix]\n";
	if (($ARGV[$ix] eq "-help") || ($ARGV[$ix] eq "--help")) {
		@iampth = split("/", $ARGV[0]);
		$iampthn = $#iampth;
		print $iampth[$iampthn], "[-v]\n";
		print "      希望寿命までの日数を算出します\n";
		print "      -v : 年毎の月日数表示を行います\n";
		exit(0);
	} elsif ($ARGV[$ix] eq "-v") {
		$vprt = 1;
	}
	$ix += 1;
}


@months = ('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');
%mmxdays = (	# 平年月数
	'Jan',31,
	'Feb',28,
	'Mar',31,
	'Apr',30,
	'May',31,
	'Jun',30,
	'Jul',31,
	'Aug',31,
	'Sep',30,
	'Oct',31,
	'Nov',30,
	'Dec',31);

%mmxleapdays = (	# 閏年月数
	'Jan',31,
	'Feb',29,
	'Mar',31,
	'Apr',30,
	'May',31,
	'Jun',30,
	'Jul',31,
	'Aug',31,
	'Sep',30,
	'Oct',31,
	'Nov',30,
	'Dec',31);

print "誕生 年: ";
$ynum = <STDIN>;
chomp($ynum);
print "　　 月: ";
$bmnum = <STDIN>;
chomp($bmnum);
print "　　 日: ";
$dnum = <STDIN>;
chomp($dnum);
$brned = 0;

print "希望寿命: ";
$whlyr = <STDIN>;
chomp($whlyr);
$endyr = $ynum + $whlyr;

# 現在年月日取得
$check = "";
open(cmd, "date +'%Y %m %d' |");
while(<cmd>){$check .= $_; }
close(cmd);
chomp($check);

@crrtdt = split(" ", $check);
$crryr = $crrtdt[0];
$crrmn = $crrtdt[1];
$crrdt = $crrtdt[2];
$untldys = 0;

$ttldys = 0;
while ($ynum <= $endyr) {	# 希望寿命まで計算
	# 閏年判定と月日数データの割り付け
    # 西暦年が4で割り切れる年は(原則として)閏年。
    # ただし、西暦年が100で割り切れる年は(原則として)平年。
    # ただし、西暦年が400で割り切れる年は必ず閏年。
	if (($ynum % 4) == 0) {
		if (($ynum % 100) == 0) {
			if (($ynum % 400) == 0) {
				%mxdays = %mmxleapdays;
			} else {
				%mxdays = %mmxdays;
			}
		} else {
			%mxdays = %mmxleapdays;
		}
	} else {
			%mxdays = %mmxdays;
	}
	if ($mxdays{$months[1]} == 29) {
		if ($vprt == 1) {print "$ynum Leap\n";}
	} else {
		if ($vprt == 1) {print "$ynum\n";}
	}

	$mnum = 0;
	foreach $mnm (@months) {	# 一年分計算
		#
		if (($ynum == $crryr) && ($mnm eq $months[$crrmn-1])) {
			$untldys = $ttldys + $crrdt;	# 今日現在までの日数取得
		}
		if ($brned == 1) {
			#
			if (($ynum == $endyr) && ($mnm eq $months[$bmnum-1])) {
				# 寿命到達月の日数を取得して終了
				if ($vprt == 1) {printf ("%d %s %d\n", $mnum+1, $mnm, $dnum);}
				$ttldys += $dnum;
				last;
			} else {
				# 通常の月日数を取得
				if ($vprt == 1) {printf ("%d %s %d\n", $mnum+1, $mnm, $mxdays{$mnm});}
				$ttldys += $mxdays{$mnm};
			}
		} elsif ($mnm eq $months[$bmnum-1]) {
			# 誕生月の日数を取得
			if ($vprt == 1) {printf ("%d %s %d\n", $mnum+1, $mnm, $mxdays{$mnm}-$dnum);}
			$ttldys += ($mxdays{$mnm} - $dnum);
			$brned = 1;
		}
		$mnum += 1;
	}

	$ynum += 1;
}

printf ("全日数: %d days (%d hours)\n", $ttldys, $ttldys*24);
printf ("今日は %d %d/%d\n", $crryr, $crrmn, $crrdt);
printf ("今日まで %d days\n", $untldys);
printf ("希望寿命まであと %d days left (%d hours)\n", $ttldys-$untldys, ($ttldys-$untldys)*24);

