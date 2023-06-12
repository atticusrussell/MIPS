 library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity memory_stage is
    generic(
        N : integer := 32
    );
    port (
--------------inputs---------------------------------------------------------------------
-------straight up passthroughs 
        RegWrite : in std_logic; --Determines if a register is being written to in the instruction
        MemtoReg : in std_logic; -- Determines if memory is being read by the instruction
        WriteReg : in std_logic_vector(4 downto 0); --(5 bits) The address of the register being written back to
--------inputs that actually get utilized here
        clk :  in std_logic; --System Clock
        MemWrite : in std_logic; --Determines if memory is being written to
        ALUResult : in std_logic_vector(N-1 downto 0);  --Result of the ALU from the Execute Stage
        WriteData : in std_logic_vector(N-1 downto 0); --Data to be written to the memory
--------------outputs---------------------------------------------------------------------
        RegWriteOut : out std_logic; --Control bit passthrough
        MemtoRegOut : out std_logic; --Control bit passthrough
        WriteRegOut : out std_logic_vector(4 downto 0); --(5 bits) Control bits passthrough
        MemOut :      out std_logic_vector(N-1 downto 0); -- (32 bits) Data retrieved from Data Memory
        ALUResultOut :out std_logic_vector(N-1 downto 0) --(32 bits) ALU Result passthrough
    );
end memory_stage;

architecture Behavioral of memory_stage is

begin
 
    data_memory_inst: entity work.data_memory
        generic map (
            WIDTH      => N,
            ADDR_SPACE => 10
        )
        port map (
            clk   => clk,
            w_en  => MemWrite,
            addr  => ALUResult(9 downto 0), --lowest 10 bits of the ALU result
            d_in  => WriteData,
            d_out => MemOut
        );

    --passthrough many things
    RegWriteOut <= RegWrite;
    MemtoRegOut <= MemtoReg;
    WriteRegOut <= WriteReg;
    ALUResultOut <= ALUResult;
    
end architecture;
