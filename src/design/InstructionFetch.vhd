library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity InstructionFetch is
    Port ( clk : in STD_LOGIC; --system clock
           rst : in STD_LOGIC; --active high reset. Asynchronous
           Instruction : out STD_LOGIC_VECTOR (31 downto 0)); --instruction which was fetched from memory
end InstructionFetch;


architecture Behavioral of InstructionFetch is
    signal pc : std_logic_vector(27 downto 0) := (others => '0');
        
    begin
    mem_instance: entity work.InstructionMemory port map (addr => pc,
        d_out => Instruction);
    
    process (clk) is begin
            if (rst = '1') then
                pc <= (others => '0');
            elsif (rising_edge(clk)) then
                pc <= std_logic_vector(unsigned(pc)+4);
            end if;
    end process;
end Behavioral;
