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
           ALU_Result : out STD_LOGIC_VECTOR(31 downto 0)
         );     
end ALU;

architecture Behavioral of ALU is
    SIGNAL InputA : STD_LOGIC_VECTOR(31 downto 0);
    SIGNAL InputB:  STD_LOGIC_VECTOR(31 downto 0);
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
         
process(ALUOp, InputA, InputB)
begin
    case ALUOp is
        when "000" => ALUOutput <= InputA + InputB;
        when "001" => ALUOutput <= InputA - InputB;
        when "010" => ALUOutput <= InputA and InputB;
        when "011" => ALUOutput <= InputA or InputB;
        when "100" => ALUOutput <= InputA nor InputB;
        when "101" => ALUOutput <= STD_LOGIC_VECTOR(unsigned(InputA) sll CONV_INTEGER(InputB));
        when "110" => ALUOutput <= STD_LOGIC_VECTOR(unsigned(InputA) srl CONV_INTEGER(InputB));            
        when others => ALUOutput <= X"00000000";
    end case;
end process;

end Behavioral;
