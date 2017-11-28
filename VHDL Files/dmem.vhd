----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:56:30 11/27/2017 
-- Design Name: 
-- Module Name:    dmem - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dmem is
port(
     clk: in std_logic;
	  reset:in std_logic;
     address: in std_logic_vector(31 downto 0);
     wrtdata: in std_logic_vector(31 downto 0);
	  wrtmemen: in std_logic;
	  rddata: out std_logic_vector(31 downto 0));
end dmem;

architecture Behavioral of dmem is
type dtype is array(0 to 31)of std_logic_vector(31 downto 0);
signal datamem: dtype :=

(("10110111111000010101000101100011",--0
 "01010110000110001100101100011100",--1
 "11110100010100000100010011010101",--2
 "10010010100001111011111010001110",--3
 "00110000101111110011100001000111",--4
 "11001110111101101011001000000000",--5
 "01101101001011100010101110111001",--6
 "00001011011001011010010101110010",--7
 "10101001100111010001111100101011",--8
 "01000111110101001001100011100100",--9
 "11100110000011000001001010011101",--10
 "10000100010000111000110001010110",--11
 "00100010011110110000011000001111",--12
 "11000000101100100111111111001000",--13
 "01011110111010011111100110000001",--14
 "11111101001000010111001100111010",--15
 "10011011010110001110110011110011",--16
 "00111001100100000110011010101100",--17
 "11010111110001111110000001100101",--18
 "01110101111111110101101000011110",--19
 "00010100001101101101001111010111",--20
 "10110010011011100100110110010000",--21
 "01010000101001011100011101001001",--22
 "11101110110111010100000100000010",--23
 "10001101000101001011101010111011",--24
 "00101011010011000011010001110100",--25
 "00000000000000000000000000000000",--26
 "00000000000000000000000000000000",--27
 "00000000000000000000000000000000",--28
 "00000000000000000000000000000000",--29
 "00000000000000000000000000000000",--30
 "00000000000000000000000000000000" --31
 );
begin

process(clk,reset)

begin

 if(reset='1')then 
	 datamem(0)<= "10110111111000010101000101100011"; 
      datamem(1)<= "01010110000110001100101100011100";
      datamem(2)<= "11110100010100000100010011010101"; 
		datamem(3)<= "10010010100001111011111010001110";
		datamem(4)<= "00110000101111110011100001000111";
		datamem(5)<= "11001110111101101011001000000000";
		datamem(6)<= "01101101001011100010101110111001";
		datamem(7)<= "00001011011001011010010101110010";
		datamem(8)<= "10101001100111010001111100101011";
		datamem(9)<= "01000111110101001001100011100100";
		datamem(10)<= "11100110000011000001001010011101";
		datamem(11)<= "10000100010000111000110001010110";
		datamem(12)<= "00100010011110110000011000001111";
		datamem(13)<= "11000000101100100111111111001000";
		datamem(14)<= "01011110111010011111100110000001";
		datamem(15)<= "11111101001000010111001100111010";
		datamem(16)<= "10011011010110001110110011110011";
		datamem(17)<= "00111001100100000110011010101100";
		datamem(18)<= "11010111110001111110000001100101";
		datamem(19)<= "01110101111111110101101000011110";
		datamem(20)<= "00010100001101101101001111010111";
		datamem(21)<= "10110010011011100100110110010000";
		datamem(22)<= "01010000101001011100011101001001";
		datamem(23)<= "11101110110111010100000100000010";
		datamem(24)<= "10001101000101001011101010111011";
		datamem(25)<= "00101011010011000011010001110100";
	
	 datamem(26)<= "00000000000000000000000000000000";
	 datamem(27)<= "00000000000000000000000000000000";
	 datamem(28)<= "00000000000000000000000000000000";
	 datamem(29)<= "00000000000000000000000000000000";
	 datamem(30)<= "00000000000000000000000000000000";
	 datamem(31)<= "00000000000000000000000000000000";
	  elsif(clk'EVENT AND clk='1')then
	    if(wrtmemen='1')then
       datamem(conv_integer(address(4 downto 0)))<= wrtdata;
		 end if;
		 end if;
end process;
rddata<=datamem(conv_integer(address(4 downto 0)));
end Behavioral;

