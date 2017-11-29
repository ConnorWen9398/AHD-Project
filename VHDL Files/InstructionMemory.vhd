
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:31:53 11/28/2017 
-- Design Name: 
-- Module Name:    InstructionMemory - Behavioral 
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

entity InstructionMemory is
port(
     skey: in std_logic_vector(127 downto 0);
	  din: in std_logic_vector(63 downto 0);
     address: in std_logic_vector(31 downto 0);
	  Instruction: out std_logic_vector(31 downto 0));
	  
end InstructionMemory;

architecture Behavioral of InstructionMemory is

type ramtype3 is array(0 to 171)of std_logic_vector(31 downto 0);
signal imem: ramtype3:=
(
 -- key expansion
 "00000000000000000000100000010000",--0 ADD RO,RO, R1 R1=0
 
 -- RC5-enc
 
 -- RC5-dec
 
 "11111100000000000000000000000000" -- halt
 );
 
begin
    imem(3)<="0000010000011110"&skey(31 downto 16);
	 imem(5)<="0000010000011101"&skey(15 downto 0);
	 imem(8)<="0000010000011110"&skey(63 downto 48);
	 imem(10)<="0000010000011101"&skey(47 downto 32);
	 imem(13)<="0000010000011110"&skey(95 downto 80);
	 imem(15)<="0000010000011101"&skey(79 downto 64);
	 imem(18)<="0000010000011110"&skey(127 downto 112);
	 imem(20)<="0000010000011101"&skey(111 downto 96);
	 imem(67)<="0000010000000100"&din(63 downto 48);
	 imem(69)<="0000010000011101"&din(47 downto 32);
	 imem(71)<="0000010000000101"&din(31 downto 16);
	 imem(73)<="0000010000011101"&din(15 downto 0);
	 imem(121)<="0000010000000100"&din(63 downto 48);
	 imem(123)<="0000010000011101"&din(47 downto 32);
	 imem(125)<="0000010000000101"&din(31 downto 16);
	 imem(127)<="0000010000011101"&din(15 downto 0);			 
    Instruction<=imem(conv_integer(address));

end Behavioral;