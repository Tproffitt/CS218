#  CS 218, MIPS Assignment #2
#  Provided Template

###########################################################
#  data segment

.data

apothems:	.word	  110,   114,   113,   137,   154
		.word	  131,   113,   120,   161,   136
		.word	  114,   153,   144,   119,   142
		.word	  127,   141,   153,   162,   110
		.word	  119,   128,   114,   110,   115
		.word	  115,   111,   122,   133,   170
		.word	  115,   123,   115,   163,   126
		.word	  124,   133,   110,   161,   115
		.word	  114,   134,   113,   171,   181
		.word	  138,   173,   129,   117,   193
		.word	  125,   124,   113,   117,   123
		.word	  134,   134,   156,   164,   142
		.word	  206,   212,   112,   131,   246
		.word	  150,   154,   178,   188,   192
		.word	  182,   195,   117,   112,   127
		.word	  117,   167,   179,   188,   194
		.word	  134,   152,   174,   186,   197
		.word	  104,   116,   112,   136,   153
		.word	  132,   151,   136,   187,   190
		.word	  120,   111,   123,   132,   145

bases:		.word	  233,   214,   273,   231,   215
		.word	  264,   273,   274,   223,   256
		.word	  157,   187,   199,   111,   123
		.word	  124,   125,   126,   175,   194
		.word	  149,   126,   162,   131,   127
		.word	  177,   199,   197,   175,   114
		.word	  244,   252,   231,   242,   256
		.word	  164,   141,   142,   173,   166
		.word	  104,   146,   123,   156,   163
		.word	  121,   118,   177,   143,   178
		.word	  112,   111,   110,   135,   110
		.word	  127,   144,   210,   172,   124
		.word	  125,   116,   162,   128,   192
		.word	  215,   224,   236,   275,   246
		.word	  213,   223,   253,   267,   235
		.word	  204,   229,   264,   267,   234
		.word	  216,   213,   264,   253,   265
		.word	  226,   212,   257,   267,   234
		.word	  217,   214,   217,   225,   253
		.word	  223,   273,   215,   206,   213

heights:	.word	  117,   114,   115,   172,   124
		.word	  125,   116,   162,   138,   192
		.word	  111,   183,   133,   130,   127
		.word	  111,   115,   158,   113,   115
		.word	  117,   126,   116,   117,   227
		.word	  177,   199,   177,   175,   114
		.word	  194,   124,   112,   143,   176
		.word	  134,   126,   132,   156,   163
		.word	  124,   119,   122,   183,   110
		.word	  191,   192,   129,   129,   122
		.word	  135,   226,   162,   137,   127
		.word	  127,   159,   177,   175,   144
		.word	  179,   153,   136,   140,   235
		.word	  112,   154,   128,   113,   132
		.word	  161,   192,   151,   213,   126
		.word	  169,   114,   122,   115,   131
		.word	  194,   124,   114,   143,   176
		.word	  134,   126,   122,   156,   163
		.word	  149,   144,   114,   134,   167
		.word	  143,   129,   161,   165,   136

hexVolumes:	.space	400

len:		.word	100

volMin:		.word	0
volMid:		.word	0
volMax:		.word	0
volSum:		.word	0
volAve:		.word	0

# -----

hdr:	.ascii	"MIPS Assignment #2 \n"
	.ascii	"  Hexagonal Volumes Program:\n"
	.ascii	"  Also finds minimum, middle value, maximum, \n"
	.asciiz	"  sum, and average for the volumes.\n\n"

a1_st:	.asciiz	"\nHexagon Volumes Minimum = "
a2_st:	.asciiz	"\nHexagon Volumes Middle  = "
a3_st:	.asciiz	"\nHexagon Volumes Maximum = "
a4_st:	.asciiz	"\nHexagon Volumes Sum     = "
a5_st:	.asciiz	"\nHexagon Volumes Average = "

newLn:	.asciiz	"\n"
blnks:	.asciiz	"  "


###########################################################
#  text/code segment

# --------------------
#  Compute volumes:
#  Then find middle, max, sum, and average for volumes.

.text
.globl main
.ent main
main:

# -----
#  Display header.

	la	$a0, hdr
	li	$v0, 4
	syscall				# print header

# -------------------------------------------------------


la $s0, apothems
la $s1, bases
la $s2, heights
la $s3, hexVolumes
lw $s4, len
li $s5, 0					# sum
li $s6, 0					# min
li $s7, 0					# max
	lw $t0, ($s0)			# apothems[0]
	lw $t1, ($s1)			# bases[0]
	lw $t2, ($s2)			# heights[0]
	li $t3, 3				# $t3 = 3
	mul $t3, $t3, $t0		# $t3 *= apothems[0]
	mul $t3, $t3, $t1		# $t3 *= bases[0]
	mul $t3, $t3, $t2		# $t3 *= heights[0]
	sw $t3, ($s3)			# hexVolumes[0] = #t3
	add $s5, $s5, $t3		# sum += $t3
	move $s6, $t3			# min = hexVolumes[0]
	move $s7, $t3			# max = hexVolumes[0]
	add $s0, $s0, 4			# apothems[0 + 1]
	add $s1, $s1, 4			# bases[0 + 1]
	add $s2, $s2, 4			# heights[0 + 1]
	add $s3, $s3, 4			# hexVolumes[0 + 1]
	sub $s4, $s4, 1			# len--
calcLoop:
	lw $t0, ($s0)			# apothems[i]
	lw $t1, ($s1)			# bases[i]
	lw $t2, ($s2)			# heights[i]
	li $t3, 3				# $t3 = 3
	mul $t3, $t3, $t0		# $t3 *= apothems[i]
	mul $t3, $t3, $t1		# $t3 *= bases[i]
	mul $t3, $t3, $t2		# $t3 *= heights[i]
	sw $t3, ($s3)			# hexVolumes[i] = #t3
	add $s5, $s5, $t3		# sum += $t3
	bge $t3, $s6, minDone	# if ($t3 >= min) goto minDone
	move $s6, $t3			# 	else min = $t3
minDone:
	ble $t3, $s7, maxDone	# if ($t3 >= max) goto maxDone
	move $s7, $t3			# 	else haMax = $t3
maxDone:
	add $s0, $s0, 4			# sideLens index + 1 (4 bytes)
	add $s1, $s1, 4			# apothemLens index + 1 (4 bytes)
	add $s2, $s2, 4			# hexAreas index + 1 (4 bytes)
	add $s3, $s3, 4			# hexVolumes index + 1 (4 bytes)
	sub $s4, $s4, 1			# len--
	bnez $s4, calcLoop		# if (len != 0) goto calcLoop

	sw $s5, volSum			# volSum = $s5
	sw $s6, volMin			# volMin = $s6
	sw $s7, volMax			# volMax = $s7
						# get volAve
	lw $t0, len				# $t0 = len
	div $t1, $s5, $t0		# $t1 = $s5(sum) / $t0(len)
	sw $t1, volAve			# volAve = $t1
						# get volMid
	la $s3, hexVolumes		# $s3 = hexVolumes[0] address
	div $t2, $t0, 2			# $t2 = len / 2
	mul $t2, $t2, 4			# $t2 *= 4 (offset)
	add $s3, $s3, $t2		# $s3 += $t2 (offset)
	lw $t3, ($s3)			# $t3 = hexVolumes[len / 2]
	sub $s3, $s3, 4			# offset - 4 bytes
	lw $t4, ($s3)			# $t3 = hexVolumes[(len /2) - 1]
	add $t4, $t4, $t3		# $t4 += $t3
	div $t5, $t4, 2			# $t5 = $t4 / 2
	sw $t4, volMid			# volMid = $t4


##########################################################
#  Display results.

	la	$a0, newLn		# print a newline
	li	$v0, 4
	syscall

#  Print min message followed by result.

	la	$a0, a1_st
	li	$v0, 4
	syscall				# print "min = "

	lw	$a0, volMin
	li	$v0, 1
	syscall				# print min

# -----
#  Print middle message followed by result.

	la	$a0, a2_st
	li	$v0, 4
	syscall				# print "med = "

	lw	$a0, volMid
	li	$v0, 1
	syscall				# print mid

# -----
#  Print max message followed by result.

	la	$a0, a3_st
	li	$v0, 4
	syscall				# print "max = "

	lw	$a0, volMax
	li	$v0, 1
	syscall				# print max

# -----
#  Print sum message followed by result.

	la	$a0, a4_st
	li	$v0, 4
	syscall				# print "sum = "

	lw	$a0, volSum
	li	$v0, 1
	syscall				# print sum

# -----
#  Print average message followed by result.

	la	$a0, a5_st
	li	$v0, 4
	syscall				# print "ave = "

	lw	$a0, volAve
	li	$v0, 1
	syscall				# print average

# -----
#  Done, terminate program.

endit:
	la	$a0, newLn		# print a newline
	li	$v0, 4
	syscall

	li	$v0, 10
	syscall				# all done!

.end main

