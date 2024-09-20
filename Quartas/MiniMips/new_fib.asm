# Computes the first 14 Fibonacci numbers starting at 0
# Stores those number in memory locations 128 through 141
# Can not use any more than 8 registers
# $1 = f1
# $2 = f2
# $3 = i
# $4 = 14
fibn: addi $1, $0, 1  # Initialize f1 to 1
    addi $2, $0, 0  # Initialize f2 to 0
    addi $3, $0, 0  # Initialize i to 0 
    addi $4, $0, 15 # Initialize n to 15
loop:   beq $3, $4, end		# Done with loop if n = 15
	add $1, $1, $2		# f1 = f1 + f2
	sub $2, $1, $2		# f2 = f1 - f2
    sb  $1, 128($3)     # Stores the byte at 128 + i 
	addi $3, $3, 1		# i = i + 1
	j loop			# repeat until done
end:	