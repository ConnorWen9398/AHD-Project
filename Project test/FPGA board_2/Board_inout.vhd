----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:17:03 12/03/2017 
-- Design Name: 
-- Module Name:    Board_inout - Behavioral 
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
LIBRARY IEEE, STD;
USE STD.TEXTIO.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE IEEE.STD_LOGIC_1164.ALL; 
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Board_inout is
port(
      sw: in STD_LOGIC_VECTOR(15 downto 0);
      btnc,btnd,btnl,btnr,btnu,CLK: in STD_LOGIC;
		SSEG_AN : out STD_LOGIC_VECTOR (7 downto 0);
		SSEG_CA : out STD_LOGIC_VECTOR (7 downto 0);
		led: out STD_LOGIC_VECTOR (15 downto 0)
);
end Board_inout;

architecture Behavioral of Board_inout is

component Hex2LED --Converts a 4 bit hex value into the pattern to be displayed on the 7seg
port (CLK: in STD_LOGIC; X: in STD_LOGIC_VECTOR (4 downto 0); Y: out STD_LOGIC_VECTOR (7 downto 0)); 
end component; 

component cpu
		 Port ( 
		 clk : in  STD_LOGIC;
       reset : in  STD_LOGIC;
		 sel: in std_logic;
		 skey: in std_logic_vector(127 downto 0);
		 din: in std_logic_vector(63 downto 0);
		 valid: in std_logic;
		 dout: out std_logic_vector(63 downto 0);
		 data_vld: out std_logic;
		 instruction : out std_logic_vector(31 downto 0);
		 Rs : out STD_LOGIC_VECTOR(31 downto 0);
       Rt : out STD_LOGIC_VECTOR(31 downto 0);
       Rd : out STD_LOGIC_VECTOR(31 downto 0);
       Imm: out STD_LOGIC_VECTOR(15 downto 0);
       next_pc : out std_logic_vector(31 downto 0);
       ins_num:out integer
		 );
end component;

Signal instruction: STD_LOGIC_VECTOR(31 downto 0);
Signal Count: STD_LOGIC_VECTOR (3 downto 0):="0000";
Signal Din: STD_LOGIC_VECTOR (63 downto 0):=x"0000000000000000";
Signal Din_ini: STD_LOGIC_VECTOR (63 downto 0):=x"0000000000000000";
Signal Dout: STD_LOGIC_VECTOR (63 downto 0):=x"0000000000000000";
Signal Dout_reg_enc: STD_LOGIC_VECTOR (63 downto 0):=x"0000000000000000";
Signal Dout_reg_dec: STD_LOGIC_VECTOR (63 downto 0):=x"0000000000000000";
Signal DD: STD_LOGIC_VECTOR (63 downto 0):=x"0000000000000000";
Signal Ukey: STD_LOGIC_VECTOR (127 downto 0):=x"00000000000000000000000000000000";
Signal Ukey_ini: STD_LOGIC_VECTOR (127 downto 0):=x"00000000000000000000000000000000";
Signal ukey_vld: STD_LOGIC;
Signal Din_vld: STD_LOGIC;

Signal valid: STD_LOGIC;
Signal din_vld_in: STD_LOGIC;
Signal halt: STD_LOGIC;
Signal DEC: STD_LOGIC:='0';
Signal DEC_sel: STD_LOGIC:='0';
Signal U_in: STD_LOGIC;
Signal clr: STD_LOGIC;
Signal clr_lab: STD_LOGIC:='0';
Signal do_rdy_enc: STD_LOGIC;
Signal do_rdy_dec: STD_LOGIC;
signal do_rdy: STD_LOGIC;
Signal Display_flag: STD_LOGIC_VECTOR(3 downto 0):="0000";
Signal input_reg: STD_LOGIC_VECTOR(3 downto 0):="0000";
Signal ukey_reg: STD_LOGIC_VECTOR(3 downto 0):="0000";
Signal input_place: STD_LOGIC_VECTOR(4 downto 0):="00000";
Signal selector: STD_LOGIC_VECTOR(4 downto 0);
Signal trig:  STD_LOGIC_VECTOR(1 downto 0):="00";

--Signal wait_sig:  STD_LOGIC:='0';


--instruction
Signal Instr_reg: STD_LOGIC_VECTOR (31 downto 0);
Signal opcode: STD_LOGIC_VECTOR (5 downto 0);
Signal RS: STD_LOGIC_VECTOR (31 downto 0);
Signal RT: STD_LOGIC_VECTOR (31 downto 0);
Signal RD: STD_LOGIC_VECTOR (31 downto 0);
Signal IMM: STD_LOGIC_VECTOR (15 downto 0);

Signal ins_num: integer;
Signal instr_num: STD_LOGIC_VECTOR (31 downto 0);
Signal next_pc: STD_LOGIC_VECTOR (31 downto 0);
--Signal ADD: STD_LOGIC_VECTOR (31 downto 0);
Signal Funct: STD_LOGIC_VECTOR (5 downto 0);

-- clocks
Signal clk_human: STD_LOGIC;
Signal clk_func: STD_LOGIC;

--input pin
Signal mode_sel: STD_LOGIC;


--Sign extension
signal Sign_extended_operand: std_logic_vector(15 downto 0);
signal Sign_Extended : std_logic_vector(31 downto 0);

--Output signal
Signal Temp_1: STD_LOGIC_VECTOR (31 downto 0);
Signal Temp_2: STD_LOGIC_VECTOR (31 downto 0);
Signal Temp_3: STD_LOGIC_VECTOR (31 downto 0);
Signal Temp_4: STD_LOGIC_VECTOR (31 downto 0);

signal LED_0: STD_LOGIC_VECTOR(7 downto 0);
signal LED_1: STD_LOGIC_VECTOR(7 downto 0);
signal LED_2: STD_LOGIC_VECTOR(7 downto 0);
signal LED_3: STD_LOGIC_VECTOR(7 downto 0);
signal LED_4: STD_LOGIC_VECTOR(7 downto 0);
signal LED_5: STD_LOGIC_VECTOR(7 downto 0);
signal LED_6: STD_LOGIC_VECTOR(7 downto 0);
signal LED_7: STD_LOGIC_VECTOR(7 downto 0);
signal LED_8: STD_LOGIC_VECTOR(7 downto 0):="11111111";

signal HEX_L0: STD_LOGIC_VECTOR(4 downto 0);
signal HEX_L1: STD_LOGIC_VECTOR(4 downto 0);
signal HEX_L2: STD_LOGIC_VECTOR(4 downto 0);
signal HEX_L3: STD_LOGIC_VECTOR(4 downto 0);
signal HEX_L4: STD_LOGIC_VECTOR(4 downto 0);
signal HEX_L5: STD_LOGIC_VECTOR(4 downto 0);
signal HEX_L6: STD_LOGIC_VECTOR(4 downto 0);
signal HEX_L7: STD_LOGIC_VECTOR(4 downto 0);

signal Val : std_logic_vector(3 downto 0) := (others => '0');
signal slowCLK: std_logic:='0';
signal i_cnt: std_logic_vector(19 downto 0):=x"00000";
begin
----//// reset signal ////-----
clr<=NOT btnc;
clr_lab<=btnc;

----//// Single instruction mode ////------

mode_sel<=sw(0);----mode_sel=1 Single instruction mode
clk_human<=btnd;----hit for one cycle
---- 

--DEC_sel<=sw(3);----sw(3) =1 DEcode output
--ukey_vld<=sw(2);----sw(2)= 1 ukey input
--din_vld_in<=sw(1);------sw(1)=1 Din input
--valid<= Din_vld AND ukey_vld;

----//// input section ////------
valid<=sw(1);

U_in<=sw(2);---sw(4) =1 Ukey input

--ukey_reg<=sw(7 downto 4);
--input_reg<=sw(7 downto 4);

input_place<=sw(8 downto 4);




----//// output section ////-------
Display_flag<=sw(15 downto 13)& sw(0); --sw(15)=1 Left.  ----sw(14)=1 Dout  ---sw(13)=1 ukey in  ------sw(12,11)= which part of ukey 
DEC<=sw(3);

--with DEC_sel select
--Dout<=Dout_reg_dec when'1',
--	    Dout_reg_enc when'0';


with halt select
Din_vld<='0'    when'1',
			din_vld_in when '0';
------------------------------------


-----//// Input selector ////-------

--selector<= input_place & U_in;
selector<=input_place;

with selector select
Din<= Din_ini(63 downto 4) & input_reg  when "00000",
		Din_ini(63 downto 8) & input_reg & Din_ini(3 downto 0) when"00001",
		Din_ini(63 downto 12) & input_reg & Din_ini(7 downto 0) when"00010",
		Din_ini(63 downto 16) & input_reg & Din_ini(11 downto 0) when"00011",
		Din_ini(63 downto 20) & input_reg & Din_ini(15 downto 0) when"00100",
		Din_ini(63 downto 24) & input_reg & Din_ini(19 downto 0) when"00101",
		Din_ini(63 downto 28) & input_reg & Din_ini(23 downto 0) when"00110",
		Din_ini(63 downto 32) & input_reg & Din_ini(27 downto 0) when"00111",
		Din_ini(63 downto 36) & input_reg & Din_ini(31 downto 0) when"01000",
		Din_ini(63 downto 40) & input_reg & Din_ini(35 downto 0) when"01001",
		Din_ini(63 downto 44) & input_reg & Din_ini(39 downto 0) when"01010",
		Din_ini(63 downto 48) & input_reg & Din_ini(43 downto 0) when"01011",
		Din_ini(63 downto 52) & input_reg & Din_ini(47 downto 0) when"01100",
		Din_ini(63 downto 56) & input_reg & Din_ini(51 downto 0) when"01101",
		Din_ini(63 downto 60) & input_reg & Din_ini(55 downto 0) when"01110",
		input_reg & Din_ini(59 downto 0) when"01111",
		Din_ini when others;
		
with selector select
ukey<=Ukey_ini(127 downto 4) & ukey_reg  when "00000",
		Ukey_ini(127 downto 8) & ukey_reg & Ukey_ini(3 downto 0) when"00001",
		Ukey_ini(127 downto 12) & ukey_reg & Ukey_ini(7 downto 0) when"00010",
		Ukey_ini(127 downto 16) & ukey_reg & Ukey_ini(11 downto 0) when"00011",
		Ukey_ini(127 downto 20) & ukey_reg & Ukey_ini(15 downto 0) when"00100",
		Ukey_ini(127 downto 24) & ukey_reg & Ukey_ini(19 downto 0) when"00101",
		Ukey_ini(127 downto 28) & ukey_reg & Ukey_ini(23 downto 0) when"00110",
		Ukey_ini(127 downto 32) & ukey_reg & Ukey_ini(27 downto 0) when"00111",
		Ukey_ini(127 downto 36) & ukey_reg & Ukey_ini(31 downto 0) when"01000",
		Ukey_ini(127 downto 40) & ukey_reg & Ukey_ini(35 downto 0) when"01001",
		Ukey_ini(127 downto 44) & ukey_reg & Ukey_ini(39 downto 0) when"01010",
		Ukey_ini(127 downto 48) & ukey_reg & Ukey_ini(43 downto 0) when"01011",
		Ukey_ini(127 downto 52) & ukey_reg & Ukey_ini(47 downto 0) when"01100",
		Ukey_ini(127 downto 56) & ukey_reg & Ukey_ini(51 downto 0) when"01101",
		Ukey_ini(127 downto 60) & ukey_reg & Ukey_ini(55 downto 0) when"01110",
		Ukey_ini(127 downto 64) & ukey_reg & Ukey_ini(59 downto 0) when"01111",
		Ukey_ini(127 downto 68) & ukey_reg & Ukey_ini(63 downto 0) when"10000",
		Ukey_ini(127 downto 72) & ukey_reg & Ukey_ini(67 downto 0) when"10001",
		Ukey_ini(127 downto 76) & ukey_reg & Ukey_ini(71 downto 0) when"10010",
		Ukey_ini(127 downto 80) & ukey_reg & Ukey_ini(75 downto 0) when"10011",
		Ukey_ini(127 downto 84) & ukey_reg & Ukey_ini(79 downto 0) when"10100",
		Ukey_ini(127 downto 88) & ukey_reg & Ukey_ini(83 downto 0) when"10101",
		Ukey_ini(127 downto 92) & ukey_reg & Ukey_ini(87 downto 0) when"10110",
		Ukey_ini(127 downto 96) & ukey_reg & Ukey_ini(91 downto 0) when"10111",
		Ukey_ini(127 downto 100) & ukey_reg & Ukey_ini(95 downto 0) when"11000",
		Ukey_ini(127 downto 104) & ukey_reg & Ukey_ini(99 downto 0) when"11001",
		Ukey_ini(127 downto 108) & ukey_reg & Ukey_ini(103 downto 0) when"11010",
		Ukey_ini(127 downto 112) & ukey_reg & Ukey_ini(107 downto 0) when"11011",
		Ukey_ini(127 downto 116) & ukey_reg & Ukey_ini(111 downto 0) when"11100",
		Ukey_ini(127 downto 120) & ukey_reg & Ukey_ini(115 downto 0) when"11101",
		Ukey_ini(127 downto 124) & ukey_reg & Ukey_ini(119 downto 0) when"11110",		
		ukey_reg & Ukey_ini(123 downto 0) when"11111",
		Ukey_ini when others;
------------------------------------	


		
-----//// Input valid ///////-------------


--Ukey<=ukey_ini;
--Din<=Din_ini;

--with valid select
--Ukey<=ukey_ini(123 downto 0) & ukey_reg when'0',
--		ukey_ini when '1';
--		
--with valid select
--Din<=Din_ini(59 downto 0) & input_reg when'0',
--		Din_ini when '1';			
--with ukey_vld select
--Ukey<=ukey_ini(123 downto 0) & ukey_reg when'0',
--		ukey_ini when '1';
--		
--with Din_vld select
--Din<=Din_ini(59 downto 0) & input_reg when'0',
--		Din_ini when '1';

------------------------------------

		
-----////// DIGITAL LED output ////////------		
with Val select
	SSEG_AN <= "01111111" when "0000",
				  "10111111" when "0001",
				  "11011111" when "0010",
				  "11101111" when "0011",
				  "11110111" when "0100",
				  "11111011" when "0101",
				  "11111101" when "0110",
				  "11111110" when "0111",
				  "11111111" when others;


with Val select
	SSEG_CA <= LED_0 when "0000", --NAME contains the pattern for each hex value to be displayed.
				  LED_1 when "0001", --See below for the conversion
				  LED_2  when "0010",
				  LED_3  when "0011",
				  LED_4  when "0100",
				  LED_5  when "0101",
				  LED_6  when "0110",
				  LED_7  when "0111",
				  "11111111" when others;
				  
CONV1: Hex2LED port map (CLK => CLK, X => HEX_L0, Y => LED_0);
CONV2: Hex2LED port map (CLK => CLK, X => Hex_L1, Y => LED_1);
CONV3: Hex2LED port map (CLK => CLK, X => Hex_L2, Y => LED_2);
CONV4: Hex2LED port map (CLK => CLK, X => Hex_L3, Y => LED_3);		
CONV5: Hex2LED port map (CLK => CLK, X => Hex_L4, Y => LED_4);
CONV6: Hex2LED port map (CLK => CLK, X => Hex_L5, Y => LED_5);
CONV7: Hex2LED port map (CLK => CLK, X => Hex_L6, Y => LED_6);
CONV8: Hex2LED port map (CLK => CLK, X => Hex_L7, Y => LED_7);

COUNTER: process(clr,CLK)
 BEGIN
    IF(clr='0') THEN  Count<="0000";
    ELSIF(CLK'EVENT AND CLK='1') THEN
       
         IF(Count="0111") THEN   Count<="0000";
         ELSE   Count<=Count+"0001";
         END IF;
     
    END IF;
end process;
------------------------------------



-----///// DISPLAY selection /////------
With Display_flag select
HEX_L0 <='0' &   Dout(63 downto 60) when "1100",
         '0' &   Dout(31 downto 28) when "0100",
			'0' &   Din(63 downto 60)  when "1000",
			'0' &   Din(31 downto 28)  when "0000",
			'0' &   ukey(127 downto 124) when "1110",
			'0' &   ukey(95 downto 92) when "1010",
			'0' &   ukey(63 downto 60) when "0110",
			'0' &   ukey(31 downto 28) when "0010",
			'0' &   Instr_reg(31 downto 28)when "0001",
			'0' &   Temp_1(31 downto 28) when "0011",
			'0' &   Temp_2(31 downto 28) when "0101",
			'0' &   Temp_3(31 downto 28) when "0111",
			'0' &   Temp_4(31 downto 28) when "1001",
			'0' &   instr_num(31 downto 28) when"1011",
			'0' &   next_pc(31 downto 28) when"1101",
			 "11111" when others;
			 
With Display_flag select
HEX_L1 <='0' &   Dout(59 downto 56) when "1100",
         '0' &   Dout(27 downto 24) when "0100",
			'0' &   Din(59 downto 56)  when "1000",
			'0' &   Din(27 downto 24)  when "0000",
			'0' &   ukey(123 downto 120) when "1110",
			'0' &   ukey(91 downto 88) when "1010",
			'0' &   ukey(59 downto 56) when "0110",
			'0' &   ukey(27 downto 24) when "0010",
			'0' &   Instr_reg(27 downto 24)when "0001",
			'0' &   Temp_1(27 downto 24) when "0011",
			'0' &   Temp_2(27 downto 24) when "0101",
			'0' &   Temp_3(27 downto 24) when "0111",
			'0' &   Temp_4(27 downto 24) when "1001",
			'0' &   instr_num(27 downto 24) when"1011",
			'0' &   next_pc(27 downto 24) when"1101",
			 "11111" when others; 
			 
With Display_flag select
HEX_L2 <='0' &   Dout(55 downto 52) when "1100",
         '0' &   Dout(23 downto 20) when "0100",
			'0' &   Din(55 downto 52)  when "1000",
			'0' &   Din(23 downto 20)  when "0000",	
			'0' &   ukey(119 downto 116) when "1110",
			'0' &   ukey(87 downto 84) when "1010",
			'0' &   ukey(55 downto 52) when "0110",
			'0' &   ukey(23 downto 20) when "0010",
			'0' &   Instr_reg(23 downto 20)when "0001",
			'0' &   Temp_1(23 downto 20) when "0011",
			'0' &   Temp_2(23 downto 20) when "0101",
			'0' &   Temp_3(23 downto 20) when "0111",
			'0' &   Temp_4(23 downto 20) when "1001",
			'0' &   instr_num(23 downto 20) when"1011",
			'0' &   next_pc(23 downto 20) when"1101",
			 "11111" when others;  
			 
With Display_flag select
HEX_L3 <='0' &   Dout(51 downto 48) when "1100",
         '0' &   Dout(19 downto 16) when "0100",			 
			'0' &   Din(51 downto 48)  when "1000",
			'0' &   Din(19 downto 16)  when "0000",
			'0' &   ukey(115 downto 112) when "1110",
			'0' &   ukey(83 downto 80) when "1010",
			'0' &   ukey(51 downto 48) when "0110",
			'0' &   ukey(19 downto 16) when "0010",
			'0' &   Instr_reg(19 downto 16)when "0001",
			'0' &   Temp_1(19 downto 16) when "0011",
			'0' &   Temp_2(19 downto 16) when "0101",
			'0' &   Temp_3(19 downto 16) when "0111",
			'0' &   Temp_4(19 downto 16) when "1001",
			'0' &   instr_num(19 downto 16) when"1011",
			'0' &   next_pc(19 downto 16) when"1101",
			 "11111" when others;  
			 
With Display_flag select
HEX_L4 <='0' &   Dout(47 downto 44) when "1100",
         '0' &   Dout(15 downto 12) when "0100",	
			'0' &   Din(47 downto 44)  when "1000",
			'0' &   Din(15 downto 12)  when "0000",
			'0' &   ukey(111 downto 108) when "1110",
			'0' &   ukey(79 downto 76) when "1010",
			'0' &   ukey(47 downto 44) when "0110",
			'0' &   ukey(15 downto 12) when "0010",
			'0' &   Instr_reg(15 downto 12)when "0001",
			'0' &   Temp_1(15 downto 12) when "0011",
			'0' &   Temp_2(15 downto 12) when "0101",
			'0' &   Temp_3(15 downto 12) when "0111",
			'0' &   Temp_4(15 downto 12) when "1001",
			'0' &   instr_num(15 downto 12) when"1011",
			'0' &   next_pc(15 downto 12) when"1101",
			 "11111" when others;  
With Display_flag select
HEX_L5 <='0' &   Dout(43 downto 40) when "1100",
         '0' &   Dout(11 downto 8) when  "0100",
			'0' &   Din(43 downto 40)  when "1000",
			'0' &   Din(11 downto 8)  when  "0000",
			'0' &   ukey(107 downto 104) when "1110",
			'0' &   ukey(75 downto 72) when "1010",
			'0' &   ukey(43 downto 40) when "0110",
			'0' &   ukey(11 downto 8) when "0010",
			'0' &   Instr_reg(11 downto 8)when "0001",
			'0' &   Temp_1(11 downto 8) when "0011",
			'0' &   Temp_2(11 downto 8) when "0101",
			'0' &   Temp_3(11 downto 8) when "0111",
			'0' &   Temp_4(11 downto 8) when "1001",
			'0' &   instr_num(11 downto 8) when"1011",
			'0' &   next_pc(11 downto 8) when"1101",
			 "11111" when others;  
			 
With Display_flag select
HEX_L6 <='0' &   Dout(39 downto 36) when "1100",
         '0' &   Dout(7 downto 4) when   "0100",	
			'0' &   Din(39 downto 36)  when "1000",
			'0' &   Din(7 downto 4)  when   "0000",
			'0' &   ukey(103 downto 100) when "1110",
			'0' &   ukey(71 downto 68) when "1010",
			'0' &   ukey(39 downto 36) when "0110",
			'0' &   ukey(7 downto 4) when "0010",
			'0' &   Instr_reg(7 downto 4)when "0001",
			'0' &   Temp_1(7 downto 4) when "0011",
			'0' &   Temp_2(7 downto 4) when "0101",
			'0' &   Temp_3(7 downto 4) when "0111",
			'0' &   Temp_4(7 downto 4) when "1001",
			'0' &   instr_num(7 downto 4) when"1011",
			'0' &   next_pc(7 downto 4) when"1101",
			 "11111" when others;  
			 
With Display_flag select
HEX_L7 <='0' &   Dout(35 downto 32) when "1100",
         '0' &   Dout(3 downto 0) when   "0100",	
			'0' &   Din(35 downto 32)  when "1000",
			'0' &   Din(3 downto 0)  when   "0000",			 
			'0' &   ukey(99 downto 96) when "1110",
			'0' &   ukey(67 downto 64) when "1010",
			'0' &   ukey(35 downto 32) when "0110",
			'0' &   ukey(3 downto 0) when "0010",
			'0' &   Instr_reg(3 downto 0)when "0001",
			'0' &   Temp_1(3 downto 0) when "0011",
			'0' &   Temp_2(3 downto 0) when "0101",
			'0' &   Temp_3(3 downto 0) when "0111",
			'0' &   Temp_4(3 downto 0) when "1001",
			'0' &   instr_num(3 downto 0) when"1011",
			'0' &   next_pc(3 downto 0) when"1101",
			 "11111" when others;  
 
------------------------------------
----///// Single step LED /////-----

Temp_1<=Rs;
Temp_2<=Rt;
Temp_3<=Rd;



sign_extended_operand<=Imm(15 downto 0);
sign_extended<=std_logic_vector(resize(signed(sign_extended_operand), sign_extended'length));

Temp_4<=sign_extended;
------------------------------------
----///// SLOW clock /////----------
timer_inc_process : process (slowCLK)
begin
	if (rising_edge(slowCLK)) then
				if(Val="0111") then
				Val<="0000";
				else
				Val <= Val + '1'; --Val runs from 1,2,3,...8 on every rising edge of slowCLK
			end if;
		end if;
	--end if;
end process;
	
process(CLK)
begin
if (rising_edge(CLK)) then
if (i_cnt=x"0C350")then --Hex(0C350)=Dec(50,000)
slowCLK<=not slowCLK; --slowCLK toggles once after we see 100000 rising edges of CLK. 2 toggles is one period.
i_cnt<=x"00000";
else
i_cnt<=i_cnt+'1';
end if;
end if;
end process;

 
------------------------------------
------------------------------------------

----///// CPU PORT MAP ////-------

uut: cpu PORT MAP(clk=>clk_func,reset=>clr_lab,sel=>DEC,skey=>Ukey,din=>Din,valid=>valid,dout=>Dout,data_vld=>do_rdy,instruction=>instruction,Rs=>RS,Rd=>RD,Rt=>RT,Imm=>IMM,ins_num=>ins_num,next_pc=>next_pc);

--uut: lab5 port map(clr=>clr_lab,clk=>CLK,ukey_vld=>ukey_vld,ukey=>Ukey,Din_vld=>Din_vld,Din=>Din,sel=>DEC,dout=>DD,do_rdy_dec=>do_rdy_dec,do_rdy_enc=>do_rdy_enc);
 
------------------------------------

----//// choose mode //////-----
with mode_sel select
clk_func<=CLK when '0',
			 clk_human when '1';
 
------------------------------------




-----//// Process done FLAG /////--------

OUTFLAG: process(clr,do_rdy_dec,do_rdy_enc)
Begin
IF(clr='0') THEN  led(15 )<='0';
ELSIF(do_rdy'EVENT AND do_rdy='1') Then
led(15)<='1';
--ELSIF(do_rdy_enc'EVENT AND do_rdy_enc='1') Then
--led(14)<='1';
end if;
end process;
 
------------------------------------------

----//// Input Temporary bit counter ////----
Din_COUNTER: process(clr,btnr)
BEGIN
IF(clr='0') THEN input_reg<="0000";ukey_reg<="0000";
ELSIF (btnr'EVENT AND btnr='1') THEN
	If (U_in='0') then
      
         IF(input_reg="1111") THEN   input_reg<="0000";
         ELSE   input_reg<=input_reg+"0001";
         END IF;
     
    Else
	          IF(ukey_reg="1111") THEN   ukey_reg<="0000";
         ELSE   ukey_reg<=ukey_reg+"0001";
         END IF;
	 End if;
	 END IF;
end process;
------------------------------------------


------//// Input section ////--------
Din_MULTIPLIER: process(clr,sw(8))
BEGIN
IF(clr='0') THEN Din_ini<=x"0000000000000000";Ukey_ini<=x"00000000000000000000000000000000";
ELSIF (sw(10)'EVENT AND sw(10)='1') THEN
	
	If (U_in='0') then
      
--            Din_ini<=Din_ini(59 downto 0) & input_reg;
				
--				input_reg<="0000";
			Din_ini<=Din;
					
    Else 
--	      Ukey_ini<=Ukey_ini(123 downto 0) & ukey_reg;
				
--				ukey_reg<="0000";

			Ukey_ini<=ukey;
    END IF;
	 END IF;
end process;
---------------------------------------


------//// Instruction recognition////---

opcode<=Instr_reg(31 downto 26);
Funct<=Instr_reg(5 downto 0);

led(3 downto 0)<= opcode(3 downto 0);
led(6 downto 4)<= Funct(2 downto 0);


instr_num <= std_logic_vector(to_unsigned(ins_num,instr_num'length));
----------------------------------------


------//// Instruction register //////------
Instruction_register: process(instruction)
Begin

Instr_reg<=instruction;
end process;
----------------------------------------

--SAVE_out: process(CLK)
--BEGIN
--IF(clr='0') then halt<='0';
--
--elsIF(CLK'EVENT AND CLK='1')
--Then
--IF (halt='0') THen
--if (DEC='0') THEN
--Dout_reg_enc<=DD;
--else
--Dout_reg_dec<=DD;
--halt<='1';
--end if;
--end if;
--end if;
--
--end process;
--Haaaalt: process(do_rdy_dec,do_rdy_enc,clr,clk)
--Begin
--IF(clr='0') then trig<="00";
--ELSIF(clk'EVENT AND clk='0' AND do_rdy_dec='1') THEN
--        DEC<='1';
--		  trig<="11";
----		  Dout_reg_dec<=DD;
--ELSIF(clk'EVENT AND clk='0' AND do_rdy_enc='1') THEN
--        DEC<='0';
--		  trig<="10";
--		  
--		  
----		  Dout_reg_enc<=DD;
--		  END if;
--		 
--end process;

--
--HALT_FU: process(clk,clr)
--BEGIN
--IF(clr='0') then Dout_reg_dec<=x"0000000000000000";Dout_reg_enc<=x"0000000000000000"; halt<='0';
--ELSIF(clk'EVENT AND clk='1' AND trig="11") THEN
--Dout_reg_dec<=DD;
--
--ELSIF(clk'EVENT AND clk='1' AND trig="10")THEN
--Dout_reg_enc<=DD;
--halt<='1';
--
--END IF;
--END PROCESS;

--Wait_sigg: process(wait_sig,clr)
--BEGIN
--IF (clr='0') Then clr_lab<='1';
--ELSIF(wait_sig'EVENT AND wait_sig='1') THEN
--clr_lab<='0';
--END IF;
--END PROCESS;



--Halt2: process(do_rdy_enc)
--Begin
--IF(clr='0') then Dout_reg_enc<=x"0000000000000000";
--ELSIF(do_rdy_enc'EVENT AND do_rdy_enc='1') THEN
--        DEC<='0';
--		  Dout_reg_enc<=DD;
--		  END if;
--end process;
--
--LEFT_COUNTER: process(clr,)
--BEGIN
--IF(clr='0') THEN left<='0';
--ELSIF (btnl'EVENT AND btnl='1') THEN
--	
--       IF(state=ST_KEY_EXP) THEN
--         IF(left='1') THEN   left<='0';
--         ELSE   left<=left+'1';
--         END IF;
--       END IF;
--    
--	 END IF;
--end process;
--
--Din_COUNTER: process(clr,btnu)
--BEGIN
--IF(clr='0') THEN DIN_FLAG<='0';
--ELSIF (btnu'EVENT AND btnu='1') THEN
--	
--       IF(state=ST_KEY_EXP) THEN
--         IF(DIN_FLAG='1') THEN   DIN_FLAG<='0';
--         ELSE   DIN_FLAG<=DIN_FLAG+'1';
--         END IF;
--       END IF;
--    
--	 END IF;
--end process;

end Behavioral;

