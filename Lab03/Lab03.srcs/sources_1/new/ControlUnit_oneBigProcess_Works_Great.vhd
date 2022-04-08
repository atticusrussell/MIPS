-------------------------------------------------
--  File:          ControlUnit.vhd
--
--  Entity:        ControlUnit 
--  Author:        Atticus Russell
--  Created:       2/21/2022
--  Assignment:  RIT CMPE 260 DSD 2 Exercise 3
------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ControlUnit is
    Port ( 
        -- INPUTS
        Opcode : in STD_LOGIC_VECTOR (5 downto 0); --The opcode of the instruction
        Funct : in STD_LOGIC_VECTOR (5 downto 0); --The function of the instruction
        -- OUTPUTS 
        RegWrite : out STD_LOGIC; -- Control bit. Set if the instruction requires register writing.
        MemtoReg : out STD_LOGIC; -- Control bit. Set if the instruction requires reading from Memory.
        MemWrite : out STD_LOGIC; -- Control bit. Set if the instruction requires writing to Memory.
        ALUControl : out STD_LOGIC_VECTOR (3 downto 0); --Op-code specific to the ALU
        ALUSrc : out STD_LOGIC; --Control bit. Set if the ALU will use an immedite
        RegDst : out STD_LOGIC  -- Control bit. Determines which register will be used as the destination register.
        ); 
end ControlUnit;

architecture Behavioral of ControlUnit is
    --these are our inputs and outputs mapped to signals for best practice sake/vhdl quirkyness??
    
    signal sig_RegWrite: std_logic;
    signal sig_MemtoReg: std_logic;
    signal sig_MemWrite: std_logic;
    signal sig_ALUControl: std_logic_vector(3 downto 0);
    signal sig_ALUSrc: std_logic;
    signal sig_RegDst: std_logic;
    
begin
    
    
    case_enable: process(Opcode, Funct) begin    
         case Opcode is
             when "000000" => 
             -----------R-type instructions get handled----------
                     case Funct is
                         when "100000" =>
                             -- ADD
                             sig_ALUControl <= "0100";
                             
                             sig_RegWrite   <= '1';
                             sig_MemtoReg   <= '0';
                             sig_MemWrite   <= '0';
                             sig_ALUSrc     <= '0';
                             sig_RegDst     <= '1';
                             
                         when "100100" =>
                             -- AND
                             sig_ALUControl <= "1010";
                             
                             sig_RegWrite   <= '1';
                             sig_MemtoReg   <= '0';
                             sig_MemWrite   <= '0';
                             sig_ALUSrc     <= '0';
                             sig_RegDst     <= '1';
                             
                         when "011001" =>
                             -- MULTU
                             sig_ALUControl <= "0110";
                             
                             sig_RegWrite   <= '1';
                             sig_MemtoReg   <= '0';
                             sig_MemWrite   <= '0';
                             sig_ALUSrc     <= '0';
                             sig_RegDst     <= '1';
                             
                         when "100101" =>
                             -- OR
                             sig_ALUControl <= "1000";  
                             
                             sig_RegWrite   <= '1';
                             sig_MemtoReg   <= '0';
                             sig_MemWrite   <= '0';
                             sig_ALUSrc     <= '0';
                             sig_RegDst     <= '1';
                             
                         when "000000" =>
                             -- SLL
                             sig_ALUControl <= "1100";
                             
                             sig_RegWrite   <= '1';
                             sig_MemtoReg   <= '0';
                             sig_MemWrite   <= '0';
                             sig_ALUSrc     <= '0';
                             sig_RegDst     <= '1';
                             
                         when "000011" =>
                             -- SRA
                             sig_ALUControl <= "1110";
                             
                             sig_RegWrite   <= '1';
                             sig_MemtoReg   <= '0';
                             sig_MemWrite   <= '0';
                             sig_ALUSrc     <= '0';
                             sig_RegDst     <= '1';
                             
                         when "000010" =>
                             -- SRL
                             sig_ALUControl <= "1101";
                             
                             sig_RegWrite   <= '1';
                             sig_MemtoReg   <= '0';
                             sig_MemWrite   <= '0';
                             sig_ALUSrc     <= '0';
                             sig_RegDst     <= '1';
                             
                         when "100010" =>
                             -- SUB
                             sig_ALUControl <= "0101";
                             
                             sig_RegWrite   <= '1';
                             sig_MemtoReg   <= '0';
                             sig_MemWrite   <= '0';
                             sig_ALUSrc     <= '0';
                             sig_RegDst     <= '1';
                             
                         when "100110" =>
                             -- XOR
                             sig_ALUControl <= "1011";
                             
                             sig_RegWrite   <= '1';
                             sig_MemtoReg   <= '0';
                             sig_MemWrite   <= '0';
                             sig_ALUSrc     <= '0';
                             sig_RegDst     <= '1';
                             
                         when others =>
                             -- PROBABLY SET EVERYTHING TO ZEROS
                             sig_ALUControl <= "0000"; 
                             
                             sig_RegWrite   <= '0';
                             sig_MemtoReg   <= '0';
                             sig_MemWrite   <= '0';
                             sig_ALUSrc     <= '0';
                             sig_RegDst     <= '0';
                        
                     end case; 
              -------------------END R-TYPE STUFF-----------------
              
              ------------------I-TYPE STUFF GETS HANDLED---------
              when "001000" =>
                  -- ADDI
                  sig_ALUControl <= "0100";
                  
                  sig_RegWrite   <= '1'; --good
                  sig_MemtoReg   <= '0'; --good
                  sig_MemWrite   <= '0'; --good
                  sig_ALUSrc     <= '1'; -- good
                  sig_RegDst     <= '0'; -- 0 selects Rt as dest reg
                  
              when "001100" =>
                  -- ANDI
                  sig_ALUControl <= "1010";
                  
                  sig_RegWrite   <= '1'; --good
                  sig_MemtoReg   <= '0'; --good
                  sig_MemWrite   <= '0'; --good
                  sig_ALUSrc     <= '1'; -- good
                  sig_RegDst     <= '0'; -- 0 selects Rt as dest reg
                  
              when "001101" =>
                  -- ORI
                  sig_ALUControl <= "1000";
                  sig_RegWrite   <= '1'; --good
                  sig_MemtoReg   <= '0'; --good
                  sig_MemWrite   <= '0'; --good
                  sig_ALUSrc     <= '1'; -- good
                  sig_RegDst     <= '0'; -- 0 selects Rt as dest reg
                  
              when "001110" =>
                  -- XORI
                  sig_ALUControl <= "1011";
                  sig_RegWrite   <= '1'; --good
                  sig_MemtoReg   <= '0'; --good
                  sig_MemWrite   <= '0'; --good
                  sig_ALUSrc     <= '1'; -- 1 means we want an immediate
                  sig_RegDst     <= '0'; -- 0 selects Rt as dest reg
                  
              when "101011" =>
                  -- SW
                  sig_ALUControl <= "0100";
                  sig_RegWrite   <= '0';
                  -- We dont care about sig_MemtoReg for SW
                  sig_MemtoReg   <= 'X';
                  
                  sig_MemWrite   <= '1';
                  sig_ALUSrc     <= '1';
                  -- We dont care about sig_RegDst for SW
                  sig_RegDst   <= 'X';
                  
                  
              when "100011" =>
                  -- LW
                  sig_ALUControl <= "0100";
                  sig_RegWrite   <= '1';
                  sig_MemtoReg   <= '1';
                  sig_MemWrite   <= '0';
                  sig_ALUSrc     <= '1';
                  sig_RegDst     <= '0';
                  
                  
              when others =>
                 -- PROBABLY SET EVERYTHING TO ZEROS
                 sig_ALUControl <= "0000"; 
                 
                 sig_RegWrite   <= '0';
                 sig_MemtoReg   <= '0';
                 sig_MemWrite   <= '0';
                 sig_ALUSrc     <= '0';
                 sig_RegDst     <= '0';
     
                 
        end case;
        -------------------END I-TYPE HANDLING --------------------
    end process case_enable;
    --TODO give everything its own process because I told Georgi it would :(
    
    
    
    
--assign our outputs to their respective signals
    RegWrite    <= sig_RegWrite;
    MemtoReg    <= sig_MemtoReg;
    MemWrite    <= sig_MemWrite;
    ALUControl  <= sig_ALUControl;
    ALUSrc      <= sig_ALUSrc;
    RegDst      <= sig_RegDst;
            
end Behavioral;
