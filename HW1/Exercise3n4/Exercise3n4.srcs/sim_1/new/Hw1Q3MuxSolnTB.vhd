----------------------------------------------------------------------------------
-- Engineer: Atticus Russell
-- 
-- Create Date: 01/21/2022 4:50 PM
-- Design Name: 
-- Module Name: HW1Q3MuxSolnTB
-- Project Name: DSD 2 HW 1
-- Target Devices: 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Hw1Q3MuxSolnTB is
end Hw1Q3MuxSolnTB;

architecture tb of Hw1Q3MuxSolnTB is
    signal x    :   std_logic_vector(7 downto 0);
    signal sel  :   std_logic_vector(2 downto 0);
    signal z    :   std_logic;
    
    type test_rec is record
        x    :   std_logic_vector(7 downto 0);   
        sel  :   std_logic_vector(2 downto 0);
        z    :   std_logic;
    end record test_rec;
    type test_rec_array is array (integer range<>) of test_rec;
    constant test   :   test_rec_array  := (
            (x"02","000",'0'),
            (x"74","010",'1'),
            (x"FF","110",'0'),
            (x"55","001",'1'));
    function vec2str(vec: std_logic_vector) return string is
        variable stmp: string(vec'high+1 downto 1);
        variable counter : integer := 1;
    begin
        for i in vec'reverse_range loop
            stmp(counter) := std_logic'image(vec(i))(2); -- image returns '1' (with quotes)
            counter := counter + 1;
        end loop;
        return stmp;
    end vec2str;
begin
    dut :   entity work.Hw1Q3MuxSoln
        port map(x => x,
        sel => sel,
        z   => z);
        
    stimuli :   process
    begin
        for i in test 'range loop
            x <= test(i).x;
            sel <= test(i).sel;
            wait for 100 ns;
            assert (test(i).z = z) report "error in result. The "&
                vec2str(test(i).sel) & 
                "bit of " & 
                vec2str(test(i).x) & 
                " should be = " & 
                std_logic'image(test(i).z) & 
                ", not " &
                std_logic'image(z);
        end loop;
        wait;
    end process;
end tb;
