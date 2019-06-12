#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys

vprt = 0
argv = sys.argv
argc = len(sys.argv)

ix = 1
while (ix < argc):
	if ((argv[ix] == "-help") or (argv[ix] == "--help")):
		iampth = argv[0].split("/")
		iampthn = len(iampth)
		#print iampth[iampthn-1], ": Calculate the number of days until the desired life"
		print iampth[iampthn-1], "[-v]"
		print "      希望寿命までの日数を算出します"
		print "      -v : 年毎の月日数表示を行います"
		sys.exit(0)
	elif (argv[ix] == "-v"):
		vprt = 1
	ix += 1


months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']
mmxdays = {	# 平年月数
	'Jan':31,
	'Feb':28,
	'Mar':31,
	'Apr':30,
	'May':31,
	'Jun':30,
	'Jul':31,
	'Aug':31,
	'Sep':30,
	'Oct':31,
	'Nov':30,
	'Dec':31}

mmxleapdays = {	# 閏年月数
	'Jan':31,
	'Feb':29,
	'Mar':31,
	'Apr':30,
	'May':31,
	'Jun':30,
	'Jul':31,
	'Aug':31,
	'Sep':30,
	'Oct':31,
	'Nov':30,
	'Dec':31}

ynum = input("誕生 年: ")
bmnum = input("　　 月: ")
dnum =  input("　　 日: ")
brned = 0

whlyr = input("希望寿命: ")
endyr = ynum + whlyr

# 現在年月日取得
import commands
check = commands.getoutput("date +'%Y %m %d'")
crrtdt = check.split(" ") 
crryr = int(crrtdt[0])
crrmn = int(crrtdt[1])
crrdt = int(crrtdt[2])
untldys = 0

ttldys = 0
while ynum <= endyr:	# 希望寿命まで計算
	# 閏年判定と月日数データの割り付け
	if ynum % 4 == 0:
		if ynum % 100 == 0:
			mxdays = mmxdays
		else:
			mxdays = mmxleapdays
	else:
			mxdays = mmxdays

	if mxdays[months[1]] == 29:
		if (vprt == 1): print ynum , "Leap"
	else:
		if (vprt == 1): print ynum

	mnum = 0
	for mnm in months:	# 一年分計算
		#
		if ((ynum == crryr) and (mnm == months[crrmn-1])):
			untldys = ttldys + crrdt	# 今日現在までの日数取得

		if brned == 1:
			#
			if ((ynum == endyr) and (mnm == months[bmnum-1])):
				# 寿命到達月の日数を取得して終了
				if (vprt == 1): print mnum+1, mnm, dnum
				ttldys += dnum
				break
			else:
				# 通常の月日数を取得
				if (vprt == 1): print mnum+1, mnm, mxdays[mnm]
				ttldys += mxdays[mnm]
		elif mnm == months[bmnum-1]:
			# 誕生月の日数を取得
			if (vprt == 1): print mnum+1, mnm, mxdays[mnm]-dnum
			ttldys += (mxdays[mnm] - dnum)
			brned = 1

		mnum += 1
	ynum += 1

print "全日数:", ttldys, "days (", ttldys*24, "hours)"
print "今日は", crryr, crrmn, "/", crrdt
print "今日まで", untldys, "days"
print "希望寿命まであと", ttldys-untldys, "days left (", (ttldys-untldys)*24, "hours)"
