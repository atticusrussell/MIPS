----------------------------------------------------------------------------------------------------
--n-bit carry-save multiplier
--Atticus Russell
--DSD 2 
--Exercise 4
--3/12/2022
----------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mult_comp is
    generic(N : integer := 32); --bit width - default 32
    Port ( 
        A_top : in std_logic_vector ((N/2)-1 downto 0);
        B_top : in std_logic_vector ((N/2)-1 downto 0);
        Product : out std_logic_vector (N-1 downto 0));
end mult_comp;

architecture Behavioral of mult_comp is
    --make component from full adder from seperate file
    component FullAdder is
        port(
            a, b, Cin : in STD_LOGIC;
            Sum, Cout : out STD_LOGIC);
    end component;

    --define types of 2d arrays to be used for the signals
    type half_n_min_1_array is array ((N/2)-1 downto 0) of std_logic_vector((N/2)-1 downto 0);
    type half_n_array is array ((N/2)-1 downto 0) of std_logic_vector((N/2) downto 0);

    --define the signals 
    signal and_arr : half_n_min_1_array;
    signal sum_arr : half_n_min_1_array;
    signal carry_arr : half_n_array; -- includes carry in
    signal results_arr : half_n_array; -- outputs and includes carry out
    signal fin_res : std_logic_vector((N/2) downto 0); -- results of mult: the product

begin
    -- generate n/2 rows and fill them with the following 
    row_gen : for row in 0 to (N/2)-1 generate
        carry_arr(row)(0) <=  '0';  --carry in for first FA in each row is 0
        -- within each row, generate n/2 columns and populate as such:
        column_gen : for col in 0 to (N/2)-1 generate
            -- as we go through row and col, AND corresponding parts of A and B inputs and place them in the and array
            ands : and_arr(row)(col) <= A_top(row) and B_top(col);
            -- for the lsb of the product bypass the FAs 
            lsb : if row = 0 and col = 0 generate
                Product(row) <= results_arr(row)(0); -- fill in product of 1st row 
            end generate;
            -- generate FAs in the second row
            sec_FAs : if col < (N/2) and row = 1 generate
                adder_inst : FullAdder
                    port map(
                        a => results_arr(row-1)(col+1),
                        b => and_arr(row)(col),
                        Cin => carry_arr(row)(col),
                        sum => sum_arr(row)(col),
                        Cout => carry_arr(row)(col + 1));
                Product(row) <= results_arr(row)(0); -- fill in product of 2nd row 
            end generate;
            -- generate FAs for the middle rows
            mid_FAs: if col < (N/2) and row > 1 and row < (N/2)-1 generate
                adder_inst : FullAdder
                    port map(
                        a => results_arr(row-1)(col+1),
                        b => and_arr(row)(col),
                        Cin => carry_arr(row)(col),
                        sum => sum_arr(row)(col),
                        Cout => carry_arr(row)(col + 1));
                Product(row) <= results_arr(row)(0); -- fill in product of rest of rows
            end generate;
            -- generate FAs in the bottom/last row
            end_FAs: if col < (N/2) and row = (N/2)-1 generate
                adder_inst : FullAdder
                    port map(
                        a => results_arr(row-1)(col+1),
                        b => and_arr(row)(col),
                        Cin => carry_arr(row)(col),
                        sum => sum_arr(row)(col),
                        Cout => carry_arr(row)(col + 1));
                -- Fill in the product based on the contents of results array
                Product(N-1 downto (N/2)-1) <= results_arr(row);
            end generate;  
        end generate;
        -- the results in the topmost row are calculated seperately from the rest. Also handles other rows
        results_arr(row) <= ('0' & and_arr(row)) when (row = 0) else (carry_arr(row)(N/2) & sum_arr(row));
    end generate;
end Behavioral;
