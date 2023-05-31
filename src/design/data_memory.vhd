library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity data_memory is
    generic (
        WIDTH : integer := 32; --The width of each section of memory. Default to 32
        ADDR_SPACE : integer := 10 -- Number of bits available for addressing. Default to 10
    );
    port (
        clk, w_en : in std_logic; -- clock and write enable
        addr : in std_logic_vector(ADDR_SPACE-1 downto 0); --address to operate on from ALU
        d_in : in std_logic_vector(WIDTH-1 downto 0); -- data to be written to memory
        --xswitches : in std_logic_vector(15 downto 0);
        --outputs --
        d_out : out std_logic_vector(WIDTH-1 downto 0) -- read data to writeback Mux
            --seven_seg: out std_logic_vector(15 downto 0)
    );
end entity;

architecture Behavioral of data_memory is
    -- make 1024 words of memory
type mem_type is array (((2**ADDR_SPACE) -1) downto 0) of std_logic_vector (WIDTH-1 downto 0);
signal data_mem : mem_type ;-- don't initialize with  values like we did with instr mem

begin

    process (clk) begin
        if clk'event and clk = '1' then
            if w_en = '1' then
                data_mem(to_integer(unsigned(addr))) <= d_in;
            --else
            end if;
        --else
        end if;
    end process;
    d_out <=  data_mem(to_integer(unsigned(addr)));
end Behavioral;
