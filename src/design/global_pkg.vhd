----------------------------------------------------------------------------------
-- Company: Rochester Institute of Technology
-- Engineer: Atticus Russell ajr8934@rit.edu
-- 
-- Create Date: 01/17/2022 09:44:27 PM
-- Design Name: globals
-- Module Name: globals - package (library)
-- Project Name: Lab1
-- Target Devices: Basys3
--
-- Description: Constants used in top and test bench lavel
--      Xilinx does not like generics at the top level of a design
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
package globals is
    constant N : INTEGER := 32;
    constant M : INTEGER := 5;
end;