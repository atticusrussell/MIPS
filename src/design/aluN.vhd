----------------------------------------------------------------------------------
-- Company: Rochester Institute of Technology (RIT)
-- Engineer: Atticus Russell ajr8934@rit.edu
-- 
-- Create Date: 01/17/2022 09:52:00 PM
-- Design Name: alu32
-- Project Name: Lab1
-- Target Devices: Basys3 (but dont have HW)
--
-- Description: 32-bit Arithmetic Logic Unit -- editing for Lab 4
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.globals.all; -- provides N and M to top level

entity aluN is
    generic(N : integer := 32); --bit width - default 32
    PORT ( 
            in1     : IN    std_logic_vector(N-1 downto 0);
            in2     : IN    std_logic_vector(N-1 downto 0);
            control : IN    std_logic_vector(3 downto 0);
            out1    : OUT   std_logic_vector(N-1 downto 0)
        );
end aluN;

architecture structural of aluN is
    
   
--    --Declare opcodes 
    constant or_op   : STD_Logic_vector(3 downto 0) := "1000"; -- also ori
    constant and_op  : STD_Logic_vector(3 downto 0) := "1010"; 
    constant xor_op  : STD_Logic_vector(3 downto 0) := "1011";
    constant sll_op  : STD_Logic_vector(3 downto 0) := "1100";
    constant srl_op  : STD_Logic_vector(3 downto 0) := "1101";
    constant sra_op  : STD_Logic_vector(3 downto 0) := "1110";
    
    constant add_op : std_logic_vector(3 downto 0) := "0100"; --also addi sw lw
    constant sub_op : std_logic_vector(3 downto 0) := "0101";
    
    constant multu_op : std_logic_vector(3 downto 0) := "0110";
    
    

    --declare signals
    signal or_result    : std_logic_vector(N-1 downto 0);
    signal and_result   : std_logic_vector(N-1 downto 0);    
    signal xor_result   : std_logic_vector(N-1 downto 0);
    signal sll_result   : std_logic_vector(N-1 downto 0);
    signal srl_result   : std_logic_vector(N-1 downto 0);
    signal sra_result   : std_logic_vector(N-1 downto 0);
    
    signal add_result   : std_logic_vector(N-1 downto 0);
    signal sub_result   : std_logic_vector(N-1 downto 0);
    
    signal multu_result   : std_logic_vector(N-1 downto 0);
    
    
    
begin
    --Instantiate the OR unit
    or_comp    : entity work.orN
        generic map ( N => N)
        port map ( a=> in1, b => in2, y => or_result );
        
    --Instantiate the andN unit
    and_comp    : entity work.andN
        generic map ( N => N)
        port map ( a => in1, b => in2, y => and_result );
        
    --Instantiate the XOR unit
    xor_comp    : entity work.xorN
        generic map ( N => N)
        port map ( a=> in1, b => in2, y => xor_result );

    --Instantiate the SLL unit
    sll_comp    : entity work.sllN
        generic map ( N => N, M => M)
        port map ( a=> in1, SHIFT_AMT => in2(M-1 downto 0), y => sll_result );
    --Instantiate the SRL unit 
    srl_comp    : entity work.srlN
        generic map ( N => N, M => M)
        port map ( a=> in1, SHIFT_AMT => in2(M-1 downto 0), y => srl_result );
    --Instantiate the SRA unit 
    sra_comp    : entity work.sraN
        generic map ( N => N, M => M)
        port map ( a=> in1, SHIFT_AMT => in2(M-1 downto 0), y => sra_result );
        
    --Instantiate the ADD unit   note maybe 2's comp issues
    add_comp    : entity work.RippleCarryAdderSubtractorN
        generic map ( N => N)
        port map ( in1=> in1, in2 => in2, op => '0', sum => add_result );
        
     --Instantiate the SUB unit  note maybe 2's comp issues
    sub_comp    : entity work.RippleCarryAdderSubtractorN
        generic map ( N => N)
        port map ( in1=> in1, in2 => in2, op => '1', sum => sub_result );
        
    -- Instantiate the MULTU unit
    mult_comp_inst: entity work.mult_comp
        generic map (
            N => N
        )
        port map (
            A_top   => in1(15 downto 0),
            B_top   => in2(15 downto 0),
            Product => multu_result
        );  
    
      
    -- Use control to select which operation to show/perform
    with control select  
                 out1 <=    or_result when  or_op,
                            and_result when and_op,
                            xor_result when xor_op,
                            sll_result when sll_op,
                            srl_result when srl_op,
                            sra_result when sra_op,
                                
                            add_result when add_op,
                            sub_result when sub_op,
                                
                            multu_result when multu_op,
                            
                            
                            (others => '0') when others;    
end structural;
