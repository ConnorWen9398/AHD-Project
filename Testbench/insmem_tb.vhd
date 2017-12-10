--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:50:51 11/27/2017
-- Design Name:   
-- Module Name:   H:/AVH/insmem/insmem_tb.vhd
-- Project Name:  insmem
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: insmem
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY insmem_tb IS
END insmem_tb;
 
ARCHITECTURE behavior OF insmem_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT InstructionMemory
    PORT(
        skey: in std_logic_vector(127 downto 0);
        din: in std_logic_vector(63 downto 0);
        address: in std_logic_vector(31 downto 0);
        Instruction: out std_logic_vector(31 downto 0));
        
    END COMPONENT;
    

   --Inputs
   signal skey:  std_logic_vector(127 downto 0):= (others => '0');
   signal din:  std_logic_vector(63 downto 0):= (others => '0');
   signal address : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Instruction : std_logic_vector(31 downto 0);

   -- Clock period definitions
--   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: InstructionMemory PORT MAP (
          skey => skey,
          din => din,
          address => address,
         Instruction => Instruction
        );

   -- Clock process definitions
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 150 ns;
        skey<=x"00000000000000000000000000000000";
        din<=x"0000000000000000";	
		address<=x"00000001";
		wait for 150 ns;
		address<=x"00000003";
		wait for 150 ns;
        address<=x"0000004A";

      -- insert stimulus here 

      wait;
   end process;

END;
