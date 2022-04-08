----------------------------------------------------------------------------------
-- Engineer: Atticus Russell
-- 
-- Create Date: 01/21/2022 6:18 PM
-- Design Name: 
-- Module Name: HW1Q4MuxSoln - Behavioral
-- Project Name: DSD 2 HW 1
-- Target Devices: 
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

entity Hw1Q4MuxSoln is
  Port ( 
    x   : in std_logic_vector (7 downto 0);
    sel : in std_logic_vector (2 downto 0);
    z   : out std_logic);
end entity Hw1Q4MuxSoln;

architecture Behavioral of Hw1Q4MuxSoln is
    begin
        --z_proc : process (x, sel) is begin
            --case sel is 
        with sel Select --creates an 8 to 1 mux
            z <=    x(0) when "000",
                    x(1) when "001",
                    x(2) when "010",
                    x(3) when "011",
                    x(4) when "100",
                    x(5) when "101",
                    x(6) when "110",
                    x(7) when others;
end Behavioral;