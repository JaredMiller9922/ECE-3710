# Computes the first 14 Fibonacci numbers starting at 0
# Stores those number in memory locations 128 through 141
# Can not use any more than 8 registers
# $1 = f1
# $2 = f2
# $3 = i
# $4 = 13 
# $5 = switches
fibn: addi $1, $0, 1          # Initialize f1 to 1
    addi $2, $0, 0            # Initialize f2 to 0
    addi $3, $0, 1            # Initialize i to 1 
    addi $4, $0, 13           # Initialize n to 13
    sb $1, 128($1)            # Store the first fibonacci at index 128 + 1
    sb $2, 128($0)            # Store the second fionacci at index 128 + 0
loop:   beq $3, $4, end		  # Done with loop if i = 13
	add $1, $1, $2		      # f1 = f1 + f2
	sub $2, $1, $2		      # f2 = f1 - f2
	addi $3, $3, 1		      # i = i + 1
    sb  $1, 128($3)           # Stores f1 byte at 128 + i 
	j loop			          # repeat until done
forever_loop: lb $5, 192($0)  # Store the value of the switches in register 5
    addi $5, $5, 128          # Add memory offset 128
    lb $6, 0($5)              # Load the value of the data at Mem[128 + switches]
    sb $6, 193($0)            # Store the value of the LEDs 
    j forever_loop
end:	