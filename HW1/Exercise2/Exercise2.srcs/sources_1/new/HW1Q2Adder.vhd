----------------------------------------------------------------------------------
-- Engineer: Atticus Russell
-- 
-- Create Date: 01/21/2022 09:41:21 AM
-- Design Name: 
-- Module Name: HW1Q2Adder - Behavioral
-- Project Name: DSD 2 HW 1
-- Target Devices: 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity HW1Q2Adder is  Port ( 
    a, b, cin : in std_logic;
    s, cout   : out std_logic
    );
end entity HW1Q2Adder;

architecture Behavioral of HW1Q2Adder is
    begin
    s       <= a XOR b XOR cin;
    cout    <= (a AND b) OR (cin AND a) OR (cin AND b);
end Behavioral;
