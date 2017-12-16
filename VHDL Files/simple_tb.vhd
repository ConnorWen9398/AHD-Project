--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:35:50 12/14/2017
-- Design Name:   
-- Module Name:   D:/nyu/17fa/AVH/PROJECT/Board_inout_3/simple_tb.vhd
-- Project Name:  Board_inout_3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Board_inout
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
 
ENTITY simple_tb IS
END simple_tb;
 
ARCHITECTURE behavior OF simple_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Board_inout
    PORT(
         sw : IN  std_logic_vector(15 downto 0);
         btnc : IN  std_logic;
         btnd : IN  std_logic;
         btnl : IN  std_logic;
         btnr : IN  std_logic;
         btnu : IN  std_logic;
         CLK : IN  std_logic;
         SSEG_AN : OUT  std_logic_vector(7 downto 0);
         SSEG_CA : OUT  std_logic_vector(7 downto 0);
         led : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal sw : std_logic_vector(15 downto 0) := (others => '0');
   signal btnc : std_logic := '0';
   signal btnd : std_logic := '0';
   signal btnl : std_logic := '0';
   signal btnr : std_logic := '0';
   signal btnu : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal SSEG_AN : std_logic_vector(7 downto 0);
   signal SSEG_CA : std_logic_vector(7 downto 0);
   signal led : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Board_inout PORT MAP (
          sw => sw,
          btnc => btnc,
          btnd => btnd,
          btnl => btnl,
          btnr => btnr,
          btnu => btnu,
          CLK => CLK,
          SSEG_AN => SSEG_AN,
          SSEG_CA => SSEG_CA,
          led => led
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		sw<="0000000000000000";
		btnc<='0';
		btnd<='0';
		btnr<='0';
		btnl<='0';
		btnu<='0';
      wait for 100 ns;	
		btnc<='1';
      wait for CLK_period*10;
		btnc<='0';
		sw<="0000000000000010";
      -- insert stimulus here 

      wait;
   end process;

END;
