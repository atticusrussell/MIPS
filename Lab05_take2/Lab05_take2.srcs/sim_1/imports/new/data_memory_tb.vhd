library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity data_memory_tb is
 generic (
            WIDTH : integer := 32;
            ADDR_SPACE : integer := 10
        );
end;

architecture bench of data_memory_tb is

    --constant c_WIDTH: integer := 32;
    --constant c_ADDR_SPACE: integer := 10;
    constant clk_period: time := 40 ns;
    
    component data_memory
       
        port (
            clk, w_en : in std_logic;
            addr : in std_logic_vector(ADDR_SPACE-1 downto 0);
            d_in : in std_logic_vector(WIDTH-1 downto 0);
            d_out : out std_logic_vector(WIDTH-1 downto 0)
        );
    end component;


  
    signal clk : std_logic := '0';
    signal w_en: std_logic := '1' ;
    signal addr: std_logic_vector(ADDR_SPACE-1 downto 0);
    signal d_in: std_logic_vector(WIDTH-1 downto 0);
    signal d_out: std_logic_vector(WIDTH-1 downto 0) ;

begin
    clk <=  not clk after clk_period/2;
    

  -- Insert values for generic parameters !!
  uut: data_memory 
    -- generic map ( 
    --     WIDTH      => WIDTH,
    --     ADDR_SPACE =>  ADDR_SPACE)
        port map ( 
            clk        => clk,
            w_en       => w_en,
            addr       => addr,
            d_in       => d_in,
            d_out      => d_out );

    stimulus: process is begin
  
        -- Put initialisation code here (says doulos)
        --just kinda writing all the values and then reading all the values

        --load first test (provided from verilog)
        wait until falling_edge(clk) ;
        w_en <=  '1';
        addr <= 10x"1B";
        d_in <= 32x"AAAA5555";


        --load second provided test value
        wait until falling_edge(clk);
        addr <= 10x"1C";
        d_in <= 32x"5555AAAA";

        --load my own tests

        --load third test value
        wait until falling_edge(clk);
        addr <= 10x"1D";
        d_in <= 32x"00DEFACE";

        --load fourth test value
        wait until falling_edge(clk);
        addr <= 10x"1E";
        d_in <= 32x"CAFE1234";

        --load fifth test value
        wait until falling_edge(clk);
        addr <= 10x"FF"; --Fib
        d_in <= 32x"0112358D";


        



        
        -- Put test bench stimulus code here (says doulos) 
        --"provided" test cases (translated from Verilog):

        --first test case

        wait until falling_edge(clk);
        w_en <=  '0';
        addr <= 10x"1B";

        wait until rising_edge(clk);
        wait for clk_period/4;
        assert d_out = 32x"AAAA5555"
            report "Addr is " & to_hstring(addr) & ", data read is " & to_hstring(d_out) & " but should be AAAA5555." severity error;

        --second test case

        wait until falling_edge(clk);
        addr <= 10x"1C";

        wait until rising_edge(clk);
        wait for clk_period/4;
        assert d_out = 32x"5555AAAA"
            report "Addr is " & to_hstring(addr) & ", data read is " & to_hstring(d_out) & " but should be 5555AAAA." severity error;
        
        -- my own test cases :

        --third test case
        wait until falling_edge(clk);
        addr <= 10x"1D";

        wait until rising_edge(clk);
        wait for clk_period/4;
        assert d_out = 32x"00DEFACE"
            report "Addr is " & to_hstring(addr) & ", data read is " & to_hstring(d_out) & " but should be 00DEFACE." severity error;

        --fourth test case
        wait until falling_edge(clk);
        addr <= 10x"1E";

        wait until rising_edge(clk);
        wait for clk_period/4;
        assert d_out = 32x"CAFE1234"
            report "Addr is " & to_hstring(addr) & ", data read is " & to_hstring(d_out) & " but should be CAFE1234." severity error;

        --fifth test case
        wait until falling_edge(clk);
        addr <= 10x"FF";

        wait until rising_edge(clk);
        wait for clk_period/4;
        assert d_out = 32x"0112358D"
            report "Addr is " & to_hstring(addr) & ", data read is " & to_hstring(d_out) & " but should be 0112358D." severity error;

        
        --load sixth test value (tests overwrite)
        wait until falling_edge(clk);
        addr <= 10x"1B";
        w_en <= '1';
        d_in <= 32x"12344321";
        
    
        -- processing delay sixth test case (tests overwrite)
        wait until falling_edge(clk);
        
        
         --sixth test case (tests overwrite)
        wait until rising_edge(clk);
        wait for clk_period/4;
        assert d_out = 32x"12344321"
            report "Addr is " & to_hstring(addr) & ", data read is " & to_hstring(d_out) & " but should be (hex) 12344321. (likely OVERWRITE ISSUE)" severity error;
        w_en <= '0';
        
        wait until falling_edge(clk); -- delay to see final result
        -- end testbench
        --crude default way that provided tesbenches end. Throw code that aborts process
            --lowkey annoying - change if have time when done
        assert false
          report "Testbench Concluded."
          severity failure;
    
        wait;
    end process;


end bench;
