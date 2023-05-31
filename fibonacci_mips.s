#MIPS Fibonacci DSD2
#Atticus Russell
#This program will compute the first 10 fibonacci numbers using only MIPS instructions that have been implemented in the MIPS microprocessor constructed in VHDL (no jump and such)
# will store the nth Fib number into corresponding nth position in data memory 
# Unique things: 31 unreserved registers, no jumping, no branching, messed up Shifts and multiplies because of how this class is specified, mo move, 
# Translation: this is gonna be hardcoded

# We'll compute the first 10 numbers and store them in Mem[0] through Mem[9]

# with no branching this might just be hardcoded like freshman year MECE MATLAB

# fib(n) = fib(n-1) + fib(n-2)
# 0
# 1		
# 1 	= 	1 	+ 	0
# 2 	= 	1 	+ 	1
# 3 	= 	2 	+ 	1
# 5 	= 	3 	+ 	2
# 8 	= 	5 	+ 	3
# 13 	= 	8 	+	5
# 21 	= 	13 	+ 	8
# 34	=	21	+	13

# we need the first and second terms. Will have them be t1 = 0 and t2 = 1
ORI R10, R0, 0x0 	# load value of t1 = 0 into register R10 using ORI with R0 
ORI R11, R0, 0x1 	# load value of t2 = 1 into register R11 using ORI with R0 

#store t1 aka fib(n=1) and t2 aka fib(n=2) into data memory
SW R10, 0x0(R0) 	# Mem[$zero + 0] <= R10
SW R11, 0x1(R0) 	# Mem[$zero + 1] <= R11

ADD R12, R11, R10 	# R12 <= fib(n=3) = fib(n=2) + fib(n=1)
SW 	R12, 0x2(R0) 	# Mem[$zero + 2] <= R12

ADD R13, R12, R11 	# R13 <= fib(n=4) = fib(n=3) + fib(n=2)
SW 	R13, 0x3(R0) 	# Mem[$zero + 3] <= R13

ADD R14, R13, R12 	# R14 <= fib(n=5) = fib(n=4) + fib(n=3)
SW 	R14, 0x4(R0) 	# Mem[$zero + 4] <= R14

ADD R15, R14, R13	# R15 <= fib(n=6) = fib(n=5) + fib(n=4)
SW 	R15, 0x5(R0) 	# Mem[$zero + 5] <= R15

ADD R16, R15, R14	# R16 <= fib(n=7) = fib(n=6) + fib(n=5)
SW 	R16, 0x6(R0) 	# Mem[$zero + 6] <= R16

ADD R17, R16, R15	# R17 <= fib(n=8) = fib(n=7) + fib(n=6)
SW 	R17, 0x7(R0) 	# Mem[$zero + 7] <= R17

ADD R18, R17, R16	# R18 <= fib(n=9) = fib(n=8) + fib(n=7)
SW 	R18, 0x8(R0) 	# Mem[$zero + 8] <= R18

ADD R19, R18, R17	# R19 <= fib(n=10) = fib(n=9) + fib(n=8)
SW 	R19, 0x9(R0) 	# Mem[$zero + 9] <= R19

# the memory addresses should now hold the correct values


