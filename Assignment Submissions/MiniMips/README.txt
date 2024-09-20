Results: I have a working circuit that uses the switches to decide which memory address contents to show on the LEDs
Problems: I had a really hard time understanding what the assignment wanted and how to do it

Files:
- exmem.v (external memory Verilog)
- fibn_asm.png (screenshot that shows the given machine code storing the correct value at address 255)
- Memory Map.png (screenshot that shows which portion of my memory I decided to have be memory mapped)
- MiniMips.v (top level Verilog that pulls everything together)
- mipscpu.v (cpu Verilog)
- new_fib.asm (assembly code used to construct machine code for the new Fibonacci code)
- new_fib.dat (machine code for new Fibonacci code)
- new_fib_asm.png (waveforms showing all of the Fibonacci values in their correct spots)
- README.txt (this file)
- tb_MiniMips.v (the testbench file used to get waveforms)
- Working Board.MOV (video of the FPGA running the new Fibonacci code)