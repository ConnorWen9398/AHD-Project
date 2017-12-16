--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:06:12 11/28/2017
-- Design Name:   
-- Module Name:   C:/NYU VHDL/NYU_6463_Processor/test.vhd
-- Project Name:  NYU_6463_Processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: cpu
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
 
ENTITY test IS
END test;
 
ARCHITECTURE behavior OF test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT cpu
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         sel : IN  std_logic;
         skey : IN  std_logic_vector(127 downto 0);
         din : IN  std_logic_vector(63 downto 0);
		 valid: IN std_logic;
         dout : OUT  std_logic_vector(63 downto 0);
         data_vld : OUT  std_logic;
         instruction : OUT  std_logic_vector(31 downto 0);
          dmem0: out std_logic_vector(31 downto 0);
                       dmem1: out std_logic_vector(31 downto 0);
                       dmem2: out std_logic_vector(31 downto 0); 
                       dmem3:out std_logic_vector(31 downto 0);
                       dmem4:out std_logic_vector(31 downto 0);
                       dmem5:out std_logic_vector(31 downto 0);
                       dmem6:out std_logic_vector(31 downto 0);
                       dmem7:out std_logic_vector(31 downto 0);
                       dmem8:out std_logic_vector(31 downto 0);
                       dmem9:out std_logic_vector(31 downto 0);
                       dmem10:out std_logic_vector(31 downto 0);
                       dmem11:out std_logic_vector(31 downto 0);
                       dmem12:out std_logic_vector(31 downto 0);
                       dmem13:out std_logic_vector(31 downto 0);
                       dmem14:out std_logic_vector(31 downto 0);
                       dmem15:out std_logic_vector(31 downto 0);
                       dmem16:out std_logic_vector(31 downto 0);
                       dmem17:out std_logic_vector(31 downto 0);
                       dmem18:out std_logic_vector(31 downto 0);
                       dmem19:out std_logic_vector(31 downto 0);
                       dmem20:out std_logic_vector(31 downto 0);
                       dmem21:out std_logic_vector(31 downto 0);
                       dmem22:out std_logic_vector(31 downto 0);
                       dmem23:out std_logic_vector(31 downto 0);
                       dmem24:out std_logic_vector(31 downto 0);
                       dmem25:out std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic ;
   signal reset : std_logic ;
   signal sel : std_logic ;
   signal skey : std_logic_vector(127 downto 0) ;
   signal din : std_logic_vector(63 downto 0) ;
	signal valid:std_logic;

 	--Outputs
   signal dout : std_logic_vector(63 downto 0);
   signal data_vld : std_logic;
   signal instruction : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
   signal dmem0:std_logic_vector(31 downto 0);
   signal dmem1:std_logic_vector(31 downto 0);
   signal dmem2:std_logic_vector(31 downto 0);
   signal dmem3:std_logic_vector(31 downto 0);
   signal dmem4:std_logic_vector(31 downto 0);
   signal dmem5:std_logic_vector(31 downto 0);
   signal dmem6:std_logic_vector(31 downto 0);
   signal dmem7:std_logic_vector(31 downto 0);
   signal dmem8:std_logic_vector(31 downto 0);
   signal dmem9:std_logic_vector(31 downto 0);
   signal dmem10:std_logic_vector(31 downto 0);
   signal dmem11:std_logic_vector(31 downto 0);
   signal dmem12:std_logic_vector(31 downto 0);
   signal dmem13:std_logic_vector(31 downto 0);
   signal dmem14:std_logic_vector(31 downto 0);
   signal dmem15:std_logic_vector(31 downto 0);
   signal dmem16:std_logic_vector(31 downto 0);
   signal dmem17:std_logic_vector(31 downto 0);
   signal dmem18:std_logic_vector(31 downto 0);
   signal dmem19:std_logic_vector(31 downto 0);
   signal dmem20:std_logic_vector(31 downto 0);
   signal dmem21:std_logic_vector(31 downto 0);
   signal dmem22:std_logic_vector(31 downto 0);
   signal dmem23:std_logic_vector(31 downto 0);
   signal dmem24:std_logic_vector(31 downto 0);
   signal dmem25:std_logic_vector(31 downto 0);
   
   
    
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: cpu PORT MAP (
          clk => clk,
          reset => reset,
          sel => sel,
          skey => skey,
          din => din,
		  valid=>valid,
          dout => dout,
          data_vld => data_vld,
          instruction => instruction,
          dmem0=>dmem0,
          dmem1=>dmem1,
          dmem2=>dmem2,
          dmem3=>dmem3,
          dmem4=>dmem4,
          dmem5=>dmem5,
          dmem6=>dmem6,
          dmem7=>dmem7,
          dmem8=>dmem8,
          dmem9=>dmem9,
          dmem10=>dmem10,
          dmem11=>dmem11,
          dmem12=>dmem12,
          dmem13=>dmem13,
          dmem14=>dmem14,
          dmem15=>dmem15,
          dmem16=>dmem16,
          dmem17=>dmem17,
          dmem18=>dmem18,
          dmem19=>dmem19,
          dmem20=>dmem20,
          dmem21=>dmem21,
          dmem22=>dmem22,
          dmem23=>dmem23,
          dmem24=>dmem24,
          dmem25=>dmem25
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
   rst_process :process
   begin
		reset <= '1';
		wait for 2ns;
		reset<= '0';
		wait ;
   end process;
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		skey<=x"00000000000000000000000000000000";
      wait ;	
	end process;
 	valid_process :process
   begin
		valid <= '0';
		wait for 10ns;
		valid<= '1';
		wait ;
   end process;

    
   
	proc2: process
   begin		
      -- hold reset state for 100 ns.
		sel<='1';
      wait ;	
		

    
   end process;
	proc: process
   begin		
      -- hold reset state for 100 ns.
		din<=x"0000000000000000";
      wait ;	
		

    
   end process;
	
	

END;
