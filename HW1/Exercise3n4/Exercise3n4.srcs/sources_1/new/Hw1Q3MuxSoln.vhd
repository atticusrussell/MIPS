----------------------------------------------------------------------------------
-- Engineer: Atticus Russell
-- 
-- Create Date: 01/21/2022 4 PM
-- Design Name: 
-- Module Name: HW1Q3MuxSoln - Behavioral
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

entity Hw1Q3MuxSoln is
  Port ( 
    x   : in std_logic_vector (7 downto 0);
    sel : in std_logic_vector (2 downto 0);
    z   : out std_logic);
end entity Hw1Q3MuxSoln;

architecture Behavioral of Hw1Q3MuxSoln is
    begin
        z_proc : process (x, sel) is begin
            case sel is 
                when "000" => z <= x(0);
                
                when "001" => z <= x(1);
                when "010" => z <= x(2);
                when "011" => z <= x(3);
                when "100" => z <= x(4);
                when "101" => z <= x(5);
                when "110" => z <= x(6);
                
                when others => z <= x(7);
            end case;
        end process;
end Behavioral;
