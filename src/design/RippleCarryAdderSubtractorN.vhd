-- RIPPLE CARRY ADDER
--this means many full adders

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity RippleCarryAdderSubtractorN is
    generic(N : integer := 32); --bit width - default 32
    Port ( 
        in1 : in std_logic_vector (n-1 downto 0); -- first addend, or minuend if subtracting
        in2 : in std_logic_vector (n-1 downto 0); -- second addend, or subtrahend if subtracting
        op: in std_logic; --0 for addition 1 for subtraction
        sum : out std_logic_vector (n-1 downto 0)); --sum if adding. difference if subtracting
end RippleCarryAdderSubtractorN;

architecture structural of RippleCarryAdderSubtractorN is
   
    --make component from full adder from seperate file
    component FullAdder is
        port(
           a, b, Cin : in STD_LOGIC;
           Sum, Cout : out STD_LOGIC);
    end component;
       
    --signals to work with
    
    --signal sig_sum : std_logic_vector(n-1 downto 0) ;
    signal sig_carry : std_logic_vector(n downto 0);
    
    --signal sig_in2 : std_logic_vector(n-1 downto 0) ;
    signal sig_in2_modif : std_logic_vector(n-1 downto 0);
        
begin
    --sig_in2_signed <= signed(in2);
    with op select
        sig_in2_modif <= ( not in2) when '1', 
                        in2 when others;
    
    sig_carry(0) <= op; -- carry in of first FA is always 0
    
    -- Use the for generate syntax to instantiate the individual full
        -- adders inside of the ripple carry adder.
    gen_n : for i in 0 to n-1 generate 
        FA_inst_i : FullAdder
            port map(
                a => in1(i),
                b => sig_in2_modif(i),
                Cin => sig_carry(i),
                sum => sum(i),
                Cout => sig_carry(i+1)
              );        
    end generate;
   

end structural;
