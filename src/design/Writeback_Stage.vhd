----------------------------------------------------------------------------------
-- Engineer: Atticus Russell 
-- Class: DSD 2
-- Create Date: 03/24/2022 11:06:20 AM
-- Design Name: 
-- Module Name: Writeback Stage - Behavioral
-- Project Name: 
-- Target Devices: Technically Basys 3. Never implemented on Hardware though.
-- Tool Versions: 
-- Description: WriteBack Stage of simulated MIPS processor
-- 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Writeback_Stage is
    Port ( 
            -- Inputs
           RegWrite : in STD_LOGIC;
           MemtoReg : in STD_LOGIC;
           ALUResult : in STD_LOGIC_VECTOR (31 downto 0);
           ReadData : in STD_LOGIC_VECTOR (31 downto 0);
           WriteReg : in STD_LOGIC_VECTOR (4 downto 0);
           -- Outputs
           RegWriteOut : out STD_LOGIC;
           WriteRegOut : out STD_LOGIC_VECTOR (4 downto 0);
           Result : out STD_LOGIC_VECTOR (31 downto 0));
end Writeback_Stage;

architecture Behavioral of Writeback_Stage is
    
begin
    case_en: process (all) is
    begin
        case (  MemtoReg  ) is
            when    '1' =>
                Result   <=  ReadData;                   
            when others =>
                Result  <=  ALUResult;
        end case;
    end process;

    WriteRegOut <=  WriteReg;
    RegWriteOut <= RegWrite;
end Behavioral;
