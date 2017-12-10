----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/2/2017 01:15:00 PM
-- Design Name: 
-- Module Name: TestIO - Behavioral
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


LIBRARY IEEE, STD;
USE STD.TEXTIO.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE IEEE.STD_LOGIC_1164.ALL; 
use ieee.numeric_std.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY TestIO IS
   
END TestIO;
 
ARCHITECTURE Behavior OF TestIO IS 
component cpu
Port ( clk : in  STD_LOGIC;
       reset : in  STD_LOGIC;
		 sel: in std_logic;
		 skey: in std_logic_vector(127 downto 0);
		 din: in std_logic_vector(63 downto 0);
		 valid: in std_logic;
		 dout: out std_logic_vector(63 downto 0);
		 data_vld: out std_logic;
		 instruction : out std_logic_vector(31 downto 0));
end component;
   --Inputs
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';
--   signal ukey_vld : std_logic := '0';
   signal ukey : std_logic_vector(127 downto 0) := (others => '0');
--   signal Din_vld : std_logic := '0';
   signal Din : std_logic_vector(63 downto 0) := (others => '0');
   signal sel : std_logic := '0';
	signal valid : std_logic := '0';
 	--Outputs
   --signal Dout : std_logic_vector(63 downto 0);
--   signal do_rdy_dec : std_logic;
--   signal do_rdy_enc : std_logic;
	signal do_rdy: std_logic;
	signal instruction: std_logic_vector (31 downto 0);
	signal dout:  STD_LOGIC_VECTOR (63 downto 0);
   -- Clock period definitions
   constant clk_period : time := 10 ns;
   --signal dout_reg: std_logic_vector(63 downto 0);
--	signal dout_cc: std_logic_vector(63 downto 0);
   --shared Variable  Dout_C: std_logic_vector(63 downto 0);
BEGIN    

--dout_cc<=Dout_C;
--dout_reg<=dout;
--UUT: cpu PORT MAP(clr=>clr,clk=>clk,ukey_vld=>ukey_vld,ukey=>ukey,Din_vld=>Din_vld,Din=>Din,sel=>sel,dout=>dout,do_rdy_dec=>do_rdy_dec,do_rdy_enc=>do_rdy_enc);
uut: cpu PORT MAP(clk=>clk,reset=>reset,sel=>sel,skey=>ukey,din=>Din,valid=>valid,dout=>dout,data_vld=>do_rdy,instruction=>instruction);


	clk_process :process
begin
     clk <= '0';
     wait for clk_period/2;
	   
     clk <= '1';
     wait for clk_period/2;
	  
end process;
 
 ------ASSERT ENC-----------
-- PROCESS(do_rdy_enc)
-- begin
-- if (do_rdy_enc'EVENT AND do_rdy_enc='1')
-- then
-- assert(dout=Dout_C)
--    report"ENCRYPTION FAIL!"
--    severity ERROR;
-- 
---- Wait for clk_period*10;
---- sel<='1';
-- end if;
-- end process;
 -----sel update----
--  PROCESS(do_rdy_enc)
-- begin
-- if (do_rdy_enc'EVENT AND do_rdy_enc='1')
-- then
---- assert(dout=Dout_C)
----    report"ENCRYPTION FAIL!"
----    severity ERROR;
 
---- Wait for clk_period*10;
---- sel<='1';
-- end if;
-- end process;
 
 ------ASSERT DEC------
--  PROCESS(do_rdy_dec)
-- begin
-- if (do_rdy_dec'EVENT AND do_rdy_dec='1')
-- then
-- assert(dout=Din)
--    report"DECRYPTION FAIL!"
--    severity ERROR;
-- 
---- Wait for clk_period*10;
---- sel<='0';
-- end if;
-- end process;
 
 ---------sel update-------
--  PROCESS(do_rdy_dec)
-- begin
-- if (do_rdy_dec'EVENT AND do_rdy_dec='1')
-- then
---- assert(dout=Din)
----    report"DECRYPTION FAIL!"
----    severity ERROR;
 
---- Wait for clk_period*10;
-- sel<='1';

-- end if;
-- end process;
 
  PROCESS       
--    FILE ukeyfile : TEXT IS IN "D:\nyu\17fa\AVH\lab6\ukey.txt";
--    FILE Dinfile : TEXT IS IN "D:\nyu\17fa\AVH\lab6\Din.txt";
--    FILE Doutfile : TEXT IS IN "D:\nyu\17fa\AVH\lab6\Dout.txt";
	 FILE wholefile : TEXT ;--IS IN "D:\nyu\17fa\AVH\lab6\whole.txt";
	-- FILE VHDL_out : TEXT IS IN "D:\nyu\17fa\AVH\lab6\vhdl.txt";
    Variable ukey_line, Din_line,Dout_line,vhdl_line : LINE;  
	 Variable L: LINE;
    Variable key : STD_LOGIC_VECTOR(127 DOWNTO 0); 
    Variable Din_v : STD_LOGIC_VECTOR(63 DOWNTO 0); 
    Variable Dout_C : STD_LOGIC_VECTOR(63 DOWNTO 0); 
	 variable good: boolean; --status of the read operation
    --Variable data : STD_LOGIC_VECTOR(31 DOWNTO 0);
    --Variable expectedResult : STD_LOGIC_VECTOR(31 DOWNTO 0);
    --Variable ActualResult : STD_LOGIC_VECTOR(31 DOWNTO 0);     
  BEGIN    
--      ukey_vld<='1';
--      Din_vld<='1';
      reset<='1';  
    FILE_OPEN(wholefile,"D:\nyu\17fa\AVH\lab6\whole.txt",READ_MODE); 
--WHILE (NOT ENDFILE(ukeyfile) and NOT ENDFILE(Dinfile) and NOT ENDFILE(Doutfile) )
	 LOOP               
      -- read a line from the input file 
		
            if endfile(wholefile) then  -- Check EOF
                assert false
                    report "End of file encountered; exiting."
                    severity NOTE;
                exit;
            end if;		
--      READLINE( ukeyfile, ukey_line); 
--      READLINE( Dinfile, Din_line);  
--      READLINE( Doutfile, Dout_line);  
		READLINE(wholefile,L);
		
      -- read a value from the line            
--      HREAD( ukey_line, key,good); 
--		            assert good
--                report "Text I/O read error"
--                severity ERROR;
--      HREAD( Din_line, Din ,good); 
--      HREAD( Dout_line, Dout_C ,good); 
----
		HREAD(L,key,good);
				            assert good
                report "Text I/O read error"
                severity ERROR;
		HREAD(L,Din_v,good);
						            assert good
                report "Text I/O read error"
                severity ERROR;
		HREAD(L,Dout_C,good);
						            assert good
                report "Text I/O read error"
                severity ERROR;
      reset<='1';
		wait for clk_period;
		reset<='0';
      valid<='1';
      ukey<=key;
		Din<=Din_v;
      wait for clk_period*25000;	
		sel<='0';
--		IF( do_rdy_enc='1')then
			assert(dout= Dout_C)
				report "ENCRYPTION FAIL!"
					severity ERROR;
				assert(dout/= Dout_C)
				report "ENCRYPTION SUCCESS!"
					severity NOTE;
--					end if;
--		IF( do_rdy_dec='1')then
      wait for clk_period;
		
		sel<='1';
		wait for clk_period*2;
			assert(dout= Din)
				report "DECRYPTION FAIL"
					severity ERROR;
							assert(dout/= Din)
				report "DECRYPTION SUCCESS!"
					severity NOTE;
--					end if;
					
		
		wait for clk_period*10;
		reset<='1';
		sel<='0';
		wait for clk_period;
		valid<='0';
		wait for clk_period;
		reset<='0';
		wait for clk_period;
     -- HREAD( my_line, data );
     --HREAD( my_line, expectedResult );    
     -- ActualResult := key and data;
     -- IF(expectedResult = ActualResult) THEN HWRITE( out_line, ActualResult);
     -- END IF;         
      -- assert(c = d)
      --    report "Check Failed!"
      --        severity ERROR;
         
      -- write the result value to the line
      -- HWRITE( out_line, d);            
      -- write the line to the output files
     -- WRITELINE( outfile, out_line);        
    END LOOP; 
--	 wait;
	 
  END PROCESS; 
END Behavior;
