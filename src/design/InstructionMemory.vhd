library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity InstructionMemory is
    Port ( addr : in STD_LOGIC_VECTOR (27 downto 0); --address in memory to read from
           d_out : out STD_LOGIC_VECTOR (31 downto 0)); --the instruction read from memory
end InstructionMemory;

architecture Behavioral of InstructionMemory is
    --there are 1024 bytes of memory - byte addressible- 1024 of 8 bit (1 byte) memory cells
    type mem_type is array (0 to 1023) of std_logic_vector (7 downto 0);
    signal inst_mem : mem_type := (


--------------------------------------------------------------------------------    =
--	[x] lab 6 part B write MIPS program that perform the fibonacci sequence and 
--	generate at least the first 10 Fib numbers
--
------------------------------------------------------------------------
--	R-type 
--	R-type instructions interact only with registers
--  R-type instructions have 32 bits formatted as such:
--  part:    | Op-code | rs | rt | rd | sh_amt | function |
--  bits:    |    6    | 5  | 5  | 5  |   5    |     6    |
--
--  R-type opcodes are "000000"
--
--  R-type functions implemented in this MIPS processor are as follows:
-- (tested)
-- [x] ADD,      function: "100000"    Ex. ADD     rd, rs, rt  :   R[rd] <= R[rs] + R[rt]
-- [x] AND,      function: "100100"    Ex. AND     rd, rs, rt  :   R[rd] <= R[rs] AND R[rt] 
-- [x] MULTU,    function: "011001"    Ex. MULTU   rd, rs, rt  :   R[rd] <= R[rs] x R[rt] unsigned mult
-- [x] OR,       function: "100101"    Ex. OR      rd, rs, rt  :   R[rd] <= R[rs] OR R[rt]
-- [x] SLLV,     function: "000000"    Ex. SLLV    rd, rt, rs  :   R[rd] <= R[rs] << R[rt]   shift rs left by rt
-- [x] SRLV,     function: "000010"    Ex. SRLV    rd, rt, rs  :   R[rd] <= R[rs] >> R[rt]  shift rs right by rt
-- [x] SRAV,     function: "000011"    Ex. SRAV    rd, rt, rs  :   R[rd] <= R[rs] >> R[rt]  shift rs right by rt and sign extend
-- [x] SUB,      function: "100010"    Ex. SUB     rd, rs, rt  :   R[rd] <= R[rs] - R[rt]  
-- [x] XOR,      function: "100110"    Ex. XOR     rd, rs, rt  :   R[rd] <= R[rs] XOR R[rt]  
--
--------------------------------------------------------------------------------
--	I-type
--  I-type instructions interact with immediate values, registers, and (sometimes) memory
--  I-type instructions have 32 bits formatted as such:
--  part:    | Op-code | rs | rt | imm |
--  bits:    |    6    | 5  | 5  | 16  |   
--
--  I-type instructions implemented in this MIPS processor are as follows:
--  (tested)
-- [x] ADDI,      op-code: "001000"    Ex. ADDI    rt, rs, imm  :   R[rt] <= R[rs] + imm
-- [x] ANDI,      op-code: "001100"    Ex. ANDI    rt, rs, imm  :   R[rt] <= R[rs] AND imm
-- [x] ORI,       op-code: "001101"    Ex. ORI     rt, rs, imm  :   R[rt] <= R[rs] OR imm
-- [x] XORI,      op-copde: "001110"    Ex. XORI    rt, rs, imm  :   R[rt] <= R[rs] XOR imm
-- [x] SW,        op-code: "101011"    Ex. SW      rt, imm(rs) : Mem[R[rs] + imm] <= R[rt]
-- [x] LW,        op-code: "100011"    Ex. LW      rt, imm(rs) : R[rt] <= Mem[R[rs] + imm]
--------------------------------------------------------------------------------
-- 	Program description: 
-- 	This program will compute the first 10 fibonacci numbers using only the above MIPS instructions that have been implemented in the MIPS microprocessor constructed in VHDL
-- 	Unique things: 31 unreserved registers, no jumping, no branching, messed up Shifts and multiplies 
--	Translation: this is gonna be hardcoded like freshman year MECE MATLAB
--	We'll compute the first 10 numbers and store them in Mem[0] through Mem[9]
--  fib(n) = fib(n-1) + fib(n-2)
--  0
--  1		
--  1 	= 	1 	+ 	0
--  2 	= 	1 	+ 	1
--  3 	= 	2 	+ 	1
--  5 	= 	3 	+ 	2
--  8 	= 	5 	+ 	3
--  13 	= 	8 	+	5
--  21 	= 	13 	+ 	8
--  34	=	21	+	13
--	we need the first and second terms. Will have them be t1 = 0 and t2 = 1
----------------------------------------------------------------------------------------------------
	-- NOTE put 3 NOPs between each instruction for pipelining

	x"00",x"00",x"00",x"00",		--HACK: begin with one no-op - this stops  first instruction from disappearing. Possibly because I reset simulation right away in the testbench

	-- below the following line are the MIPS fib instructions
	------------------------------------------------------------------------------------------------

	-- 0x340A0000				load value of t1 = 0 into register R10: 
	x"34",x"0A",x"00",x"00",	-- ORI R10, R0, 0x0 	# R10 <= $zero | 0x0
	x"00",x"00",x"00",x"00", 		 
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",		
	-- 0xAC0A0000				store t1 aka fib(n=1) into data memory
	x"AC",x"0A",x"00",x"00",	-- SW R10, 0x0(R0) 		# Mem[$zero + 0] <= R10
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",


	-- 0x340B0001				load value of t2 = 1 into register R11: 
	x"34",x"0B",x"00",x"01",	-- ORI R11, R0, 0x1		# R11 <= 1 = $zero | 0x1
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",
	-- 0xAC0B0001				store t2 aka fib(n=2) into data memory
	x"AC",x"0B",x"00",x"01",	-- SW R11, 0x1(R0) 		# Mem[$zero + 1] <= R11
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",

	
	-- 0x016A6020
	x"01",x"6A",x"60",x"20",	-- ADD R12, R11, R10 	# R12 <= fib(n=3) = fib(n=2) + fib(n=1)
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",
	-- 0xAC0C0002
	x"AC",x"0C",x"00",x"02",	-- SW R12, 0x2(R0) 		# Mem[$zero + 2] <= R12
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",


	-- 0x018B6820
	x"01",x"8B",x"68",x"20",	-- ADD R13, R12, R11 	# R13 <= fib(n=4) = fib(n=3) + fib(n=2)
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",
	-- 0xAC0D0003
	x"AC",x"0D",x"00",x"03",	-- SW R13, 0x3(R0) 		# Mem[$zero + 3] <= R13
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",

	
	-- 0x01AC7020
	x"01",x"AC",x"70",x"20",	--ADD R14, R13, R12 	# R14 <= fib(n=5) = fib(n=4) + fib(n=3)
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",
	-- 0xAC0E0004
	x"AC",x"0E",x"00",x"04",	-- SW R14, 0x4(R0) 		# Mem[$zero + 4] <= R14
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",

	
	-- 0x01CD7820
	x"01",x"CD",x"78",x"20",	-- ADD R15, R14, R13		# R15 <= fib(n=6) = fib(n=5) + fib(n=4)
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",
	-- 0xAC0F0005
	x"AC",x"0F",x"00",x"05",	-- SW R15, 0x5(R0) 			# Mem[$zero + 5] <= R15
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",


	-- 0x01EE8020
	x"01",x"EE",x"80",x"20",	-- ADD R16, R15, R14		# R16 <= fib(n=7) = fib(n=6) + fib(n=5)
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",
	-- 0xAC100006
	x"AC",x"10",x"00",x"06",	-- SW R16, 0x6(R0) 			# Mem[$zero + 6] <= R16
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",

	
	-- 0x020F8820
	x"02",x"0F",x"88",x"20",	-- ADD R17, R16, R15		# R17 <= fib(n=8) = fib(n=7) + fib(n=6)
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",
	-- 0xAC110007
	x"AC",x"11",x"00",x"07",	-- SW R17, 0x7(R0) 			# Mem[$zero + 7] <= R17
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",

	
	-- 0x02309020
	x"02",x"30",x"90",x"20",	-- ADD R18, R17, R16		# R18 <= fib(n=9) = fib(n=8) + fib(n=7)
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",
	-- 0xAC120008
	x"AC",x"12",x"00",x"08",	-- SW R18, 0x8(R0) 			# Mem[$zero + 8] <= R18
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",


	-- 0x02519820
	x"02",x"51",x"98",x"20",	-- ADD R19, R18, R17		# R19 <= fib(n=10) = fib(n=9) + fib(n=8)
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",
	-- 0xAC130009
	x"AC",x"13",x"00",x"09",	-- SW R19, 0x9(R0) 			# Mem[$zero + 9] <= R19
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",

	--okay so lab 7 time and doing sythesis it appears that my data memory disappears
	-- TODO
	-- [ ] make a LW instruction output
	-- lets load the first word out of memory

	 /* Load value from mem addr(rs = 0  offset by imm = 5)  into r7 (exp 7)
    -- LW $4, 0($0)      | Op-code | rs   |  rt   |     imm          |
    32x"8C070000"          100011   00000  00111   0000000000000101         */
	x"8C",x"07",x"00",x"05",



	-- the memory addresses should now hold the correct values

    others =>x"00"
    );
begin
    
    process(addr) begin
        if ((to_integer(unsigned(addr)))> 1023) then
             d_out <= (others =>'0');
        else
            d_out <= inst_mem(to_integer(unsigned(addr))) & 
            inst_mem(to_integer(unsigned(addr)+1)) &
            inst_mem(to_integer(unsigned(addr)+2)) &
            inst_mem(to_integer(unsigned(addr)+3));
        end if;
    end process;
end Behavioral;
