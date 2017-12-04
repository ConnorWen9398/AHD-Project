----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/03/2017 07:20:19 PM
-- Design Name: 
-- Module Name: Control_Unit_TB - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Control_Unit_TB is
--  Port ( );
end Control_Unit_TB;

architecture Behavioral of Control_Unit_TB is
    COMPONENT Control_Unit
    port (
      opcode: in  STD_LOGIC_vector(5 downto 0);
      func : in  std_logic_vector(5 downto 0);
      ALUop: out std_logic_vector(2 downto 0);
      RegDst : out  STD_LOGIC;
      ALUSrc : out  STD_LOGIC;
      PCSrc: out  STD_logic;
      MemToReg : out  STD_LOGIC;
      RegWrite : out  STD_LOGIC;
      MemWrite : out  STD_LOGIC;
      shiftl: out std_logic;
      shiftr: out std_logic;
      Jump : out STD_LOGIC;
      BranchNE : out std_logic;
      Branch : out  STD_LOGIC;
      Branchlt: out  STD_logic;
      halt: out std_logic
        );
      end component;
      signal opcode: STD_LOGIC_vector(5 downto 0);
      signal func : std_logic_vector(5 downto 0);
      signal ALUop : std_logic_vector(2 downto 0);
      signal RegDst : STD_LOGIC;
      signal ALUSrc : STD_LOGIC;
      signal PCSrc: STD_logic;
      signal MemToReg : STD_LOGIC;
      signal RegWrite : STD_LOGIC;
      signal MemWrite : STD_LOGIC;
      signal shiftl: std_logic;
      signal shiftr: std_logic;
      signal Jump : STD_LOGIC;
      signal BranchNE : std_logic;
      signal Branch : STD_LOGIC;
      signal Branchlt: STD_logic;
      signal halt: std_logic;

begin
    uut: Control_Unit PORT MAP (
      opcode => opcode,
      func => func,
      ALUop => ALUop,
      RegDst => RegDst,
      ALUSrc => ALUSrc,
      PCSrc => PCSrc,
      MemToReg => MemToReg,
      RegWrite => RegWrite,
      MemWrite => MemWrite,
      shiftl => shiftl,
      shiftr => shiftr,
      Jump => Jump,
      BranchNE => BranchNE,
      Branch => Branch,
      Branchlt => Branchlt,
      halt => halt
    );
    
    stim_proc: process
    begin        
      -- hold reset state for 100 ns.
        opcode <= "000000";
        func <= "000000"; wait for 10ns;
        func <= "000001"; wait for 10ns;
        func <= "000010"; wait for 10ns;
        func <= "000011"; wait for 10ns;
        func <= "000100"; wait for 10ns;
        func <= "000101"; wait for 10ns;
        opcode <= "000001"; wait for 10ns;
        opcode <= "000010"; wait for 10ns;
        opcode <= "000011"; wait for 10ns;
        opcode <= "000100"; wait for 10ns;
        opcode <= "000101"; wait for 10ns;
        opcode <= "000110"; wait for 10ns;
        opcode <= "000111"; wait for 10ns;
        opcode <= "001000"; wait for 10ns;
        opcode <= "001001"; wait for 10ns;
        opcode <= "001010"; wait for 10ns;
        opcode <= "001011"; wait for 10ns;
        opcode <= "001100"; wait for 10ns;
        opcode <= "111111"; wait ;    
    end process;
    
end Behavioral;
