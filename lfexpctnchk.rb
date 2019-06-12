#!/usr/bin/ruby

vprt = 0
argc = ARGV.size()

ix = 0
while ix < argc do
	if ((ARGV[ix] == "-help") or (ARGV[ix] == "--help")) then
		iampth = ARGV[0].split("/")
		iampthn = iampth.length
		print iampth[iampthn-1], "[-v]\n"
		print "      希望寿命までの日数を算出します\n"
		print "      -v : 年毎の月日数表示を行います\n"
		exit(0)
	elsif (ARGV[ix] == "-v") then
		vprt = 1
	end
	ix += 1
end


months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']
mmxdays = {	# 平年月数
	'Jan'=>31,
	'Feb'=>28,
	'Mar'=>31,
	'Apr'=>30,
	'May'=>31,
	'Jun'=>30,
	'Jul'=>31,
	'Aug'=>31,
	'Sep'=>30,
	'Oct'=>31,
	'Nov'=>30,
	'Dec'=>31}

mmxleapdays = {	# 閏年月数
	'Jan'=>31,
	'Feb'=>29,
	'Mar'=>31,
	'Apr'=>30,
	'May'=>31,
	'Jun'=>30,
	'Jul'=>31,
	'Aug'=>31,
	'Sep'=>30,
	'Oct'=>31,
	'Nov'=>30,
	'Dec'=>31}

print "誕生 年: "
ynum = $stdin.gets.to_i
print "　　 月: "
bmnum = $stdin.gets.to_i
print "　　 日: "
dnum =  $stdin.gets.to_i
brned = 0

print "希望寿命: "
whlyr = $stdin.gets.to_i
endyr = ynum + whlyr

# 現在年月日取得
check = `date +'%Y %m %d'`
crrtdt = check.split(" ") 
crryr = crrtdt[0].to_i
crrmn = crrtdt[1].to_i
crrdt = crrtdt[2].to_i
untldys = 0

ttldys = 0
while ynum <= endyr do	# 希望寿命まで計算
	# 閏年判定と月日数データの割り付け
	if ynum % 4 == 0 then
		if ynum % 100 == 0 then
			mxdays = mmxdays
		else
			mxdays = mmxleapdays
		end
	else
			mxdays = mmxdays
	end

	if mxdays[months[1]] == 29 then
		print "#{ynum} Leap\n" if (vprt == 1)
	else
		print "#{ynum}\n" if (vprt == 1)
	end

	mnum = 0
	for mnm in months do	# 一年分計算
		#
		if ((ynum == crryr) and (mnm == months[crrmn-1])) then
			untldys = ttldys + crrdt	# 今日現在までの日数取得
		end
		if brned == 1 then
			#
			if ((ynum == endyr) and (mnm == months[bmnum-1])) then
				# 寿命到達月の日数を取得して終了
				print "#{mnum+1} #{mnm} #{dnum}\n" if (vprt == 1)
				ttldys += dnum
				break
			else
				# 通常の月日数を取得
				print "#{mnum+1} #{mnm} #{mxdays[mnm]}\n" if (vprt == 1)
				ttldys += mxdays[mnm]
			end
		elsif mnm == months[bmnum-1] then
			# 誕生月の日数を取得
			print "#{mnum+1} #{mnm} #{mxdays[mnm]-dnum}\n" if (vprt == 1)
			ttldys += (mxdays[mnm] - dnum)
			brned = 1
		end
		mnum += 1
	end
	ynum += 1
end

print "全日数: #{ttldys} days (#{ttldys*24} hours)\n"
print "今日は #{crryr} #{crrmn}/#{crrdt}\n"
print "今日まで #{untldys} days\n"
print "希望寿命まであと #{ttldys-untldys} days left (#{(ttldys-untldys)*24} hours)\n"
