library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity InstructionMemory is
    Port ( addr : in STD_LOGIC_VECTOR (27 downto 0); --address in memory to read from
           d_out : out STD_LOGIC_VECTOR (31 downto 0)); --the instruction read from memory
end InstructionMemory;

architecture Behavioral of InstructionMemory is
    --there are 1024 bytes of memory - byte addressible- 1024 of 8 bit (1 byte) memory cells
    type mem_type is array (0 to 1023) of std_logic_vector (7 downto 0);
    signal inst_mem : mem_type := (
         
    x"00",x"00",x"00",x"00",
    x"11",x"11",x"11",x"11",
    x"22",x"22",x"22",x"22",
    x"1f",x"2e",x"3d",x"4c",
    x"fa",x"ce",x"fa",x"ce",
    x"ca",x"fe",x"ca",x"fe",
    x"00",x"0d",x"ec",x"af",
    x"fa",x"de",x"fa",x"de",
    x"00",x"de",x"fa",x"ce", 
    others =>x"00"
    );
begin
    
    process(addr) begin
        if ((to_integer(unsigned(addr)))> 1023) then
             d_out <= (others =>'0');
        else
            d_out <= inst_mem(to_integer(unsigned(addr))) & 
            inst_mem(to_integer(unsigned(addr)+1)) &
            inst_mem(to_integer(unsigned(addr)+2)) &
            inst_mem(to_integer(unsigned(addr)+3));
        end if;
    end process;
end Behavioral;