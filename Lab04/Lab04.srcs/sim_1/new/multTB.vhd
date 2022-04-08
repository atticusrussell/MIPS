-- used Doulos for generation
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity mult_comp_tb is
end;

architecture bench of mult_comp_tb is
    constant N: integer := 32;

    component mult_comp
        generic(N : integer := 32);
        Port ( 
            A_top : in std_logic_vector ((N/2)-1 downto 0);
            B_top : in std_logic_vector ((N/2)-1 downto 0);
            Product : out std_logic_vector (N-1 downto 0));
    end component;

    signal A_top: std_logic_vector ((N/2)-1 downto 0);
    signal B_top: std_logic_vector ((N/2)-1 downto 0);
    signal Product: std_logic_vector (N-1 downto 0);

    type mult_tests is record
        -- Inputs
        A_top : std_logic_vector((N/2)-1 downto 0);
        B_top : std_logic_vector((N/2)-1 downto 0);
        -- Output
        Product : std_logic_vector(N-1 downto 0);
    end record;

    type test_array is array (natural range <>) of mult_tests;

    constant tests : test_array := (
    (   A_top   =>  16x"1",
        B_top   =>  16x"1",
        Product =>  32x"1"),

    (   A_top   =>  16x"2",
        B_top   =>  16x"3",
        Product =>  32x"6"),

    (   A_top   =>  16x"1234",
        B_top   =>  16x"5678",
        Product =>  32x"6260060"),

    (   A_top   =>  16x"45",
        B_top   =>  16x"1A4",
        Product =>  32x"7134"),
        -- -83 x 2 = -166
        --(   A_top   =>  16x"FFAD", -- -83
        --   B_top   =>  16x"2", -- 2
        --Product =>  32x"FFFFFF5A"), 
        -- 12 x 12 = 144
    (   A_top   =>  16x"C",
        B_top   =>  16x"C",
        Product =>  32x"90")
    );

    begin

    -- Insert values for generic parameters !!
    uut: mult_comp generic map ( N       =>  32)
                        port map ( A_top   => A_top,
                                B_top   => B_top,
                                Product => Product );

    stimulus: process
    begin
    
        -- Put initialisation code here


        -- Put test bench stimulus code here
        for i in tests'range loop
            -- only need the inputs 
            A_top    <= tests(i).A_top;
            B_top    <= tests(i).B_top;

            wait for 100 ns;


            --Assert the output
            assert Product = tests(i).Product
                report "Product is " & to_hstring(signed(Product)) &
                " but should be " & to_hstring(signed(tests(i).Product))
                severity error;
            --wait for 100 ns;
        end loop;

        wait;
    end process;
end;
  