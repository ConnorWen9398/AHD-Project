library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Hex2LED is
    Port ( CLK: in STD_LOGIC; X : in  STD_LOGIC_VECTOR (4 downto 0);
           Y : out  STD_LOGIC_VECTOR (7 downto 0));
end Hex2LED;

architecture Behavioral of Hex2LED is
begin
process (CLK)
begin
case X is
when "00000" => Y <= "11000000";
when "00001" => Y <= "11111001";
when "00010" => Y <= "10100100";
when "00011" => Y <= "10110000";
when "00100" => Y <= "10011001";
when "00101" => Y <= "10010010";
when "00110" => Y <= "10000010";
when "00111" => Y <= "11111000";
when "01000" => Y <= "10000000";
when "01001" => Y <= "10010000";
when "01010" => Y <= "10001000"; 
when "01011" => Y <= "10000011"; 
when "01100" => Y <= "11000110"; 
when "01101" => Y <= "10100001"; 
when "01110" => Y <= "10000110"; 
when "01111" => Y <= "10001110"; 
when others => Y <= "11111111"; 
end case;
end process;
end Behavioral;

