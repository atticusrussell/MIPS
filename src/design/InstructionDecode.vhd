-------------------------------------------------
--  File:          InstructionDecode.vhd
--
--  Entity:        InstructionDecode 
--  Author:        Atticus Russell
--  Created:       2/21/2022
--  Assignment:  RIT CMPE 260 DSD 2 Exercise 3
------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity InstructionDecode is
    Port ( 
    --------- INPUTS ------------------
        --Main Input
        Instruction : in STD_LOGIC_VECTOR (31 downto 0); -- The op-code for the instruction being decoded
        --CLK
        clk : in STD_LOGIC; -- The system clock
        --WB Inputs
        RegWriteAddr : in STD_LOGIC_VECTOR (4 downto 0); -- The address of the register being written to
        RegWriteData : in STD_LOGIC_VECTOR (31 downto 0); -- Data to be written into the Register File
        RegWriteEn : in STD_LOGIC; -- Register File write enable
    ---------- OUTPUTS ----------------
        --Cotrol Unit Outputs
        RegWrite : out STD_LOGIC; -- Control bit. Set if the instruction requires register writing.
        MemtoReg : out STD_LOGIC; -- Control bit. Set if the instruction requires reading from Memory.
        MemWrite : out STD_LOGIC; -- Control bit. Set if the instruction requires writing to Memory.
        ALUControl : out STD_LOGIC_VECTOR (3 downto 0); --Op-code specific to the ALU
        ALUSrc : out STD_LOGIC; --Control bit. Set if the ALU will use an immedite
        RegDst : out STD_LOGIC;  -- Control bit. Determines which register will be used as the destination register.
        --Register File Outputs
        RD1 : out STD_LOGIC_VECTOR (31 downto 0); -- Register File output 1
        RD2 : out STD_LOGIC_VECTOR (31 downto 0); -- Register File output 2
        --Other Outputs
        RtDest : out STD_LOGIC_VECTOR (4 downto 0); -- Address of Rt from instruction (used with RegDst in a later stage).
        RdDest : out STD_LOGIC_VECTOR (4 downto 0); -- Address of Rd from instruction (used with RegDst in a    later stage).
        ImmOut : out STD_LOGIC_VECTOR (31 downto 0) --  Sign-extended immediate for I-Type instructions.
       );
end InstructionDecode;

architecture Behavioral of InstructionDecode is
    -- NOTE: everything except for Register file is asynchronous
--    signal sig_Opcode : std_logic_vector(5 downto 0);
--    signal sig_Funct : std_logic_vector(5 downto 0);
--    signal sig_Rs : std_logic_vector(4 downto 0);
    
begin

    --INSTANCE OF REGISTER FILE
    RegFileInstance: entity work.RegisterFile port map (
            --INPUTS
            clk_n => clk, 
            we => RegWriteEn,
            Addr1 => Instruction(25 downto 21), -- sig_Addr1,
            Addr2 => Instruction(20 downto 16), --sig_Addr2,
            Addr3 => RegWriteAddr,
            wd => RegWriteData,
            
            --OUTPUTS
            
            RD1 => RD1, --sig_RD1,
            RD2 => RD2 --sig_RD2
            );
            
    --INSTANCE OF Control Unit
    ControlUnitInstance: entity work.ControlUnit port map (
            --INPUTS
            Opcode => Instruction(31 downto 26),--Instruct_Opcode, 
            Funct => Instruction(5 downto 0), --Instruct_Funct,  
           
            --OUTPUTS
            RegWrite    => RegWrite,
            MemtoReg    => MemtoReg,
            MemWrite    => MemWrite,
            ALUControl  => ALUControl,
            ALUSrc      => ALUSrc,
            RegDst      => RegDst
            );
            
    -- passes through sliced parts of Input to Output        
    RtDest <= Instruction(20 downto 16); --slice_RtDest;
    RdDest <= Instruction(15 downto 11); --slice_RdDest;
    --Sign extends sliced Imm16 to imm32 and outputs
    ImmOut <= std_logic_vector(resize(signed(Instruction(15 downto 0)), Immout'length)); --if 32 no work replace with ImmOut'length
    
    
end Behavioral;
