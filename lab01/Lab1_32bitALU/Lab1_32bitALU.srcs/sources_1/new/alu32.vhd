----------------------------------------------------------------------------------
-- Company: Rochester Institute of Technology (RIT)
-- Engineer: Atticus Russell ajr8934@rit.edu
-- 
-- Create Date: 01/17/2022 09:52:00 PM
-- Design Name: alu32
-- Project Name: Lab1
-- Target Devices: Basys3 (but dont have HW)
--
-- Description: 32-bit Arithmetic Logic Unit
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.globals.all; -- provides N and M to top level

entity alu32 is
    
    PORT ( 
            A   : IN    std_logic_vector(N-1 downto 0);
            B   : IN    std_logic_vector(N-1 downto 0);
            OP  : IN    std_logic_vector(3 downto 0);
            Y   : OUT   std_logic_vector(N-1 downto 0)
        );
end alu32;

architecture structural of alu32 is
    
   
--    --Declare opcodes 
--    constant or_op   : STD_Logic_vector(3 downto 0) := "1000";
--    constant and_op  : STD_Logic_vector(3 downto 0) := "1010";
--    constant xor_op  : STD_Logic_vector(3 downto 0) := "1011";
--    constant sll_op  : STD_Logic_vector(3 downto 0) := "1100";
--    constant srl_op  : STD_Logic_vector(3 downto 0) := "1101";
--    constant sra_op  : STD_Logic_vector(3 downto 0) := "1110";
    

    --declare signals
    signal or_result    : std_logic_vector(N-1 downto 0);
    signal and_result   : std_logic_vector(N-1 downto 0);    
    signal xor_result   : std_logic_vector(N-1 downto 0);
    signal sll_result   : std_logic_vector(N-1 downto 0);
    signal srl_result   : std_logic_vector(N-1 downto 0);
    signal sra_result   : std_logic_vector(N-1 downto 0);
    
    
    
begin
    --Instantiate the OR unit
    or_comp    : entity work.orN
        generic map ( N => N)
        port map ( A=> A, B => B, Y => or_result );
        
    --Instantiate the andN unit
    and_comp    : entity work.andN
        generic map ( N => N)
        port map ( A=> A, B => B, Y => and_result );
        
    --Instantiate the XOR unit
    xor_comp    : entity work.xorN
        generic map ( N => N)
        port map ( A=> A, B => B, Y => xor_result );

    --Instantiate the SLL unit
    sll_comp    : entity work.sllN
        generic map ( N => N, M => M)
        port map ( A=> A, SHIFT_AMT => B(M-1 downto 0), Y => sll_result );
    --Instantiate the SRL unit 
    srl_comp    : entity work.srlN
        generic map ( N => N, M => M)
        port map ( A=> A, SHIFT_AMT => B(M-1 downto 0), Y => srl_result );
    --Instantiate the SRA unit 
    sra_comp    : entity work.sraN
        generic map ( N => N, M => M)
        port map ( A=> A, SHIFT_AMT => B(M-1 downto 0), Y => sra_result );
      
    -- Use OP to control which operation to show/perform
    with OP select  Y <=    or_result when "1000",
                            and_result when "1010",
                            xor_result when "1011",
                            sll_result when "1100",
                            srl_result when "1101",
                            sra_result when "1110",
                            (others => '0') when others;    
end structural;