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

--------------------------------------------------------------------------------    
--	lab 6 part A write instructions that test each of our MIPS operations
--	NOTE put 3 NOPs between each instruction for pipelining
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
    
    --load values into registers and into data memory to use to test other operations
	--HACK: begin with one no-op - this stops my code from breaking. Not sure why at all but otherwise first instruction disappears in simulation
	x"00",x"00",x"00",x"00", 

    /* load value of 4 into register R1 using ORI with R0 
    -- ORI $1, $0, 0x04  | Op-code | rs  |  rt   |     imm          |
    32x"34010004"          001101   00000  00001   0000000000000100           */
	x"34",x"01",x"00",x"04",
	
    --follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
    x"00",x"00",x"00",x"00", 
    
    /* load value of 3 into register R2 using ORI with R0 
    -- ORI $2, $0, 0x03  | Op-code | rs  |  rt   |     imm          |
    32x"34020003"          001101   00000  00010   0000000000000011         */
    x"34",x"02",x"00",x"03",

   --follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
    x"00",x"00",x"00",x"00", 

    /* Add value in R2(exp 3) to value in R1(exp 4) store result in R3 (exp 7)  
    ADD $3, $1, $2  | Op-code | rs   | rt    |   rd | sh_amt | function |
    32x"00221820"      000000  00001   00010   00011  00000    100000       */
    x"00",x"22",x"18",x"20",

    --follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
    x"00",x"00",x"00",x"00", 

    /* store value from R3 (should be 7) into mem addr(rs offset by imm) [0]
    -- SW $3, 0($0)      | Op-code | rs   |  rt   |     imm          |
    32x"AC030000"          101011   00000  00011   0000000000000000         */
    x"AC",x"03",x"00",x"00",

	--follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
    x"00",x"00",x"00",x"00", 

    /* Load value from mem addr(rs = 0  offset by imm = 0) [0] into r4 (exp 7)
    -- LW $4, 0($0)      | Op-code | rs   |  rt   |     imm          |
    32x"8C040000"          100011   00000  00100   0000000000000000         */
	x"8C",x"04",x"00",x"00",

	--follow prev with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
    x"00",x"00",x"00",x"00",

	/* AND value in R4(exp 7) with value in R2(exp 3) and store result back in R4 (exp 3)  
    AND $4, $4, $2  | Op-code | rs   | rt    |   rd | sh_amt | function |
    32x"00822024"      000000  00100   00010   00100  00000    100100       */
	x"00",x"82",x"20",x"24",

	--follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
	x"00",x"00",x"00",x"00", 
	
	/* SUB value in R2(exp 3) from value in R1(exp 4) and store result in R4 (exp 1)  
    SUB $4, $1, $2  | Op-code | rs   | rt    |   rd | sh_amt | function |
    32x"00222022"      000000  00001   00010   00100  00000    100010       */
	x"00",x"22",x"20",x"22",

	--follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
	x"00",x"00",x"00",x"00", 

	/* SLLV value in R3(exp 7) by value in R2(exp 3) and store result in R5 (exp 56 aka 0x38)  
         rd, rt, rs
    SLLV R5, R2, R3  | Op-code | rs   | rt    |   rd | sh_amt | function (fake) |
    32x"00622800"      000000   00011  00010   00101  00000     000000       */
	x"00",x"62",x"28",x"00",

	--follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
	x"00",x"00",x"00",x"00", 

	/* SUB value in R5(exp 56) from value in R1(exp 4) and store result in R6 (exp -52 0xffffffCC)  
    SUB R6, R1, R5  | Op-code | rs   | rt    |   rd | sh_amt | function |
    32x"00253022"      000000  00001   00101   00110  00000    100010       */
	x"00",x"25",x"30",x"22",
	
	--follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
	x"00",x"00",x"00",x"00", 

	/*  SRAV value in R6(exp -52) by value in R4(exp 1) and store result in R7 (exp -25 aka 0xFFFFFFE6)  
    rd=rt>>rs	jk tho because swapped this all around and it works??
	         rd, rs, rt this could all be lies and propoganda
	    SRAV R7, R4, R6  | Op-code | rs   | rt    |   rd | sh_amt | function (fake) |
        32x"00C43803"      000000   00110  00100   00111  00000     000011       */
	x"00",x"C4",x"38",x"03",

	--follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
	x"00",x"00",x"00",x"00", 

	/*  SRLV value in R7(exp -25 aka FFFFFFE6) by value in R4(exp 1) and store result in R8 
    (exp 2,147,483,635 aka 0x7FFFFFF3)  
			 rd, rs, rt this could all be lies and propoganda
	    SRLV R8, R4, R6  | Op-code | rs   | rt    |   rd | sh_amt | function (fake) |
        32x"00E44002"      000000   00111  00100   01000  00000     000010       */
	x"00",x"e4",x"40",x"02",

	--follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
	x"00",x"00",x"00",x"00", 

	/* XOR value in R8(2,147,483,635 aka 0x7FFFFFF3) with value in R7(exp -25 aka 0xFFFFFFE6) and 
    store result in r9 (exp -2,147,483,627 aka 0x80000015)  
    XOR R9, R7, R8  | Op-code | rs   | rt    |   rd | sh_amt | function |
    32x"00E84826"      000000  00111   01000   01001  00000    100110       */
	x"00",x"E8",x"48",x"26",

	--follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
	x"00",x"00",x"00",x"00", 
	
	/* MULTU value in R2(exp 3) from value in R1(exp 4) and store result in R10 (exp 12 aka 0xC)  
    MULTU R10, R1, R2  | Op-code | rs   | rt    |   rd | sh_amt | function |
    32x"00225019"        000000    00001   00010  01010  00000    011001       */
	x"00",x"22",x"50",x"19",

	--follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
	x"00",x"00",x"00",x"00", 

	/* OR value in R2(exp 3) from value in R1(exp 4) and store result in R11 (exp 7)  
    OR R11, R1, R2  | Op-code | rs   | rt    |   rd | sh_amt | function |
    32x"00225019"     000000    00001   00010  01011  00000    100101       */
	x"00",x"22",x"58",x"25",

	--follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
	x"00",x"00",x"00",x"00", 

	/* XORI value in R10(exp 12 aka 0xC) with imm 0x3 and store result in R12(exp 15 aka 0xF)
    -- XORI R12, R10, 0x03  | Op-code | rs  |  rt   |     imm          |
    32x"394C0003"         	 001110    01010  01100   0000000000000011           */
	x"39",x"4C",x"00",x"03",

	--follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
	x"00",x"00",x"00",x"00", 

	/* ANDI value in R10(exp 12 aka 0xC) with imm 0xC and store result in R13(exp 12 aka 0xC)
    -- ANDI R13, R12, 0xC  | Op-code | rs  |  rt   |     imm          |
    32x"318D000C"         	 001100    01100  01101   0000000000001100           */
	x"31",x"8D",x"00",x"0C",

	--follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
	x"00",x"00",x"00",x"00",

	/* ADDI value in R10(exp 12 aka 0xC) with imm 0xC and store result in R14(exp 24 aka 0x18)
    -- ADDI R14, R10, 0xC  | Op-code | rs  |  rt   |     imm          |
    32x"214E000C"         	 001000   01010  01110   0000000000001100           */
	x"21",x"4E",x"00",x"0C",

	-- NOTE: the above instructions were tested and confirmed to function properly

    -- I-type template (store / load)
    /* xxxx value of xxxx into mem addr xxxx using xxxx  
    -- xW $x, $x, 0xXX  | Op-code | rs  |  rt   |     imm          |
    32x"34020003"          001101   00000  00010   0000000000000011         */
    --x"34",x"00",x"00",x"00",

    -- I-type template (immediate)
    /* xxxx value of xxxx into mem addr xxxx using xxxx (imm)
    -- xxxI $x, $x, 0xXX  | Op-code | rs  |  rt   |     imm          |
    32x"34020003"          00000   00000  00000     0000000000000000         */
    --x"34",x"02",x"00",x"03",

    -- R-type template 
    /* xxx value in Rx(x) with value in Rx(x) store result in Rx (should be x)  
    xxx $x, $x, $x  | Op-code | rs   | rt    |   rd | sh_amt | function |
    32x"0xxxxxxx"      000000  00001   00010   00011  00000    100000       */
    --x"0x",x"xx",x"xx",x"xx",

	-- TODO: lab 6 part B probably Branch off and write MIPS program that perform the 
    -- fibonacci sequence and generate at least the first 10 Fib numbers
    
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
