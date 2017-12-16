--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:56:10 11/29/2017
-- Design Name:   
-- Module Name:   H:/AVH/project/adder/ADDER_tb.vhd
-- Project Name:  adder
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ADDER
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
 
ENTITY ADDER_tb IS
END ADDER_tb;
 
ARCHITECTURE behavior OF ADDER_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ADDER
    PORT(
         op1 : IN  std_logic_vector(31 downto 0);
         op2 : IN  std_logic_vector(31 downto 0);
         output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal op1 : std_logic_vector(31 downto 0) := (others => '0');
   signal op2 : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(31 downto 0);
	signal clock : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ADDER PORT MAP (
          op1 => op1,
          op2 => op2,
          output => output
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      
		op1<=x"00000001";
		op2<=x"00000011";
		wait for clock_period;
		op1<=x"00000100";
		op2<=x"00000010";
		wait for clock_period;
		op1<=x"00001100";
		op2<=x"00001010";
      wait for clock_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
