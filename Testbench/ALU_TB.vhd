----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/03/2017 04:20:50 PM
-- Design Name: 
-- Module Name: ALU_TB - Behavioral
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

entity ALU_TB is
--  Port ( );
end ALU_TB;

architecture Behavioral of ALU_TB is
    COMPONENT ALU
    port (
        SrcA : in STD_LOGIC_VECTOR(31 downto 0);
        SrcB : in STD_LOGIC_VECTOR(31 downto 0);
        Sign_Extended_Operand : in STD_LOGIC_VECTOR(15 downto 0);
        ALUOp : in STD_LOGIC_VECTOR(2 downto 0);
        ALUSrc: in STD_LOGIC;
        Zero : out STD_LOGIC;
        LessThan : out STD_LOGIC;
        ALUResult : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
    SIGNAL SrcA : STD_LOGIC_VECTOR(31 downto 0);
    SIGNAL SrcB : STD_LOGIC_VECTOR(31 downto 0);
    SIGNAL Sign_Extended_Operand : STD_LOGIC_VECTOR(15 downto 0);
    SIGNAL ALUOp : STD_LOGIC_VECTOR(2 downto 0);
    SIGNAL ALUSrc : STD_LOGIC; 
    SIGNAL Zero : STD_LOGIC; 
    SIGNAL LessThan : STD_LOGIC; 
    SIGNAL ALUResult : STD_LOGIC_VECTOR(31 downto 0);    

begin

    uut: ALU PORT MAP (
        SrcA => SrcA,
        SrcB => SrcB,
        Sign_Extended_Operand => Sign_Extended_Operand,
        ALUOp => ALUOp,
        ALUSrc => ALUSrc,
        Zero => Zero,
        LessThan => LessThan,
        ALUResult => ALUResult
        );
        
           -- Clock process definitions
        stim_proc: process
        begin
             ALUSrc <= '0';
             SrcA <= "00000000000000000000000000000100";
             SrcB <= "00000000000000000000000000000011";
             Sign_Extended_Operand <= "0000000000000000";
             ALUOp <= "000"; wait for 10ns;
             ALUOp <= "001"; wait for 10ns;
             ALUOp <= "010"; wait for 10ns;
             ALUOp <= "011"; wait for 10ns;
             ALUOp <= "100"; wait for 10ns;
             ALUOp <= "101"; wait for 10ns;
             ALUOp <= "110"; wait for 10ns;
             ALUOp <= "111"; wait;
             
        end process;
            
end Behavioral;
