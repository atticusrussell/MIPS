----------------------------------------------------------------------------------
-- Engineer: Atticus Russell
-- 
-- Create Date: 01/21/2022 11:52:21 AM
-- Design Name: 
-- Module Name: HW1Q2GenerateSoln - Behavioral
-- Project Name: DSD 2 HW 1
-- Target Devices: 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity Hw1Q2GenerateSoln is
    generic(width : integer := 7);
    Port (a, b      : in std_logic_vector(width - 1 downto 0);
        cout    :   out std_logic;
        sum     :   out std_logic_vector(width - 1 downto 0));
end Hw1Q2GenerateSoln;

architecture Behavioral of Hw1Q2GenerateSoln is
    signal carry: std_logic_vector(width-1 downto 1);
    component HW1Q2Adder is port(
        a, b, cin   : in std_logic;
        s, cout     : out std_logic
        );
    end component Hw1Q2Adder;
begin
    adder: for i in 0 to width-1 generate
        ls_bit  : if i=0 generate
            ls_cell : HW1Q2Adder port map
                (a      => a(i)
                ,b      => b(i)
                ,cin    => '0'
                ,s      => sum(i)
                ,cout   => carry(i+1)
                );
        end generate ls_bit;
        middle_bit  : if i > 0 and i < width-1 generate
            middle_cell : HW1Q2Adder port map
                (a      => a(i)
                ,b      => b(i)
                ,cin    => carry(i) 
                ,s      => sum(i)
                ,cout   => carry(i+1)
                );
        end generate middle_bit;
         ms_bit  : if i= width-1 generate
            ms_cell : HW1Q2Adder port map
                (a      => a(i)
                ,b      => b(i)
                ,cin    => carry(i)
                ,s      => sum(i)
                ,cout   => cout
                );
        end generate ms_bit;
    end generate adder;
end Behavioral;
