-------------------------------------------------
--  File:          RegisterFileTB.vhd
--
--  Entity:        RegisterFileTB
--  Architecture:  testbench
--  Author:        Jason Blocklove
--  Created:       09/03/19
--  Modified:      Atticus Russell 1/25/2022 - for prelab
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of a
--                 testbench for the complete
--                 register file
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegisterFileTB is
end RegisterFileTB;

architecture tb of RegisterFileTB is

--vec2str provided as resource
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

constant BIT_DEPTH : integer := 8; --original 8
constant LOG_PORT_DEPTH : integer := 3; --original 3

type test_vector is record
	we : std_logic;
	Addr1 : std_logic_vector(LOG_PORT_DEPTH-1 downto 0);
	Addr2 : std_logic_vector(LOG_PORT_DEPTH-1 downto 0);
	Addr3 : std_logic_vector(LOG_PORT_DEPTH-1 downto 0);
	wd : std_logic_vector(BIT_DEPTH-1 downto 0);
	RD1 : std_logic_vector(BIT_DEPTH-1 downto 0);
	RD2 : std_logic_vector(BIT_DEPTH-1 downto 0);
end record;

--TODO INCREASE TO 10 AND ADD ADDITIONAL CASES
constant num_tests : integer := 10;
type test_array is array (0 to num_tests-1) of test_vector;

constant test_vector_array : test_array := (
	(we => '0', Addr1 => "000", Addr2 => "000", Addr3 => "001", wd => x"10", RD1 => x"00", RD2 => x"00"),
	(we => '1', Addr1 => "000", Addr2 => "000", Addr3 => "001", wd => x"10", RD1 => x"00", RD2 => x"00"),
	(we => '1', Addr1 => "001", Addr2 => "000", Addr3 => "010", wd => x"ff", RD1 => x"10", RD2 => x"00"),
	--added by me
	(we => '1', Addr1 => "010", Addr2 => "000", Addr3 => "011", wd => x"dd", RD1 => x"ff", RD2 => x"00"),
	(we => '1', Addr1 => "000", Addr2 => "011", Addr3 => "100", wd => x"cc", RD1 => x"00", RD2 => x"dd"),
	(we => '0', Addr1 => "000", Addr2 => "000", Addr3 => "101", wd => x"bb", RD1 => x"00", RD2 => x"00"),
	(we => '1', Addr1 => "100", Addr2 => "001", Addr3 => "111", wd => x"f7", RD1 => x"cc", RD2 => x"10"),
	(we => '1', Addr1 => "111", Addr2 => "000", Addr3 => "101", wd => x"a6", RD1 => x"f7", RD2 => x"00"),
	(we => '1', Addr1 => "101", Addr2 => "111", Addr3 => "001", wd => x"b3", RD1 => x"a6", RD2 => x"f7"),
	(we => '0', Addr1 => "001", Addr2 => "000", Addr3 => "000", wd => x"00", RD1 => x"b3", RD2 => x"00")
	);

component RegisterFile is
	--GENERIC(
		--BIT_DEPTH : integer := 8;
		--LOG_PORT_DEPTH : integer := 3
	--);
	PORT (
	------------ INPUTS ---------------
		clk_n	: in std_logic;
		we		: in std_logic;   -- probably means WRITE ENABLE
		Addr1	: in std_logic_vector(LOG_PORT_DEPTH-1 downto 0); --read address 1
		Addr2	: in std_logic_vector(LOG_PORT_DEPTH-1 downto 0); --read address 2
		Addr3	: in std_logic_vector(LOG_PORT_DEPTH-1 downto 0); --write address
		wd		: in std_logic_vector(BIT_DEPTH-1 downto 0); --write data, din

	------------- OUTPUTS -------------
		RD1		: out std_logic_vector(BIT_DEPTH-1 downto 0); --Read from Addr1
		RD2		: out std_logic_vector(BIT_DEPTH-1 downto 0) --Read from Addr2
	);
end component;

signal clk_n	: std_logic;
signal we		: std_logic; -- probably means WRITE ENABLE
signal Addr1	: std_logic_vector(LOG_PORT_DEPTH-1 downto 0); --read address 1
signal Addr2	: std_logic_vector(LOG_PORT_DEPTH-1 downto 0); --read address 2
signal Addr3	: std_logic_vector(LOG_PORT_DEPTH-1 downto 0); --write address
signal wd		: std_logic_vector(BIT_DEPTH-1 downto 0); --write data, din
signal RD1		: std_logic_vector(BIT_DEPTH-1 downto 0); --Read from Addr1
signal RD2		: std_logic_vector(BIT_DEPTH-1 downto 0); --Read from Addr2

begin

UUT : RegisterFile
	--generic map (
		--BIT_DEPTH  => BIT_DEPTH,
		--LOG_PORT_DEPTH  => LOG_PORT_DEPTH
	--)
	port map (
	------------ INPUTS ---------------
		clk_n	 => clk_n,
		we		 => we,
		Addr1	 => Addr1,
		Addr2	 => Addr2,
		Addr3	 => Addr3,
		wd		 => wd,
	------------- OUTPUTS -------------
		RD1		 => RD1,
		RD2		 => RD2
	);
	
clk_proc:process
begin
	clk_n <= '1';
	wait for 50 ns;
	clk_n <= '0';
	wait for 50 ns;
end process;

stim_proc:process
begin
	for i in 0 to num_tests-1 loop
		we <= test_vector_array(i).we;
		Addr1 <= test_vector_array(i).Addr1;
		Addr2 <= test_vector_array(i).Addr2;
		Addr3 <= test_vector_array(i).Addr3;
		wd <= test_vector_array(i).wd;
		wait until rising_edge(clk_n);--for 50 ns; -- changed -- was provided as 60
--TODO(ne)??	assert
        assert RD1 = test_vector_array(i).RD1   
            report "RD1 false." & " Got " & vec2str(RD1) & " should be " & 
                vec2str(test_vector_array(i).RD1);
        assert RD2 = test_vector_array(i).RD2 
            report "RD2 false."& " Got " & vec2str(RD2) & " should be " & 
                vec2str(test_vector_array(i).RD2);
	end loop;

	-- Stop testbench once done testing
	assert false
		report "Testbench Concluded"
		severity failure;

end process;

end tb;
