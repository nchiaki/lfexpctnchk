#!/usr/bin/python

print "I am Python Test"

months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']
mmxdays = {
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

mmxleapdays = {
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

ynum = input("Born year: ")
bmnum = input("     month: ")
dnum = input("     day: ")
brned = 0

whlyr = input("While year: ")
endyr = ynum + whlyr

#
import commands
check = commands.getoutput("date +'%Y %m %d'")
crrtdt = check.split(" ") 
crryr = int(crrtdt[0])
crrmn = int(crrtdt[1])
crrdt = int(crrtdt[2])
untldys = 0;
print "Today ", crryr, crrmn, crrdt

ttldys = 0

while ynum <= endyr:
	#
	if ynum % 4 == 0:
		if ynum % 100 == 0:
			mxdays = mmxdays
		else:
			mxdays = mmxleapdays
	else:
			mxdays = mmxdays

	if mxdays[months[1]] == 29:
		print ynum , "Leap"
	else:
		print ynum

	mnum = 0
	for mnm in months:
		#
		if ((ynum == crryr) and (mnm == months[crrmn-1])):
			untldys = ttldys + crrdt

		if brned == 1:
			#
			if ((ynum == endyr) and (mnm == months[bmnum-1])):
				print mnum+1, mnm, months[mnum], dnum
				ttldys += dnum
				break
			else:
				print mnum+1, mnm, months[mnum], mxdays[mnm]
				ttldys += mxdays[mnm]
		elif mnm == months[bmnum-1]:
			#
			print mnum+1, mnm, months[mnum], mxdays[mnm]-dnum
			ttldys += (mxdays[mnm] - dnum)
			brned = 1

		mnum += 1
	ynum += 1

print "Total:", ttldys, "days (", ttldys*24, "hours)"

check = commands.getoutput("date")
print "Today is", crryr, crrmn, "/", crrdt
print "Until today", untldys, "days"
print "So it's", ttldys-untldys, "days left (", (ttldys-untldys)*24, "hours)"
