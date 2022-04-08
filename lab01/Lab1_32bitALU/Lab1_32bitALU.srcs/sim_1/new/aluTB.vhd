----------------------------------------------------------------------------------
-- Company: Rochester Institute of Technology (RIT)
-- Engineer: Atticus Russell ajr8934@rit.edu
-- 
-- Create Date: 01/17/2022 10:53:10 PM
-- Design Name: aluTB
-- Project Name: Lab1
-- 
-- Description: testbench to test the 32 bit alu developed in lab 1
-- utilizes code from provided "andTestbench.vhd".
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.globals.all;

entity aluTB is
end aluTB;

architecture Behavioral of aluTB is
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
    
--Declare the ALU component
    Component alu32 is
        PORT (
            A : IN std_logic_vector (N -1 downto 0) ;
            B : IN std_logic_vector (N -1 downto 0) ;
            OP : IN std_logic_vector(3 downto 0);
            Y : OUT std_logic_vector (N -1 downto 0)
        ) ;
    end Component ;
    
    type test_vector is record
        OP : std_logic_vector(3 downto 0);
        A : std_logic_vector(N-1 downto 0);
        B : std_logic_vector(N-1 downto 0);
        
        Y : std_logic_vector(N-1 downto 0);
    end record; 
    
    type test_array is array( natural range <> ) of test_vector;
    
    --type test_array_inception is array( natural range <> ) of test_array;
    
    constant gener_OR: test_array := (
    (OP => "1000", A => 32ux"0", B => 32ux"0", Y => 32ux"0" ),
    (OP => "1000", A => 32ux"1", B => 32ux"0", Y => 32ux"1" ),
    (OP => "1000", A => 32ux"0", B => 32ux"1", Y => 32ux"1" ),
    (OP => "1000", A => 32ux"1", B => 32ux"1", Y => 32ux"1" )
    );
    
    constant gener_AND: test_array := (
    (OP => "1010", A => 32ux"0", B => 32ux"0", Y => 32ux"0" ),
    (OP => "1010", A => 32ux"1", B => 32ux"0", Y => 32ux"0" ),
    (OP => "1010", A => 32ux"0", B => 32ux"1", Y => 32ux"0" ),
    (OP => "1010", A => 32ux"1", B => 32ux"1", Y => 32ux"1" )
    );
    
    constant gener_XOR: test_array := (
    (OP => "1011", A => 32ux"0", B => 32ux"0", Y => 32ux"0" ),
    (OP => "1011", A => 32ux"1", B => 32ux"0", Y => 32ux"1" ),
    (OP => "1011", A => 32ux"0", B => 32ux"1", Y => 32ux"1" ),
    (OP => "1011", A => 32ux"1", B => 32ux"1", Y => 32ux"0" )
    );
    
    constant gener_SLL: test_array := (
    (OP => "1100", A => 32ux"1", B => 32ux"1", Y => 32ux"2" ),
    (OP => "1100", A => 32ux"0", B => 32ux"0", Y => 32ux"0" ),
    (OP => "1100", A => 32ux"0", B => 32ux"1", Y => 32ux"0" ),
    (OP => "1100", A => 32ux"2", B => 32ux"1", Y => 32ux"4" )
    );
    
    constant gener_SRL: test_array := (
    (OP => "1101", A => 32ux"2", B => 32ux"1", Y => 32ux"1" ),
    (OP => "1101", A => 32ux"F", B => 32ux"1", Y => 32ux"7" ),
    (OP => "1101", A => 32ux"9", B => 32ux"2", Y => 32ux"2" ),
    (OP => "1101", A => 32ux"0", B => 32ux"1", Y => 32ux"0" )
    );
    
     constant gener_SRA: test_array := (
    (OP => "1110", A => 32ux"0", B => 32ux"0", Y => 32ux"0" ),
    (OP => "1110", A => 32ux"FFFFFFFF", B => 32ux"1", Y => 32ux"FFFFFFFF" ),
    (OP => "1110", A => 32ux"FFFF0000", B => 32ux"4", Y => 32ux"FFFFF000" ),
    (OP => "1110", A => 32ux"F0000000", B => 32ux"4", Y => 32ux"FF000000" )
    );
    
     constant edge_cases: test_array := (
    (OP => "1101", A => 32ux"6", B => 32ux"2", Y => 32ux"1" ),
    (OP => "1110", A => 32ux"6", B => 32ux"1", Y => 32ux"3" ),
    (OP => "1110", A => 32ux"6", B => 32ux"2", Y => 32ux"1" ),
    (OP => "1110", A => 32ux"F0000000", B => 32ux"1", Y => 32ux"F8000000" ),
    (OP => "1000", A => 32ux"0", B => 32ux"0", Y => 32ux"0" ),
    (OP => "1000", A => 32ux"0", B => 32ux"F", Y => 32ux"F" ),
    (OP => "1000", A => 32ux"F", B => 32ux"F", Y => 32ux"F" ),
    (OP => "1000", A => 32ux"5", B => 32ux"A", Y => 32ux"F" ),
    (OP => "1000", A => 32ux"A", B => 32ux"5", Y => 32ux"F" ),
    (OP => "1011", A => 32ux"0", B => 32ux"0", Y => 32ux"0" ),
    (OP => "1011", A => 32ux"0", B => 32ux"F", Y => 32ux"F" ),
    (OP => "1011", A => 32ux"F", B => 32ux"0", Y => 32ux"F" ),
    (OP => "1011", A => 32ux"F", B => 32ux"F", Y => 32ux"0" ),
    (OP => "1011", A => 32ux"5", B => 32ux"A", Y => 32ux"F" ),
    (OP => "1011", A => 32ux"A", B => 32ux"5", Y => 32ux"F" ),
    (OP => "1010", A => 32ux"0", B => 32ux"0", Y => 32ux"0" ),
    (OP => "1010", A => 32ux"0", B => 32ux"F", Y => 32ux"0" ),
    (OP => "1010", A => 32ux"F", B => 32ux"0", Y => 32ux"0" ),
    (OP => "1010", A => 32ux"F", B => 32ux"F", Y => 32ux"F" )
    );
   
   
    constant delay   : time := 20 ns ;
    
    signal A , B, Y : std_logic_vector (N -1 downto 0) := ( others => '0') ;
    signal OP        : std_logic_vector(3 downto 0) ;
    
    signal A_or , B_or , Y_or : std_logic_vector (N -1 downto 0) := ( others => '0') ;
    signal OP_or        : std_logic_vector(3 downto 0) ;
    
    signal A_and , B_and , Y_and : std_logic_vector (N -1 downto 0) := ( others => '0') ;
    signal OP_and        : std_logic_vector(3 downto 0) ;
    
    signal A_xor , B_xor , Y_xor : std_logic_vector (N -1 downto 0) := ( others => '0') ;
    signal OP_xor        : std_logic_vector(3 downto 0) ;
    
    signal A_sll , B_sll , Y_sll : std_logic_vector (N -1 downto 0) := ( others => '0') ;
    signal OP_sll        : std_logic_vector(3 downto 0) ;
    
    signal A_srl , B_srl , Y_srl : std_logic_vector (N -1 downto 0) := ( others => '0') ;
    signal OP_srl        : std_logic_vector(3 downto 0) ;
    
    signal A_sra , B_sra , Y_sra : std_logic_vector (N -1 downto 0) := ( others => '0') ;
    signal OP_sra        : std_logic_vector(3 downto 0) ;
    
    
begin
    -- Instantiate an instance of the ALU for edge cases
    alu_inst_EDGE : alu32 PORT MAP (
        A => A ,
        B => B ,
        OP => OP,
        Y => Y
    ) ;
    
    stimulusEDGE : process
    begin
        for i in edge_cases'range loop
            A   <= edge_cases(i).A; --Pass input
            B   <= edge_cases(i).B; --Pass input
            OP  <= edge_cases(i).OP; --Pass input
            
            wait for delay; -- Wait for delay time (20 ns)

            assert Y = edge_cases(i).Y 
                report "Error in Calculation. Got " & vec2str(Y) & " Should be " & vec2str(edge_cases(i).Y)
                    & " Input A was " & vec2str(A) & " Input B was " 
                    & vec2str(B) & " OPCODE was " & vec2str(OP) & " instruct. index was " & integer'image(i)
                severity error; 
        end loop;
    --report "Edge case simulation finished. " severity note;
    end process;
    
    --new UUT
    -- Instantiate an instance of the ALU for OR
    alu_inst_OR : alu32 PORT MAP (
        A => A_or ,
        B => B_or ,
        OP => OP_or ,
        Y => Y_or
    ) ;
    
    stimulusOR : process
    begin
        for i in gener_OR'range loop
            A_or   <= gener_OR(i).A; --Pass input
            B_or   <= gener_OR(i).B; --Pass input
            OP_or  <= gener_OR(i).OP; --Pass input
            
            wait for delay; -- Wait for delay time (20 ns)

            assert Y_or = gener_OR(i).Y 
                report "Error in Calculation. Got " & vec2str(Y_or) & " Should be " & vec2str(gener_OR(i).Y)
                    & " Input A was " & vec2str(A_or) & " Input B was " 
                    & vec2str(B_or)
                severity error; 
        end loop;
    --report "Generic OR simulation finished. " severity note;
    end process;
    
    --new UUT
    -- Instantiate an instance of the ALU for AND
    alu_inst_AND : alu32 PORT MAP (
        A => A_and ,
        B => B_and ,
        OP => OP_and ,
        Y => Y_and
    ) ;
    
    stimulusAND : process
    begin
        for i in gener_AND'range loop
            A_and   <= gener_AND(i).A; --Pass input
            B_and   <= gener_AND(i).B; --Pass input
            OP_and  <= gener_AND(i).OP; --Pass input
            
            wait for delay; -- Wait for delay time (20 ns)
            assert Y_and = gener_AND(i).Y 
                report "Error in Calculation. Got " & vec2str(Y_and) & " Should be " & vec2str(gener_AND(i).Y)
                    & " Input A was " & vec2str(A_and) & " Input B was " 
                    & vec2str(B_and)
                severity error; 
        end loop;
    --report "Generic AND simulation finished. " severity note;
    end process;
    
    --new UUT
    -- Instantiate an instance of the ALU for XOR
    alu_inst_XOR : alu32 PORT MAP (
        A => A_XOR ,
        B => B_XOR ,
        OP => OP_XOR ,
        Y => Y_XOR
    ) ;
    
    stimulusXOR : process
    begin
        for i in gener_XOR'range loop
            A_XOR   <= gener_XOR(i).A; --Pass input
            B_XOR   <= gener_XOR(i).B; --Pass input
            OP_XOR  <= gener_XOR(i).OP; --Pass input
            
            wait for delay; -- Wait for delay time (20 ns)

            assert Y_XOR = gener_XOR(i).Y 
                report "Error in Calculation. Got " & vec2str(Y_XOR) & " Should be " & vec2str(gener_XOR(i).Y)
                    & " Input A was " & vec2str(A_XOR) & " Input B was " 
                    & vec2str(B_XOR)
                severity error; 
        end loop;
    --report "Generic XOR simulation finished. " severity note;
    end process;
    
    --new UUT
    -- Instantiate an instance of the ALU for SLL
    alu_inst_SLL : alu32 PORT MAP (
        A => A_SLL ,
        B => B_SLL ,
        OP => OP_SLL ,
        Y => Y_SLL
    ) ;
    
    stimulusSLL : process
    begin
        for i in gener_SLL'range loop
            A_SLL   <= gener_SLL(i).A; --Pass input
            B_SLL   <= gener_SLL(i).B; --Pass input
            OP_SLL  <= gener_SLL(i).OP; --Pass input
            
            wait for delay; -- Wait for delay time (20 ns)

            assert Y_SLL = gener_SLL(i).Y 
                report "Error in Calculation. Got " & vec2str(Y_SLL) & " Should be " & vec2str(gener_SLL(i).Y)
                    & " Input A was " & vec2str(A_SLL) & " Input B was " 
                    & vec2str(B_SLL)
                severity error; 
        end loop;
    --report "Generic Shift Left Logical simulation finished. " severity note;
    end process;
    
    --new UUT
    -- Instantiate an instance of the ALU for SRL
    alu_inst_SRL : alu32 PORT MAP (
        A => A_SRL ,
        B => B_SRL ,
        OP => OP_SRL ,
        Y => Y_SRL
    ) ;
    
    stimulusSRL : process
    begin
        for i in gener_SRL'range loop
            A_SRL   <= gener_SRL(i).A; --Pass input
            B_SRL   <= gener_SRL(i).B; --Pass input
            OP_SRL  <= gener_SRL(i).OP; --Pass input
            
            wait for delay; -- Wait for delay time (20 ns)

            assert Y_SRL = gener_SRL(i).Y 
                report "Error in Calculation. Got " & vec2str(Y_SRL) & " Should be " & vec2str(gener_SRL(i).Y)
                    & " Input A was " & vec2str(A_SRL) & " Input B was " 
                    & vec2str(B_SRL)
                severity error; 
        end loop;
    --report "Generic Shift Right Logical simulation finished. " severity note;
    end process;
    
    --new UUT
    -- Instantiate an instance of the ALU for SRA
    alu_inst_SRA : alu32 PORT MAP (
        A => A_SRA ,
        B => B_SRA ,
        OP => OP_SRA ,
        Y => Y_SRA
    ) ;
    
    stimulusSRA : process
    begin
        for i in gener_SRA'range loop
            A_SRA   <= gener_SRA(i).A; --Pass input
            B_SRA   <= gener_SRA(i).B; --Pass input
            OP_SRA  <= gener_SRA(i).OP; --Pass input
            
            wait for delay; -- Wait for delay time (20 ns)

            assert Y_SRA = gener_SRA(i).Y 
                report "Error in Calculation. Got " & vec2str(Y_SRA) & " Should be " & vec2str(gener_SRA(i).Y)
                    & " Input A was " & vec2str(A_SRA) & " Input B was " 
                    & vec2str(B_SRA)
                severity error; 
        end loop;
    --report "Generic Shift Right Arithmetical simulation finished. " severity note;
    end process;

end behavioral;