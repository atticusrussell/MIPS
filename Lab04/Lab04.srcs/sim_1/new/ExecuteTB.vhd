----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/02/2022 05:12:11 PM
-- Design Name: 
-- Module Name: ExecuteTB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Execute_tb is
end;

architecture bench of Execute_tb is

  component Execute
      Port (
             RegWrite : in STD_LOGIC;
             MemtoReg : in STD_LOGIC;
             MemWrite : in STD_LOGIC;
             ALUControl : in STD_LOGIC_VECTOR (3 downto 0);
             ALUSrc : in STD_LOGIC;
             RegDst : in STD_LOGIC;
             RegSrcA : in STD_LOGIC_VECTOR (31 downto 0);
             RegSrcB : in STD_LOGIC_VECTOR (31 downto 0);
             RtDest : in STD_LOGIC_VECTOR (4 downto 0);
             RdDest : in STD_LOGIC_VECTOR (4 downto 0);
             SignImm : in STD_LOGIC_VECTOR (31 downto 0);
             RegWriteOut : out STD_LOGIC;
             MemtoRegOut : out STD_LOGIC;
             MemWriteOut : out STD_LOGIC;
             ALUResult : out STD_LOGIC_VECTOR (31 downto 0);
             WriteData : out STD_LOGIC_VECTOR (31 downto 0);
             WriteReg : out STD_LOGIC_VECTOR (4 downto 0));
  end component;

  signal RegWrite: STD_LOGIC;
  signal MemtoReg: STD_LOGIC;
  signal MemWrite: STD_LOGIC;
  signal ALUControl: STD_LOGIC_VECTOR (3 downto 0);
  signal ALUSrc: STD_LOGIC;
  signal RegDst: STD_LOGIC;
  signal RegSrcA: STD_LOGIC_VECTOR (31 downto 0);
  signal RegSrcB: STD_LOGIC_VECTOR (31 downto 0);
  signal RtDest: STD_LOGIC_VECTOR (4 downto 0);
  signal RdDest: STD_LOGIC_VECTOR (4 downto 0);
  signal SignImm: STD_LOGIC_VECTOR (31 downto 0);
  signal RegWriteOut: STD_LOGIC;
  signal MemtoRegOut: STD_LOGIC;
  signal MemWriteOut: STD_LOGIC;
  signal ALUResult: STD_LOGIC_VECTOR (31 downto 0);
  signal WriteData: STD_LOGIC_VECTOR (31 downto 0);
  signal WriteReg: STD_LOGIC_VECTOR (4 downto 0);
  
  
  type execute_tests is record
    --  Test Inputs
             RegWrite   :  STD_LOGIC;
             MemtoReg   :  STD_LOGIC;
             MemWrite   :  STD_LOGIC;
             ALUControl :  STD_LOGIC_VECTOR (3 downto 0);
             ALUSrc     :  STD_LOGIC;
             RegDst     :  STD_LOGIC;
             RegSrcA    :  STD_LOGIC_VECTOR (31 downto 0);
             RegSrcB    :  STD_LOGIC_VECTOR (31 downto 0);
             RtDest     :  STD_LOGIC_VECTOR (4 downto 0);
             RdDest     :  STD_LOGIC_VECTOR (4 downto 0);
             SignImm    :  STD_LOGIC_VECTOR (31 downto 0);
    -- Test Outputs
             RegWriteOut :  STD_LOGIC;
             MemtoRegOut : STD_LOGIC;
             MemWriteOut :  STD_LOGIC;
             ALUResult   :  STD_LOGIC_VECTOR (31 downto 0);
             WriteData   :  STD_LOGIC_VECTOR (31 downto 0);
             WriteReg    :  STD_LOGIC_VECTOR (4 downto 0);
  end record;

  type test_array is array (natural range <>) of execute_tests;


constant tests : test_array :=(
            -- provided - tests AND/ANDI OP:1010
            --   ...001 AND  ...001 = ...001 with 001 in regb
(           RegWrite    => '1', 
            MemtoReg    => '1',
            MemWrite    => '1',
            ALUControl  => "1010", -- AND 
            ALUSrc      => '0',-- use RegSrcB for second ALU input
            RegDst      => '1', -- use RtDest for WriteData
            RegSrcA     => x"00000001", -- 1
            RegSrcB     => x"00000001", -- 1
            RtDest      => "00001", --address of Rt
            RdDest      => "00011", --address of Rd
            SignImm     => x"00000000", -- 0  - imm shouldnt be used with this value of ALUSrc
            RegWriteOut => '1', -- passthrough
            MemtoRegOut => '1', -- passthrough
            MemWriteOut => '1', -- passthrough
            ALUResult   => x"00000001", -- 1
            WriteReg   => "00001",  --same value as RtDest 
            WriteData    => x"00000001" ), -- is basically RegSrcB passthrough
    
    --   ...001 ADD  ...001 = ...002 - with 002 as an immediate
(           RegWrite    => '1', 
            MemtoReg    => '1',
            MemWrite    => '1',
            ALUControl  => "0100", -- ADD 
            ALUSrc      => '1',-- use imm for second ALU input
            RegDst      => '0', -- use RdDest for WriteData
            RegSrcA     => x"00000001", -- 1
            RegSrcB     => x"00000000", -- doesnt matter with this value of ALUSrc
            RtDest      => "00001", --address of Rt
            RdDest      => "00011", --address of Rd
            SignImm     => x"00000001", -- 1  
            RegWriteOut => '1', -- passthrough
            MemtoRegOut => '1', -- passthrough
            MemWriteOut => '1', -- passthrough
            ALUResult   => x"00000002", -- 2
            WriteReg   => "00011",  --same value as RdDest 
            WriteData    => x"00000000" ), -- is basically RegSrcB passthrough

            --...001 SUB  ...002 = ...-01 - with 002 in registerB 
(           RegWrite    => '1', 
            MemtoReg    => '1',
            MemWrite    => '1',
            ALUControl  => "0101", -- ADD 
            ALUSrc      => '0',-- use RegB for second ALU input
            RegDst      => '0', -- use RdDest for WriteData
            RegSrcA     => x"00000001", -- 1
            RegSrcB     => x"00000002", -- doesnt matter with this value of ALUSrc
            RtDest      => "00001", --address of Rt
            RdDest      => "00011", --address of Rd
            SignImm     => x"00000000", -- doesnt matter with this value of ALUSrc 
            RegWriteOut => '1', -- passthrough
            MemtoRegOut => '1', -- passthrough
            MemWriteOut => '1', -- passthrough
            ALUResult   => x"FFFFFFFF", -- -1
            WriteReg   => "00011",  --same value as RdDest 
            WriteData    => x"00000002" ), -- is basically RegSrcB passthrough

            --   ...002 MULTU  ...003 = ...006 with 003 in regb
(           RegWrite    => '1', 
            MemtoReg    => '1',
            MemWrite    => '1',
            ALUControl  => "0110", -- MULTU 
            ALUSrc      => '0',-- use RegSrcB for second ALU input
            RegDst      => '1', -- use RtDest for WriteData
            RegSrcA     => x"00000002", -- 2
            RegSrcB     => x"00000003", -- 3
            RtDest      => "00001", --address of Rt
            RdDest      => "00011", --address of Rd
            SignImm     => x"00000000", -- 0  - imm shouldnt be used with this value of ALUSrc
            RegWriteOut => '1', -- passthrough
            MemtoRegOut => '1', -- passthrough
            MemWriteOut => '1', -- passthrough
            ALUResult   => x"00000006", -- 6
            WriteReg    => "00001",  --same value as RtDest 
            WriteData   => x"00000003" ), -- is basically RegSrcB passthrough

            --   ...003 MULTU  ...004 = ...012 (0xC) - with 003 as an immediate
(           RegWrite    => '1', 
            MemtoReg    => '1',
            MemWrite    => '1',
            ALUControl  => "0110", -- MULTU 
            ALUSrc      => '1',-- use imm for second ALU input
            RegDst      => '0', -- use RdDest for WriteData
            RegSrcA     => x"00000003", -- 3
            RegSrcB     => x"00000000", -- doesnt matter with this value of ALUSrc
            RtDest      => "00001", --address of Rt
            RdDest      => "00011", --address of Rd
            SignImm     => x"00000004", -- 1  
            RegWriteOut => '1', -- passthrough
            MemtoRegOut => '1', -- passthrough
            MemWriteOut => '1', -- passthrough
            ALUResult   => x"0000000C", -- 2
            WriteReg   => "00011",  --same value as RdDest 
            WriteData    => x"00000000" ) -- is basically RegSrcB passthrough

                          );

begin

  uut: Execute port map ( 
                --------- INPUTS ------------------
                          RegWrite    => RegWrite,
                          MemtoReg    => MemtoReg,
                          MemWrite    => MemWrite,
                          ALUControl  => ALUControl,
                          ALUSrc      => ALUSrc,
                          RegDst      => RegDst,
                          RegSrcA     => RegSrcA,
                          RegSrcB     => RegSrcB,
                          RtDest      => RtDest,
                          RdDest      => RdDest,
                          SignImm     => SignImm,
              ---------- OUTPUTS ----------------
                          RegWriteOut => RegWriteOut,
                          MemtoRegOut => MemtoRegOut,
                          MemWriteOut => MemWriteOut,
                          ALUResult   => ALUResult,
                          WriteData   => WriteData,
                          WriteReg    => WriteReg );

  execute_proc: process
  begin
  
    -- Put initialisation code here


    -- Put test bench stimulus code here
    for i in tests'range loop
            -- only need the inputs 
              RegWrite    <= tests(i).RegWrite;
              MemtoReg    <= tests(i).MemtoReg;
              MemWrite    <= tests(i).MemWrite;
              ALUControl  <= tests(i).ALUControl;
              ALUSrc      <= tests(i).ALUSrc;
              RegDst      <= tests(i).RegDst;
              RegSrcA     <= tests(i).RegSrcA;
              RegSrcB     <= tests(i).RegSrcB;
              RtDest      <= tests(i).RtDest;
              RdDest      <= tests(i).RdDest;
              SignImm     <= tests(i).SignImm;
            
            wait for 100 ns;
            
        --assert statements for each output
            
        -- for std_logic_vectors
        
            assert ALUResult = tests(i).ALUResult
                report "ALUResult is " & to_hstring(signed(ALUResult)) &
                " but should be " & to_hstring(signed(tests(i).ALUResult))
                severity error;
            
            assert WriteData = tests(i).WriteData
                report "WriteData is " & to_hstring(signed(WriteData)) &
                " but should be " & to_hstring(signed(tests(i).WriteData))
                severity error;
            
            assert WriteReg = tests(i).WriteReg
                report "WriteReg is " & to_hstring(signed(WriteReg)) &
                " but should be " & to_hstring(signed(tests(i).WriteReg))
                severity error;
                
                
           -- for std_logic    
            assert RegWriteOut = tests(i).RegWriteOut
                report "RegWriteOut is " & std_logic'image(RegWriteOut) &
                " but should be " & std_logic'image(tests(i).RegWriteOut)
                severity error;    
            
             assert MemtoRegOut = tests(i).MemtoRegOut
                report "MemtoRegOut is " & std_logic'image(MemtoRegOut) &
                " but should be " & std_logic'image(tests(i).MemtoRegOut)
                severity error;    
            
            assert MemWriteOut = tests(i).MemWriteOut
                report "MemWriteOut is " & std_logic'image(MemWriteOut) &
                " but should be " & std_logic'image(tests(i).MemWriteOut)
                severity error;   
           
           
            --wait for 100 ns;
        end loop;

        --crude default way that provided tesbenches end. Throw code that aborts process
            --lowkey annoying - change if have time when done
        assert false
          report "Testbench Concluded."
          severity failure;

    wait;
  end process;


end;
