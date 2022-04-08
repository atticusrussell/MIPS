----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/21/2022 03:26:30 PM
-- Design Name: 
-- Module Name: Hw1Q2GenerateSolnTBOne - tb
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Hw1Q2GenerateSolnTBOne is
end Hw1Q2GenerateSolnTBOne;

architecture tb of Hw1Q2GenerateSolnTBOne is
    constant width  :   integer    :=4;
    signal a,b      :   std_logic_vector (width-1 downto 0) := (others => '0');
    signal cout     :   std_logic;
    signal sum      :   std_logic_vector (width-1 downto 0);    
begin
    dut :   entity work.Hw1Q2GenerateSoln
    generic map (width => width)
    port map (a => a,   b => b,
        cout => cout,
        sum => sum);
    
    stimuli : process
    begin
        a <= 4ux"2";
        b <= 4ux"3";
        wait for 100 ns;
        a <= 4ux"4";
        b <= 4ux"3";
        wait for 100 ns;
        a <= 4ux"F";
        b <= 4ux"F";
        wait for 100 ns;
        wait;
    end process;
end tb;
