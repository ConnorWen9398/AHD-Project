----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/03/2017 03:33:26 PM
-- Design Name: 
-- Module Name: rftest - Behavioral
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

entity rftest is
--  Port ( );
end rftest;

architecture Behavioral of rftest is
    COMPONENT RegisterFile
    port (clk: in std_logic;
          reset:in std_logic;
          wrten: in std_logic;
          rdreg1: in std_logic_vector(4 downto 0);
          rdreg2: in std_logic_vector(4 downto 0);
          wrtreg: in std_logic_vector(4 downto 0);
          wrtdata: in std_logic_vector(31 downto 0);
          rddata1,rddata2: out std_logic_vector(31 downto 0);
          encA:out std_logic_vector(31 downto 0);
          encB:out std_logic_vector(31 downto 0);
          decA:out std_logic_vector(31 downto 0);
          decB:out std_logic_vector(31 downto 0)
            );
     end component;
     signal clk: std_logic;
     signal reset: std_logic;
     signal wrten: std_logic;
     signal rdreg1: std_logic_vector(4 downto 0);
     signal rdreg2: std_logic_vector(4 downto 0);
     signal wrtreg: std_logic_vector(4 downto 0);
     signal wrtdata: std_logic_vector(31 downto 0);
     signal rddata1,rddata2: std_logic_vector(31 downto 0);
     signal encA: std_logic_vector(31 downto 0);
     signal encB: std_logic_vector(31 downto 0);
     signal decA: std_logic_vector(31 downto 0);
     signal decB: std_logic_vector(31 downto 0);
     constant clk_period : time := 100 ns;
begin
    uut: RegisterFile PORT MAP (
          clk => clk,
          reset => reset,
          wrten => wrten,
          rdreg1 => rdreg1,
          rdreg2 => rdreg2,
		  wrtreg=>wrtreg,
          wrtdata => wrtdata,
          rddata1 => rddata1,
          rddata2 => rddata2,
          encA => encA,
          encB => encB,
          decA => decA,
          decB => decB
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
        
        stim_proc: process
           begin        
              -- hold reset state for 100 ns.
                wrten<='1';
                wrtreg <= "00001";
                wrtdata <= x"12345678";
                wait for clk_period;
					 wrten<='0';
                rdreg1 <= "00001";
					 wait for clk_period;
					 wrten<='1';
                wrtreg <= "00010";
                wrtdata <= x"87654321";
					 wait for clk_period;
                wrten<='0';
                rdreg2 <= "00010";
              wait ;    
            end process;
end Behavioral;
