----------------------------------------------------------------------------------
-- Company: RIT DSD 2 Lab   
-- Engineer: Atticus Russell
-- 
-- Create Date: 03/29/2022 08:30:25 PM
-- Design Name: MIPS VHDL processor 
-- Module Name: MIPS_main - Behavioral
-- Project Name: Modeling a MIPS processor in VHDL
-- Target Devices: (simulated) Basys3. Overutilized likely given the lack of hardware testing
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



--(theoretical)
-- #TODO: change anywhere that says 31 downto 0  to N-1 downto 0
-- #TODO: Import M, and then change anywhere that says 4 downto 0 to M-1 downto 0



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.globals.all; -- takes N and M from globals

entity MIPS_main is
    generic(
        N : integer := 32 -- we could also take this from globals
    );
    Port ( 
        clk_top : in STD_LOGIC;
        rst_top : in STD_LOGIC;
		
		--required outputs so Vivado doesn't optimize away the design
        ALUResult_top : out STD_LOGIC_VECTOR (31 downto 0);
        Result_top : out STD_LOGIC_VECTOR (31 downto 0));
end MIPS_main;

architecture Behavioral of MIPS_main is
    --let's make some signals I guess

    --Instruction Fetch stage signals
    signal IF_out_Instruction: std_logic_vector(N-1 downto 0);

    --Instruction Decode stage signals
    signal ID_in_Instruction  : STD_LOGIC_VECTOR (31 downto 0);
    --signal ID_in_clk          : STD_LOGIC;
    signal ID_in_RegWriteAddr : STD_LOGIC_VECTOR (4 downto 0);
    signal ID_in_RegWriteData : STD_LOGIC_VECTOR (31 downto 0);
    signal ID_in_RegWriteEn   : STD_LOGIC;
    signal ID_out_RegWrite     : STD_LOGIC;
    signal ID_out_MemtoReg     : STD_LOGIC;
    signal ID_out_MemWrite     : STD_LOGIC;
    signal ID_out_ALUControl   : STD_LOGIC_VECTOR (3 downto 0);
    signal ID_out_ALUSrc       : STD_LOGIC;
    signal ID_out_RegDst       : STD_LOGIC;
    signal ID_out_RD1          : STD_LOGIC_VECTOR (31 downto 0);
    signal ID_out_RD2          : STD_LOGIC_VECTOR (31 downto 0);
    signal ID_out_RtDest       : STD_LOGIC_VECTOR (4 downto 0);
    signal ID_out_RdDest       : STD_LOGIC_VECTOR (4 downto 0);
    signal ID_out_ImmOut       : STD_LOGIC_VECTOR (31 downto 0); 

    --Execute stage signals   
    signal Ex_in_RegWrite    : STD_LOGIC;
    signal Ex_in_MemtoReg    : STD_LOGIC;
    signal Ex_in_MemWrite    : STD_LOGIC;
    signal Ex_in_ALUControl  : STD_LOGIC_VECTOR (3 downto 0);
    signal Ex_in_ALUSrc      : STD_LOGIC;
    signal Ex_in_RegDst      : STD_LOGIC;
    signal Ex_in_RegSrcA     : STD_LOGIC_VECTOR (31 downto 0);
    signal Ex_in_RegSrcB     : STD_LOGIC_VECTOR (31 downto 0);
    signal Ex_in_RtDest      : STD_LOGIC_VECTOR (4 downto 0);
    signal Ex_in_RdDest      : STD_LOGIC_VECTOR (4 downto 0);
    signal Ex_in_SignImm     : STD_LOGIC_VECTOR (31 downto 0);
    signal Ex_out_RegWriteOut : STD_LOGIC;
    signal Ex_out_MemtoRegOut : STD_LOGIC;
    signal Ex_out_MemWriteOut : STD_LOGIC;
    signal Ex_out_ALUResult   : STD_LOGIC_VECTOR (31 downto 0);
    signal Ex_out_WriteData   : STD_LOGIC_VECTOR (31 downto 0);
    signal Ex_out_WriteReg    : STD_LOGIC_VECTOR (4 downto 0);

    --Memory stage signals
    signal Mem_in_RegWrite     : std_logic;
    signal Mem_in_MemtoReg     : std_logic;
    signal Mem_in_WriteReg     : std_logic_vector(4 downto 0);
    --signal Mem_in_clk          : std_logic;
    signal Mem_in_MemWrite     : std_logic;
    signal Mem_in_ALUResult    : std_logic_vector(N-1 downto 0);
    signal Mem_in_WriteData    : std_logic_vector(N-1 downto 0);
    signal Mem_out_RegWriteOut  : std_logic;
    signal Mem_out_MemtoRegOut  : std_logic;
    signal Mem_out_WriteRegOut  : std_logic_vector(4 downto 0);
    signal Mem_out_MemOut       : std_logic_vector(N-1 downto 0);
    signal Mem_out_ALUResultOut : std_logic_vector(N-1 downto 0);

    --WriteBack stage signals
    signal WB_in_RegWrite    : STD_LOGIC;
    signal WB_in_MemtoReg    : STD_LOGIC;
    signal WB_in_ALUResult   : STD_LOGIC_VECTOR (31 downto 0);
    signal WB_in_ReadData    : STD_LOGIC_VECTOR (31 downto 0);
    signal WB_in_WriteReg    : STD_LOGIC_VECTOR (4 downto 0);
    signal WB_out_RegWriteOut : STD_LOGIC;
    signal WB_out_WriteRegOut : STD_LOGIC_VECTOR (4 downto 0);
    signal WB_out_Result      : STD_LOGIC_VECTOR (31 downto 0);    

begin
    --enstatiate each of the subcomponents
    InstructionFetch_inst : entity work.InstructionFetch
        port map (
            --------- INPUTS ------------------
            clk         => clk_top,
			rst         => rst_top,
            ---------- OUTPUTS ----------------
            Instruction => IF_out_Instruction
        );      

    InstructionDecode_inst : entity work.InstructionDecode
        port map (
            --------- INPUTS ------------------
            Instruction  => ID_in_Instruction,
            clk          => clk_top,
            RegWriteAddr => ID_in_RegWriteAddr,
            RegWriteData => ID_in_RegWriteData,
            RegWriteEn   => ID_in_RegWriteEn,
            ---------- OUTPUTS ----------------
            RegWrite     => ID_out_RegWrite,
            ALUControl   => ID_out_ALUControl,
            ALUSrc       => ID_out_ALUSrc,
            RegDst       => ID_out_RegDst,
            MemtoReg     => ID_out_MemtoReg,
            MemWrite     => ID_out_MemWrite,
            RD1          => ID_out_RD1,
            RD2          => ID_out_RD2,
            RtDest       => ID_out_RtDest,
            RdDest       => ID_out_RdDest,
            ImmOut       => ID_out_ImmOut
        );

    Execute_inst : entity work.Execute
        port map (
            --------- INPUTS ------------------
            RegWrite    => Ex_in_RegWrite,
            MemtoReg    => Ex_in_MemtoReg,
            MemWrite    => Ex_in_MemWrite,
            ALUControl  => Ex_in_ALUControl,
            ALUSrc      => Ex_in_ALUSrc,
            RegDst      => Ex_in_RegDst,
            RegSrcA     => Ex_in_RegSrcA,
            RegSrcB     => Ex_in_RegSrcB,
            RtDest      => Ex_in_RtDest,
            RdDest      => Ex_in_RdDest,
            SignImm     => Ex_in_SignImm,
            ---------- OUTPUTS ----------------
            RegWriteOut => Ex_out_RegWriteOut,
            MemtoRegOut => Ex_out_MemtoRegOut,
            MemWriteOut => Ex_out_MemWriteOut,
            ALUResult   => Ex_out_ALUResult,
            WriteData   => Ex_out_WriteData,
            WriteReg    => Ex_out_WriteReg
        );

    memory_stage_inst : entity work.memory_stage
        generic map (
            N => N
        )
        port map (
            --------- INPUTS ------------------
            RegWrite     => Mem_in_RegWrite,
            MemtoReg     => Mem_in_MemtoReg,
            WriteReg     => Mem_in_WriteReg,
            clk          => clk_top,
            MemWrite     => Mem_in_MemWrite,
            ALUResult    => Mem_in_ALUResult,
            WriteData    => Mem_in_WriteData,
            ---------- OUTPUTS ---------------
            RegWriteOut  => Mem_out_RegWriteOut,
            MemtoRegOut  => Mem_out_MemtoRegOut,
            WriteRegOut  => Mem_out_WriteRegOut,
            MemOut       => Mem_out_MemOut,
            ALUResultOut => Mem_out_ALUResultOut
        );        

    Writeback_Stage_inst : entity work.Writeback_Stage
        port map (
            --------- INPUTS ------------------
            RegWrite    => WB_in_RegWrite,
            MemtoReg    => WB_in_MemtoReg,
            ALUResult   => WB_in_ALUResult,
            ReadData    => WB_in_ReadData,
            WriteReg    => WB_in_WriteReg,
            ---------- OUTPUTS ---------------
            RegWriteOut => WB_out_RegWriteOut,
            WriteRegOut => WB_out_WriteRegOut,
            Result      => WB_out_Result
        );


	--need registers to pass things through

	IFtoIDReg : process (clk_top) begin
		if rising_edge(clk_top) then
			ID_in_Instruction <=  IF_out_Instruction;
		end if;
    end process IFtoIDReg;  

    IDtoExReg: process (clk_top) is
    begin
        if rising_edge(clk_top) then
            Ex_in_RegWrite 		<=	ID_out_RegWrite;
            Ex_in_MemtoReg 		<=	ID_out_MemtoReg;
            Ex_in_MemWrite 		<=	ID_out_MemWrite;
            Ex_in_ALUSrc		<= 	ID_out_ALUSrc;
            Ex_in_RegDst		<=	ID_out_RegDst;
            Ex_in_ALUControl 	<=	ID_out_ALUControl;
            Ex_in_RegSrcA		<=	ID_out_RD1;
            Ex_in_RegSrcB		<=  ID_out_RD2;
            Ex_in_RtDest		<= 	ID_out_RtDest;
			Ex_in_RdDest		<=	ID_out_RdDest;
			Ex_in_SignImm       <=  ID_out_ImmOut;
		end if;
	end process IDtoExReg;

    ExtoMemReg: process (clk_top) is
    begin
        if rising_edge(clk_top) then
            Mem_in_RegWrite 	<=  Ex_out_RegWriteOut;
            Mem_in_MemtoReg 	<= 	Ex_out_MemtoRegOut;
            Mem_in_MemWrite 	<= 	Ex_out_MemWriteOut;
            Mem_in_ALUResult	<= 	Ex_out_ALUResult;
            Mem_in_WriteData	<= 	Ex_out_WriteData;
            Mem_in_WriteReg		<=  Ex_out_WriteReg;
        end if;
    end process ExtoMemReg;

    MemtoWBReg : process(clk_top) is
	begin
        if rising_edge(clk_top) then
            WB_in_RegWrite		<=  Mem_out_RegWriteOut;
            WB_in_MemtoReg		<=	Mem_out_MemtoRegOut;
            WB_in_ReadData 		<= 	Mem_out_MemOut;
            WB_in_ALUResult		<= 	Mem_out_ALUResultOut;
            WB_in_WriteReg 		<= 	Mem_out_WriteRegOut;	
		end if;
    end process MemtoWBReg;

    --Write back the 3 signals that Writeback writes back - async- not in a clocked process
    ID_in_RegWriteEn 	<=  WB_in_RegWrite;
    ID_in_RegWriteAddr 	<=  WB_in_WriteReg;
    ID_in_RegWriteData	<=	WB_out_Result;

    
    --take the top level outputs requred
    ALUResult_top 	<=	 Ex_out_ALUResult;
    Result_top		<=  WB_out_Result;
end Behavioral;
