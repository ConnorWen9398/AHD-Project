--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:26:16 11/29/2017
-- Design Name:   
-- Module Name:   H:/AVH/project/MUX/MUX_tb.vhd
-- Project Name:  MUX
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MUX
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
 
ENTITY MUX_tb IS
END MUX_tb;
 
ARCHITECTURE behavior OF MUX_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MUX
    PORT(
         in0 : IN  std_logic_vector(31 downto 0);
         in1 : IN  std_logic_vector(31 downto 0);
         sel : IN  std_logic;
         output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal in0 : std_logic_vector(31 downto 0) := (others => '0');
   signal in1 : std_logic_vector(31 downto 0) := (others => '0');
   signal sel : std_logic := '0';
   signal clock: std_logic;
 	--Outputs
   signal output : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX PORT MAP (
          in0 => in0,
          in1 => in1,
          sel => sel,
          output => output
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock<= '0';
		wait for clock_period/2;
		clock<= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		in0<=x"00000000";
		in1<=x"00000001";
		sel<='0';
		
		wait for clock_period;
		sel<='1';
		in0<=x"00000002";
		
		wait for clock_period;
		sel<='0';
		in1<=x"00000003";
		
		wait for clock_period;
		sel<='1';
      wait for clock_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
