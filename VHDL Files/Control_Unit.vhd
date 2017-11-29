----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/27/2017 07:46:26 PM
-- Design Name: 
-- Module Name: Control_Unit - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Control_Unit is
    Port ( 
           Opcode: in  STD_LOGIC_VECTOR(5 downto 0);
           Func : in  STD_LOGIC_VECTOR(5 downto 0);
           ALUOp: out STD_LOGIC_VECTOR(2 downto 0);
           RegDst : out  STD_LOGIC;
           ALUSrc : out  STD_LOGIC;
           PCSrc: out  STD_LOGIC;
           MemToReg : out  STD_LOGIC;
           RegWrite : out  STD_LOGIC;
           MemRead : out  STD_LOGIC;
           MemWrite : out  STD_LOGIC;
           ShiftLeft: out STD_LOGIC;
           ShiftRight: out STD_LOGIC;
           Jump : out STD_LOGIC;
           BranchNE : out STD_LOGIC;
           Branch : out  STD_LOGIC;
           BranchLT: out  STD_LOGIC;
           Halt: out STD_LOGIC
         );
end Control_Unit;
-- RType, ADDI,SUBI,ANDI,ORI,SHL,SHR,LW,SW,BLT,BEQ,BNE,JMP,HAL
architecture Behavioral of Control_Unit is
    SIGNAL RType: STD_LOGIC;
    SIGNAL ADDI: STD_LOGIC;
    SIGNAL SUBI: STD_LOGIC;
    SIGNAL ANDI: STD_LOGIC;
    SIGNAL ORI: STD_LOGIC;
    SIGNAL SHL: STD_LOGIC;
    SIGNAL SHR: STD_LOGIC;
    SIGNAL LW: STD_LOGIC;
    SIGNAL SW: STD_LOGIC;
    SIGNAL BLT: STD_LOGIC;
    SIGNAL BEQ: STD_LOGIC;
    SIGNAL BNE: STD_LOGIC;
    SIGNAL JMP: STD_LOGIC;
    SIGNAL HAL: STD_LOGIC;
    SIGNAL A: STD_LOGIC_VECTOR(2 downto 0);

begin
    A <= Func(2 downto 0);
    RType<='1' when Opcode = "000000" else '0';
    ADDI<='1' when Opcode = "000001" else '0';
    SUBI<='1' when Opcode = "000010" else '0';
    ANDI<='1' when Opcode = "000011" else '0';
    ORI<='1' when Opcode = "000100" else '0';
    SHL<='1' when Opcode = "000101" else '0';
    SHR<='1' when Opcode = "000110" else '0';
    LW<='1' when Opcode = "000111" else '0';
    SW<= '1' when Opcode = "001000" else '0';
    BLT<='1' When Opcode = "001001" else '0';
    BEQ<='1' when Opcode = "001010" else '0';
    BNE<='1' when Opcode = "001011" else '0';
    JMP<='1' when Opcode = "001100" else '0';
    HAL<='1' when Opcode = "111111" else '0';

    RegDst <= RType;
    ALUSrc<= ADDI OR SUBI or ANDI or ORI or LW or SW or SHL or SHR;
    PCSrc <= BLT OR BEQ OR BNE; 
    MemToReg<= LW;
    MemRead <= LW;
    MemWrite <= SW;
    RegWrite <= RType Or LW Or ADDI or SUBI or ANDI or ORI or SHL or SHR;     
    ShiftLeft <= SHL;
    ShiftRight <= SHR;
    Jump <= JMP;
    Branch <= BEQ;
    BranchLT <= BLT;
    BranchNE <= BNE;
    Halt <= HAL;
    
process(Opcode, A) 
begin          
    if(opcode="000000") then 
        if (A = "000")then
            ALUOp<="000";--add
        elsif (A = "001")then
            ALUOp<="001";--sub
        elsif(A = "010")then 
            ALUOp<="010";--and
        elsif(A = "011")then
            ALUOp<="011";--or
        elsif(A = "100")then
            ALUOp<="100";--nor
        else 
            ALUOp<="111";
        end if ;
    else 
        if(Opcode = "000001" or Opcode = "000111" or Opcode = "001000")then 
            ALUOp<="000"; --add
        elsif(Opcode = "000010" or Opcode = "001001" or Opcode = "001010" or Opcode = "001011")then
            ALUOp<= "001" ;--sub
        elsif(Opcode = "000011")then
            ALUOp<="010";--and
        elsif(Opcode = "000100")then
            ALUOp<="011";--or
        elsif(Opcode = "000101")then
            ALUOp<="101";--shl
        elsif(Opcode = "000110")then
            ALUOp<="110";--shr
        else 
            ALUOp<="111";
        end if;         
    end if;
end process;

end Behavioral;
