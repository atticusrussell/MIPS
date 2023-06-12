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
    
begin -- begin architecture
    --gave everything its own process because I told Georgi I would :(
    
    -- ALUControl process
    ALU_Control_proc: process(Opcode, Funct) begin    
         case Opcode is
             when "000000" => 
             -----------R-type instructions get handled----------
                     case Funct is
                         when "100000" => -- ADD
                             sig_ALUControl <= "0100";
                         when "100100" => -- AND
                             sig_ALUControl <= "1010";
                         when "011001" => -- MULTU
                             sig_ALUControl <= "0110";
                         when "100101" => -- OR
                             sig_ALUControl <= "1000"; 
                         when "000000" => -- SLLV
                             sig_ALUControl <= "1100";
                         when "000011" => -- SRAV
                             sig_ALUControl <= "1110";
                         when "000010" => -- SRLV
                             sig_ALUControl <= "1101";
                         when "100010" => -- SUB
                             sig_ALUControl <= "0101";    
                         when "100110" => -- XOR
                             sig_ALUControl <= "1011";
                         when others => -- PROBABLY SET EVERYTHING TO ZEROS
                             sig_ALUControl <= "0000"; 
                     end case; 
              -------------------END R-TYPE STUFF-----------------
              ------------------I-TYPE STUFF GETS HANDLED---------
              when "001000" => -- ADDI
                  sig_ALUControl <= "0100";
              when "001100" => -- ANDI
                  sig_ALUControl <= "1010";
              when "001101" => -- ORI
                  sig_ALUControl <= "1000";
              when "001110" => -- XORI
                  sig_ALUControl <= "1011";
              when "101011" => -- SW
                  sig_ALUControl <= "0100";
              when "100011" => -- LW
                  sig_ALUControl <= "0100";
              when others => -- PROBABLY SET EVERYTHING TO ZEROS
                 sig_ALUControl <= "0000"; 
        end case;
        -------------------END I-TYPE HANDLING --------------------
    end process ALU_Control_proc;
    
    -- RegWrite process
        Reg_Write_proc: process(Opcode, Funct) begin    
         case Opcode is
             when "000000" => 
             -----------R-type instructions get handled----------
                     case Funct is
                         when "100000" => -- ADD
                             sig_RegWrite   <= '1';
                         when "100100" => -- AND
                             sig_RegWrite   <= '1';
                         when "011001" => -- MULTU
                             sig_RegWrite   <= '1';
                         when "100101" => -- OR
                             sig_RegWrite   <= '1';
                         when "000000" => -- SLLV
                             sig_RegWrite   <= '1';
                         when "000011" => -- SRAV
                             sig_RegWrite   <= '1';
                         when "000010" => -- SRLV
                             sig_RegWrite   <= '1';
                         when "100010" =>  -- SUB
                             sig_RegWrite   <= '1';
                         when "100110" => -- XOR
                             sig_RegWrite   <= '1';
                         when others =>  -- PROBABLY SET EVERYTHING TO ZEROS
                             sig_RegWrite   <= '0';
                     end case; 
              -------------------END R-TYPE STUFF-----------------
              ------------------I-TYPE STUFF GETS HANDLED---------
              when "001000" => -- ADDI
                  sig_RegWrite   <= '1'; 
              when "001100" => -- ANDI
                  sig_RegWrite   <= '1'; 
              when "001101" => -- ORI
                  sig_RegWrite   <= '1'; 
              when "001110" => -- XORI
                  sig_RegWrite   <= '1'; 
              when "101011" => -- SW
                  sig_RegWrite   <= '0';
              when "100011" => -- LW
                  sig_RegWrite   <= '1';
              when others => -- PROBABLY SET EVERYTHING TO ZEROS
                 sig_RegWrite   <= '0';
        end case;
        -------------------END I-TYPE HANDLING --------------------
    end process Reg_Write_proc;
    
    --MemtoReg process
    Mem_to_Reg_proc: process(Opcode, Funct) begin    
         case Opcode is
             when "000000" => 
             -----------R-type instructions get handled----------
                     case Funct is
                         when "100000" => -- ADD
                             sig_MemtoReg   <= '0';
                         when "100100" => -- AND
                             sig_MemtoReg   <= '0';
                         when "011001" => -- MULTU
                             sig_MemtoReg   <= '0';
                         when "100101" => -- OR
                             sig_MemtoReg   <= '0';
                         when "000000" => -- SLLV
                             sig_MemtoReg   <= '0';
                         when "000011" => -- SRAV
                             sig_MemtoReg   <= '0';
                         when "000010" => -- SRLV
                             sig_MemtoReg   <= '0';
                         when "100010" =>  -- SUB
                             sig_MemtoReg   <= '0';
                         when "100110" => -- XOR
                             sig_MemtoReg   <= '0';
                         when others =>  -- PROBABLY SET EVERYTHING TO ZEROS
                             sig_MemtoReg   <= '0';
                     end case; 
              -------------------END R-TYPE STUFF-----------------
              ------------------I-TYPE STUFF GETS HANDLED---------
              when "001000" => -- ADDI
                  sig_MemtoReg   <= '0'; 
              when "001100" => -- ANDI
                  sig_MemtoReg   <= '0'; 
              when "001101" => -- ORI
                  sig_MemtoReg   <= '0'; 
              when "001110" => -- XORI
                  sig_MemtoReg   <= '0'; 
              when "101011" => -- SW
                  -- We dont care about sig_MemtoReg for SW
				  sig_MemtoReg   <= '0'; --NOTE: X isnt synthesizble - used 0
              when "100011" => -- LW
                  sig_MemtoReg   <= '1';
              when others => -- PROBABLY SET EVERYTHING TO ZEROS
                 sig_MemtoReg   <= '0';
        end case;
        -------------------END I-TYPE HANDLING --------------------
    end process Mem_to_Reg_proc;
    
    --MemWrite process
    Mem_Write_proc: process(Opcode, Funct) begin    
         case Opcode is
             when "000000" => 
             -----------R-type instructions get handled----------
                     case Funct is
                         when "100000" => -- ADD
                             sig_MemWrite   <= '0';
                         when "100100" => -- AND
                             sig_MemWrite   <= '0';
                         when "011001" => -- MULTU
                             sig_MemWrite   <= '0';
                         when "100101" => -- OR
                             sig_MemWrite   <= '0';
                         when "000000" => -- SLLV
                             sig_MemWrite   <= '0';
                         when "000011" => -- SRAV
                             sig_MemWrite   <= '0';
                         when "000010" => -- SRLV
                             sig_MemWrite   <= '0';
                         when "100010" =>  -- SUB
                             sig_MemWrite   <= '0';
                         when "100110" => -- XOR
                            sig_MemWrite   <= '0';
                         when others =>  -- PROBABLY SET EVERYTHING TO ZEROS
                             sig_MemWrite   <= '0';
                     end case; 
              -------------------END R-TYPE STUFF-----------------
              ------------------I-TYPE STUFF GETS HANDLED---------
              when "001000" => -- ADDI
                  sig_MemWrite   <= '0';
              when "001100" => -- ANDI
                  sig_MemWrite   <= '0';
              when "001101" => -- ORI
                  sig_MemWrite   <= '0';
              when "001110" => -- XORI
                  sig_MemWrite   <= '0';
              when "101011" => -- SW
                  sig_MemWrite   <= '1';
              when "100011" => -- LW
                  sig_MemWrite   <= '0';
              when others => -- PROBABLY SET EVERYTHING TO ZEROS
                 sig_MemWrite   <= '0';
        end case;
        -------------------END I-TYPE HANDLING --------------------
    end process Mem_Write_proc;
    
    --ALUSrc process
    ALU_Src_proc: process(Opcode, Funct) begin    
         case Opcode is
             when "000000" => 
             -----------R-type instructions get handled----------
                     case Funct is
                         when "100000" => -- ADD
                             sig_ALUSrc     <= '0';
                         when "100100" => -- AND
                             sig_ALUSrc     <= '0';
                         when "011001" => -- MULTU
                             sig_ALUSrc     <= '0';
                         when "100101" => -- OR
                             sig_ALUSrc     <= '0';
                         when "000000" => -- SLLV
                             sig_ALUSrc     <= '0';
                         when "000011" => -- SRAV
                             sig_ALUSrc     <= '0';
                         when "000010" => -- SRLV
                             sig_ALUSrc     <= '0';
                         when "100010" =>  -- SUB
                             sig_ALUSrc     <= '0';
                         when "100110" => -- XOR
                             sig_ALUSrc     <= '0';
                         when others =>  -- PROBABLY SET EVERYTHING TO ZEROS
                             sig_ALUSrc     <= '0';
                     end case; 
              -------------------END R-TYPE STUFF-----------------
              ------------------I-TYPE STUFF GETS HANDLED---------
              when "001000" => -- ADDI
                  sig_ALUSrc     <= '1';
              when "001100" => -- ANDI
                  sig_ALUSrc     <= '1';
              when "001101" => -- ORI
                  sig_ALUSrc     <= '1';
              when "001110" => -- XORI
                  sig_ALUSrc     <= '1'; -- 1 means we want an immediate
              when "101011" => -- SW
                  sig_ALUSrc     <= '1';
              when "100011" => -- LW
                  sig_ALUSrc     <= '1';
              when others => -- PROBABLY SET EVERYTHING TO ZEROS
                 sig_ALUSrc     <= '0';
        end case;
        -------------------END I-TYPE HANDLING --------------------
    end process ALU_Src_proc;
    
    Reg_Dst_proc: process(Opcode, Funct) begin    
         case Opcode is
             when "000000" => 
             -----------R-type instructions get handled----------
                     case Funct is
                         when "100000" => -- ADD
                             sig_RegDst     <= '1';
                         when "100100" => -- AND
                             sig_RegDst     <= '1';
                         when "011001" => -- MULTU
                             sig_RegDst     <= '1';
                         when "100101" => -- OR
                             sig_RegDst     <= '1';
                         when "000000" => -- SLLV
                             sig_RegDst     <= '1';
                         when "000011" => -- SRAV
                             sig_RegDst     <= '1';
                         when "000010" => -- SRLV
                             sig_RegDst     <= '1';
                         when "100010" =>  -- SUB
                             sig_RegDst     <= '1';
                         when "100110" => -- XOR
                             sig_RegDst     <= '1';
                         when others =>  -- PROBABLY SET EVERYTHING TO ZEROS
                             sig_RegDst     <= '0';
                     end case; 
              -------------------END R-TYPE STUFF-----------------
              ------------------I-TYPE STUFF GETS HANDLED---------
              when "001000" => -- ADDI
                  sig_RegDst     <= '0'; -- 0 selects Rt as dest reg
              when "001100" => -- ANDI
                  sig_RegDst     <= '0'; -- 0 selects Rt as dest reg
              when "001101" => -- ORI
                  sig_RegDst     <= '0'; -- 0 selects Rt as dest reg
              when "001110" => -- XORI
                  sig_RegDst     <= '0'; -- 0 selects Rt as dest reg
			  when "101011" => -- SW        We dont care about sig_RegDst for SW
				 sig_RegDst      <= '0'; --NOTE: X isn't synthesizable so used 0
              when "100011" => -- LW
                  sig_RegDst     <= '0';
              when others => -- PROBABLY SET EVERYTHING TO ZEROS
                 sig_RegDst     <= '0';
        end case;
        -------------------END I-TYPE HANDLING --------------------
    end process Reg_Dst_proc;
    
--assign our outputs to their respective signals
    RegWrite    <= sig_RegWrite;
    MemtoReg    <= sig_MemtoReg;
    MemWrite    <= sig_MemWrite;
    ALUControl  <= sig_ALUControl;
    ALUSrc      <= sig_ALUSrc;
    RegDst      <= sig_RegDst;
            
end Behavioral;
