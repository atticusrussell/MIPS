----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/02/2022 04:38:06 PM
-- Design Name: 
-- Module Name: Execute - Behavioral
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

entity Execute is
    Port ( 
------inputs---------------------------
        --control signals
           RegWrite : in STD_LOGIC; -- pass through - Determines whether the instruction being processed writes to a register.
           MemtoReg : in STD_LOGIC; -- pass through - Determines whether the instruction being processed reads from memory.
           MemWrite : in STD_LOGIC; -- pass through - Determines whether the instruction being processed writes to memory
           ALUControl : in STD_LOGIC_VECTOR (3 downto 0); -- The ALU opcode
           ALUSrc : in STD_LOGIC; -- If set then ALU uses the immediate, otherwise ALU uses two registers.
           RegDst : in STD_LOGIC; -- determines which register is the destination register of the instruction. 
        --real data stuff   
           RegSrcA : in STD_LOGIC_VECTOR (31 downto 0); --Data stored in the first register being read.
           RegSrcB : in STD_LOGIC_VECTOR (31 downto 0); --Data stored in the second register being read.
           RtDest : in STD_LOGIC_VECTOR (4 downto 0); --Address of rt in the instruction.
           RdDest : in STD_LOGIC_VECTOR (4 downto 0); --Address of rd in the instruction.
           SignImm : in STD_LOGIC_VECTOR (31 downto 0); --The sign extended immediate of the instruction.
------outputs------------------------------------------------------------
       --control signal passthroughs
           RegWriteOut : out STD_LOGIC; -- control bit passthrough
           MemtoRegOut : out STD_LOGIC; -- control bit passthrough
           MemWriteOut : out STD_LOGIC; -- control bit passthrough
       --important Execute outputs
           ALUResult : out STD_LOGIC_VECTOR (31 downto 0); -- the value output by the ALU
           WriteData : out STD_LOGIC_VECTOR (31 downto 0); -- the Data to be written into memory -- basically a passthrough
           WriteReg : out STD_LOGIC_VECTOR (4 downto 0)); -- the address of the register being written to
end Execute;

architecture Behavioral of Execute is
    constant N : integer := 32;
    --signals for ALU inputs
    signal sig_ALU_in_1 : std_logic_vector(31 downto 0);
    signal sig_ALU_in_2 : std_logic_vector(31 downto 0);
    
    --signal for WriteReg
    signal sig_WriteReg : std_logic_vector(4 downto 0);

begin
    --decide what to use for the ALU inputs
    sig_ALU_in_1 <= RegSrcA;  
    with ALUSrc select
        sig_ALU_in_2 <= SignImm when '1', 
                        RegSrcB when others;
    
    --decide which WriteReg should be 
     with RegDst select
        sig_WriteReg <= RtDest when '1',    --address of register Rt
                        RdDest when others; --address of register Rd
     
    --Instantiate the ALU 
    aluN_comp    : entity work.aluN
        generic map ( N => N)
        port map ( 
            in1=> sig_ALU_in_1,
            in2 => sig_ALU_in_2,
            control => ALUControl,
            out1 => ALUResult
        );

    --passthrough RegSourceB to WriteData
    WriteData <= RegSrcB;
    --assign Writereg to the signal value
    WriteReg <= sig_WriteReg;
    --control signal passthrough
    RegWriteOut <= RegWrite; --passthroughs
    MemtoRegOut <= MemtoReg; --passthrough
    MemWriteOut <= MemWrite; --passthrough
end Behavioral;
