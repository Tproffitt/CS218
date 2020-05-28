#  CS 218, MIPS Assignment #1
#	Tyler Proffitt
#	Section 001

################################################################################
#  data segment

.data

sideLens:
	.word	  15,   25,   33,   44,   58,   69,   72,   86,   99,  101 
	.word	 369,  374,  377,  379,  382,  384,  386,  388,  392,  393 
	.word	 501,  513,  524,  536,  540,  556,  575,  587,  590,  596 
	.word	 634,  652,  674,  686,  697,  704,  716,  720,  736,  753 
	.word	 107,  121,  137,  141,  157,  167,  177,  181,  191,  199 
	.word	 102,  113,  122,  139,  144,  151,  161,  178,  186,  197 
	.word	   1,    2,    3,    4,    5,    6,    7,    8,    9,   10 
	.word	 202,  209,  215,  219,  223,  225,  231,  242,  244,  249 
	.word	 203,  215,  221,  239,  248,  259,  262,  274,  280,  291 
	.word	 251,  253,  266,  269,  271,  272,  280,  288,  291,  299 
	.word	1469, 2474, 3477, 4479, 5482, 5484, 6486, 7788, 8492, 1493 

apothemLens:
	.word	  32,   51,   76,   87,   90,  100,  111,  123,  132,  145 
	.word	 634,  652,  674,  686,  697,  704,  716,  720,  736,  753 
	.word	 782,  795,  807,  812,  827,  847,  867,  879,  888,  894 
	.word	 102,  113,  122,  139,  144,  151,  161,  178,  186,  197 
	.word	1782, 2795, 3807, 3812, 4827, 5847, 6867, 7879, 7888, 1894 
	.word	 206,  212,  222,  231,  246,  250,  254,  278,  288,  292 
	.word	 332,  351,  376,  387,  390,  400,  411,  423,  432,  445 
	.word	  10,   12,   14,   15,   16,   22,   25,   26,   28,   29 
	.word	 400,  404,  406,  407,  424,  425,  426,  429,  448,  492 
	.word	 457,  487,  499,  501,  523,  524,  525,  526,  575,  594 
	.word	1912, 2925, 3927, 4932, 5447, 5957, 6967, 7979, 7988, 1994 

hexAreas:
	.space	440

len:	.word	110

haMin:	.word	0
haMid:	.word	0
haMax:	.word	0
haSum:	.word	0
haAve:	.word	0

LN_CNTR	= 7

# -----

hdr:	.ascii	"MIPS Assignment #1 \n"
	.ascii	"Program to calculate area of each hexagon in a series "
	.ascii	"of hexagons. \n"
	.ascii	"Also finds min, mid, max, sum, and average for the "
	.asciiz	"hexagon areas. \n\n"

new_ln:	.asciiz	"\n"
blnks:	.asciiz	"  "

a1_st:	.asciiz	"\nHexagon min = "
a2_st:	.asciiz	"\nHexagon mid = "
a3_st:	.asciiz	"\nHexagon max = "
a4_st:	.asciiz	"\nHexagon sum = "
a5_st:	.asciiz	"\nHexagon ave = "


###########################################################
#  text/code segment

.text
.globl main
.ent main
main:

# -----
#  Display header.

	la	$a0, hdr
	li	$v0, 4
	syscall				# print header

# --------------------------------------------------


la	$s0, sideLens
la	$s1, apothemLens
lw	$s2, len
la	$s3, hexAreas
# li	$s4, 0				# index
li 	$s5, 0				# sum
li	$s6, 0				# min
li	$s7, 0				# max
	lw $t0, ($s0)		# sideLens[i]
	lw $t1, ($s1)		# apothemLens[i]
	mul $t2, $t0, $t1	# $t2 = sideLens[i] * apothemLens[i]
	div $t3, $t2, 2		# $t3 = $t2 / 2
	sw $t3, ($s3)		# hexAreas[i] = $t3
	add $s5, $s5, $t3		# sum += $t3
	move $s6, $t3
	move $s7, $t3
calcLoop:
	lw $t0, ($s0)		# sideLens[i]
	lw $t1, ($s1)		# apothemLens[i]
	mul $t2, $t0, $t1	# $t2 = sideLens[i] * apothemLens[i]
	div $t3, $t2, 2		# $t3 = $t2 / 2
	sw $t3, ($s3)		# hexAreas[i] = $t3
	add $s5, $s5, $t3		# sum += $t3
	bge $t3, $s6, minDone	# if ($t3 >= haMin) goto minDone
	move $s6, $t3			# 	else haMin = $t3
minDone:
	ble $t3, $s7, maxDone	# if ($t3 >= haMax) goto maxDone
	move $s7, $t3			# 	else haMax = $t3
maxDone:
	add $s0, $s0, 4			# sideLens index + 1 (4 bytes)
	add $s1, $s1, 4			# apothemLens index + 1 (4 bytes)
	add $s3, $s3, 4			# hexAreas index + 1 (4 bytes)
	sub $s2, $s2, 1			# len--
	bnez $s2, calcLoop		# if (len != 0) goto calcLoop
	
	sw $s5, haSum			# hsSum = $s5
	sw $s6, haMin			# haMin = $s6
	sw $s7, haMax			# haMax = $s7
					# get haAve
	lw $t4, len			# $t4 = len
	div $t5, $s5, $t4	# $t5 = sum / len
	sw $t5, haAve			# haAve = $t5
					# get haMid
	div $t0, $t4, 2		# $t0 = len / 2
	mul $t0, $t0, 4		# $t0 *= 4 (index into byte offset)
	la $s3, hexAreas
	add $s3, $s3, $t0		# add $t0 offset to $s3 address
	lw $t1, ($s3)		# $t1 = hexAreas[len / 2]
	sub $s3, $s3, 4			# $s3 -= 4 bytes
	lw  $t2, ($s3)		# $t2 = hexAreas[(len / 2) - 1]
	add $t2, $t1, $t2		# $t3 = $t1 + $t2
	div $t4, $t2, 2		# $t4 = $t3 / 2
	sw $t4, haMid			# haMid = $t4


##########################################################
#  Display results.

	la	$a0, new_ln		# print a newline
	li	$v0, 4
	syscall
	la	$a0, new_ln		# print a newline
	li	$v0, 4
	syscall

#  Print min message followed by result.

	la	$a0, a1_st
	li	$v0, 4
	syscall				# print "min = "

	lw	$a0, haMin
	li	$v0, 1
	syscall				# print min

# -----
#  Print middle message followed by result.

	la	$a0, a2_st
	li	$v0, 4
	syscall				# print "med = "

	lw	$a0, haMid
	li	$v0, 1
	syscall				# print mid

# -----
#  Print max message followed by result.

	la	$a0, a3_st
	li	$v0, 4
	syscall				# print "max = "

	lw	$a0, haMax
	li	$v0, 1
	syscall				# print max

# -----
#  Print sum message followed by result.

	la	$a0, a4_st
	li	$v0, 4
	syscall				# print "sum = "

	lw	$a0, haSum
	li	$v0, 1
	syscall				# print sum

# -----
#  Print average message followed by result.

	la	$a0, a5_st
	li	$v0, 4
	syscall				# print "ave = "

	lw	$a0, haAve
	li	$v0, 1
	syscall				# print average

# -----
#  Done, terminate program.

endit:
	la	$a0, new_ln		# print a newline
	li	$v0, 4
	syscall

	li	$v0, 10
	syscall				# all done!

.end main

