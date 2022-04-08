-------------------------------------------------
--  File:          InstructionFetchTB.vhd
--
--  Entity:        InstructionFetchTB
--  Architecture:  BEHAVIORAL
--  Author:        Jason Blocklove
--  Created:       07/26/19
--  Modified:
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of a
--                 Testbench for Instruction Fetch
--                 Stage
-------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InstructionFetchTB is
end InstructionFetchTB;


architecture Behavioral of InstructionFetchTB is

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

type test_vector is record
	rst : std_logic;
	Instruction	 : std_logic_vector(31 downto 0);
end record;

--TODO: Add additional 5 cases to test table
type test_array is array (natural range <>) of test_vector;
constant test_vector_array : test_array := (
	(rst => '1', Instruction => x"00000000"), -- address 0, reset value
	(rst => '0', Instruction => x"11111111"), -- address 1
	(rst => '0', Instruction => x"22222222"), -- address 2
	(rst => '0', Instruction => x"1f2e3d4c"),  -- address 3
 --TODONE: 
    (rst => '0', Instruction => x"faceface"),  -- address 4
    (rst => '0', Instruction => x"cafecafe"),  -- address 5
    (rst => '0', Instruction => x"000decaf"),  -- address 6
    (rst => '0', Instruction => x"fadefade"),  -- address 7
    (rst => '0', Instruction => x"00deface")  -- address 8
);

component InstructionFetch
  port (
    clk : in std_logic;
    rst : in std_logic;
    Instruction : out std_logic_vector(31 DOWNTO 0)
  );
end component;

	signal rst : std_logic;
	signal clk : std_logic;
	signal instruction : std_logic_vector(31 downto 0);


begin

uut : InstructionFetch
  port map (
    clk => clk,
    rst => rst,
    Instruction => Instruction
  );

clk_proc:process --c process that changes clk with T=100ns
begin
	clk <= '0';
	wait for 50 ns;
	clk <= '1';
	wait for 50 ns;
end process;

stim_proc:process
begin
  --TODO:	time for everything to reset -- not sure if this is already handled??
  rst <= '1';
  wait until clk='1';
  wait until clk='0';
  rst <= '0'; --not sure if this is correct

	for i in test_vector_array'range loop
		rst <= test_vector_array(i).rst;
		wait until clk='0';
		
		assert Instruction = test_vector_array(i).Instruction
            report "Instruction is " & to_hstring(instruction) &
            " but should be " & to_hstring(test_vector_array(i).Instruction)
            severity error;
	end loop;
	wait until clk='0';
--    assert false
--        report "Testbench Concluded"
--        severity failure;


end process;

end Behavioral;
