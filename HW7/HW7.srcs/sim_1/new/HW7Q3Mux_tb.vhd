library ieee;
use ieee.std_logic_1164.all;

-----------------------------------------------------------

entity HW7Q3Mux_tb is

end entity HW7Q3Mux_tb;

-----------------------------------------------------------

architecture testbench of HW7Q3Mux_tb is

	-- Testbench DUT ports
	signal a0, a1, a2, a3 : STD_LOGIC_VECTOR (7 downto 0);
	signal shift_amt      : STD_LOGIC_VECTOR (1 downto 0);
	signal y              : STD_LOGIC_VECTOR (7 downto 0);

	-- Other constants
	type test_rec is record
		a0, a1, a2, a3 : STD_LOGIC_VECTOR (7 downto 0);
		shift_amt      : STD_LOGIC_VECTOR (1 downto 0);
		y              : STD_LOGIC_VECTOR (7 downto 0);
	end record test_rec;
	type test_array is array (3 downto 0) of test_rec;
	constant test : test_array := (
		(X"AA", X"AB", X"AC", X"AD", "00", X"AA"),
		(X"BA", X"BB", X"BC", X"BD", "01", X"BB"),
		(X"CA", X"CB", X"CC", X"CD", "10", X"CC"),
		(X"DA", X"DB", X"DC", X"DD", "11", X"DD")
		);	 		

begin

	-----------------------------------------------------------
	-- Testbench Stimulus
	-----------------------------------------------------------
	stimuli : process 
	begin
		for i in test'range loop
			a0  <= test(i).a0;
			a1  <= test(i).a1;
			a2  <= test(i).a2;
			a3  <= test(i).a3;
			shift_amt  <= test(i).shift_amt;	
			wait for 10 ns;
			assert (test(i).y = y) report "error in result. y is " & to_hstring(y) & " and should be = " & to_hstring(test(i).y) & " when the shift amount is = " & to_hstring(test(i).shift_amt); 
			wait for 10 ns;
		end loop ;
		wait;
	end process stimuli;
	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.HW7Q3Mux
		port map (
			a0        => a0,
			a1        => a1,
			a2        => a2,
			a3        => a3,
			shift_amt => shift_amt,
			y         => y
		);

end architecture testbench;