----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/27/2017 07:24:44 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( 
           SrcA : in STD_LOGIC_VECTOR(31 downto 0);
           SrcB : in STD_LOGIC_VECTOR(31 downto 0);
           Sign_Extended_Operand : in STD_LOGIC_VECTOR(15 downto 0);
           ALUOp : in STD_LOGIC_VECTOR(2 downto 0);
           ALUSrc: in STD_LOGIC;
           Zero : out STD_LOGIC;
           LessThan : out STD_LOGIC;
           ALU_Result : out STD_LOGIC_VECTOR(31 downto 0);
           Rs : out STD_LOGIC_VECTOR(31 downto 0);
           Rt : out STD_LOGIC_VECTOR(31 downto 0);
           Rd : out STD_LOGIC_VECTOR(31 downto 0);
           Imm: out STD_LOGIC_VECTOR(15 downto 0)
         );     
end ALU;

architecture Behavioral of ALU is
    SIGNAL InputA : STD_LOGIC_VECTOR(31 downto 0);
    SIGNAL InputB:  STD_LOGIC_VECTOR(31 downto 0);
	 SIGNAL Leftrot : STD_LOGIC_VECTOR(31 downto 0);
    SIGNAL Rightrot:  STD_LOGIC_VECTOR(31 downto 0);
	 SIGNAL zeros:  STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
    SIGNAL ALUOutput : STD_LOGIC_VECTOR(31 DOWNTO 0);    
    SIGNAL Sign_Extended: STD_LOGIC_VECTOR(31 downto 0);
begin
    Sign_Extended <= STD_LOGIC_VECTOR(resize(signed(Sign_Extended_Operand), Sign_Extended'length));
    InputA <= SrcA; 
    InputB <= SrcB when ALUSrc = '0' else
              Sign_Extended;
    Zero <= '1' when (ALUOutput = X"00000000") else 
            '0';
    LessThan <= '1' when(ALUOutput(31) = '1') else
                '0';
    ALU_Result <= ALUOutput;
    
    Rs <= SrcA;
    Rt <= SrcB when ALUSrc = '0' else ALUOutput;
    Rd <= ALUOutput when ALUSrc = '0'else X"00000000";
    Imm<= X"0000"when ALUSrc = '0'else Sign_Extended_Operand;
    

				
WITH InputB(4 DOWNTO 0) SELECT
Leftrot<= InputA(30 DOWNTO 0) & zeros(31) WHEN "00001",
		    InputA(29 DOWNTO 0) & zeros(31 DOWNTO 30) WHEN "00010",
	       InputA(28 DOWNTO 0) & zeros(31 DOWNTO 29) WHEN "00011",
	       InputA(27 DOWNTO 0) & zeros(31 DOWNTO 28) WHEN "00100",
          InputA(26 DOWNTO 0) & zeros(31 DOWNTO 27) WHEN "00101",
		    InputA(25 DOWNTO 0) & zeros(31 DOWNTO 26) WHEN "00110",
		    InputA(24 DOWNTO 0) & zeros(31 DOWNTO 25) WHEN "00111",
		    InputA(23 DOWNTO 0) & zeros(31 DOWNTO 24) WHEN "01000",
		    InputA(22 DOWNTO 0) & zeros(31 DOWNTO 23) WHEN "01001",
		    InputA(21 DOWNTO 0) & zeros(31 DOWNTO 22) WHEN "01010",
		    InputA(20 DOWNTO 0) & zeros(31 DOWNTO 21) WHEN "01011",
		    InputA(19 DOWNTO 0) & zeros(31 DOWNTO 20) WHEN "01100",
		    InputA(18 DOWNTO 0) & zeros(31 DOWNTO 19) WHEN "01101",
		    InputA(17 DOWNTO 0) & zeros(31 DOWNTO 18) WHEN "01110",
		    InputA(16 DOWNTO 0) & zeros(31 DOWNTO 17) WHEN "01111",
		    InputA(15 DOWNTO 0) & zeros(31 DOWNTO 16) WHEN "10000",	
		    InputA(14 DOWNTO 0) & zeros(31 DOWNTO 15) WHEN "10001",
		    InputA(13 DOWNTO 0) & zeros(31 DOWNTO 14) WHEN "10010",
		    InputA(12 DOWNTO 0) & zeros(31 DOWNTO 13) WHEN "10011",
		    InputA(11 DOWNTO 0) & zeros(31 DOWNTO 12) WHEN "10100",
		    InputA(10 DOWNTO 0) & zeros(31 DOWNTO 11) WHEN "10101",
		    InputA(9 DOWNTO 0) & zeros(31 DOWNTO 10) WHEN "10110",
		    InputA(8 DOWNTO 0) & zeros(31 DOWNTO 9) WHEN "10111",
		    InputA(7 DOWNTO 0) & zeros(31 DOWNTO 8) WHEN "11000",
		    InputA(6 DOWNTO 0) & zeros(31 DOWNTO 7) WHEN "11001",
		    InputA(5 DOWNTO 0) & zeros(31 DOWNTO 6) WHEN "11010",
		    InputA(4 DOWNTO 0) & zeros(31 DOWNTO 5) WHEN "11011",
		    InputA(3 DOWNTO 0) & zeros(31 DOWNTO 4) WHEN "11100",
		    InputA(2 DOWNTO 0) & zeros(31 DOWNTO 3) WHEN "11101",
		    InputA(1 DOWNTO 0) & zeros(31 DOWNTO 2) WHEN "11110",
		    InputA(0) & zeros(31 DOWNTO 1) WHEN "11111",
		    InputA WHEN OTHERS;
			 
with InputB(4 downto 0)select
Rightrot<= zeros(30 downto 0)& InputA(31)when "11111",
	zeros(29 DOWNTO 0) & InputA(31 DOWNTO 30) WHEN "11110",
	zeros(28 DOWNTO 0) & InputA(31 DOWNTO 29) WHEN "11101",
	zeros(27 DOWNTO 0) & InputA(31 DOWNTO 28) WHEN "11100",
	zeros(26 DOWNTO 0) & InputA(31 DOWNTO 27) WHEN "11011",
	zeros(25 DOWNTO 0) & InputA(31 DOWNTO 26) WHEN "11010",
	zeros(24 DOWNTO 0) & InputA(31 DOWNTO 25) WHEN "11001",
	zeros(23 DOWNTO 0) & InputA(31 DOWNTO 24) WHEN "11000",
	zeros(22 DOWNTO 0) & InputA(31 DOWNTO 23) WHEN "10111",
	zeros(21 DOWNTO 0) & InputA(31 DOWNTO 22) WHEN "10110",
	zeros(20 DOWNTO 0) & InputA(31 DOWNTO 21) WHEN "10101",
	zeros(19 DOWNTO 0) & InputA(31 DOWNTO 20) WHEN "10100",
	zeros(18 DOWNTO 0) & InputA(31 DOWNTO 19) WHEN "10011",
	zeros(17 DOWNTO 0) & InputA(31 DOWNTO 18) WHEN "10010",
	zeros(16 DOWNTO 0) & InputA(31 DOWNTO 17) WHEN "10001",
	zeros(15 DOWNTO 0) & InputA(31 DOWNTO 16) WHEN "10000",
   zeros(14 DOWNTO 0) & InputA(31 DOWNTO 15) WHEN "01111",
	zeros(13 DOWNTO 0) & InputA(31 DOWNTO 14) WHEN "01110",
	zeros(12 DOWNTO 0) & InputA(31 DOWNTO 13) WHEN "01101",
	zeros(11 DOWNTO 0) & InputA(31 DOWNTO 12) WHEN "01100",
	zeros(10 DOWNTO 0) & InputA(31 DOWNTO 11) WHEN "01011",
	zeros(9 DOWNTO 0) & InputA(31 DOWNTO 10) WHEN "01010",
	zeros(8 DOWNTO 0) & InputA(31 DOWNTO 9) WHEN "01001",
	zeros(7 DOWNTO 0) & InputA(31 DOWNTO 8) WHEN "01000",
	zeros(6 DOWNTO 0) & InputA(31 DOWNTO 7) WHEN "00111",
	zeros(5 DOWNTO 0) & InputA(31 DOWNTO 6) WHEN "00110",
	zeros(4 DOWNTO 0) & InputA(31 DOWNTO 5) WHEN "00101",
	zeros(3 DOWNTO 0) & InputA(31 DOWNTO 4) WHEN "00100",
	zeros(2 DOWNTO 0) & InputA(31 DOWNTO 3) WHEN "00011",
	zeros(1 DOWNTO 0) & InputA(31 DOWNTO 2) WHEN "00010",
	zeros(0) & InputA(31 DOWNTO 1) WHEN "00001",
	InputA WHEN OTHERS;

With ALUOp select
ALUOutput<= InputA+ InputB when"000",
			   InputA- InputB when"001",
				InputA and InputB when"010",
				InputA or InputB when"011",
				InputA nor InputB when"100",
				Leftrot when"101",
				Rightrot when "110",
				X"00000000" when others;
				

end Behavioral;
