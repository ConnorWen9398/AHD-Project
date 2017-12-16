--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:44:46 11/29/2017
-- Design Name:   
-- Module Name:   H:/AVH/project/IF/IF_tb.vhd
-- Project Name:  IF
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Instruction_Fetch
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
 
ENTITY IF_tb IS
END IF_tb;
 
ARCHITECTURE behavior OF IF_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Instruction_Fetch
    PORT(
         skey : IN  std_logic_vector(127 downto 0);
         din : IN  std_logic_vector(63 downto 0);
         branch_imm : IN  std_logic_vector(31 downto 0);
         jump_bool : IN  std_logic;
         branch_bool : IN  std_logic;
         halt_bool : IN  std_logic;
         clk : IN  std_logic;
         reset : IN  std_logic;
         valid : IN  std_logic;
         instr : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal skey : std_logic_vector(127 downto 0) := (others => '0');
   signal din : std_logic_vector(63 downto 0) := (others => '0');
   signal branch_imm : std_logic_vector(31 downto 0) := (others => '0');
   signal jump_bool : std_logic := '0';
   signal branch_bool : std_logic := '0';
   signal halt_bool : std_logic := '0';
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal valid : std_logic := '0';

 	--Outputs
   signal instr : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Instruction_Fetch PORT MAP (
          skey => skey,
          din => din,
          branch_imm => branch_imm,
          jump_bool => jump_bool,
          branch_bool => branch_bool,
          halt_bool => halt_bool,
          clk => clk,
          reset => reset,
          valid => valid,
          instr => instr
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      
		skey<=x"00000000000000000000000000000000";
		din<=x"0000000000000000";
		branch_imm<=x"00000001";
		jump_bool<='0';
		branch_bool<='0';
		halt_bool<='0';
		reset<='1';
		valid<='0';
		wait for clk_period;
		reset<='0';
		valid<='1';
		wait for clk_period;
		jump_bool<='1';
		wait for clk_period;
		jump_bool<='0';
		branch_bool<='1';
		
		wait for clk_period;
		branch_bool<='0';
		halt_bool<='0';
		wait for clk_period*2;
		halt_bool<='1';
		wait for clk_period*5;
		halt_bool<='0';
      wait for clk_period*10;
       
      -- insert stimulus here 

      wait;
   end process;

END;
