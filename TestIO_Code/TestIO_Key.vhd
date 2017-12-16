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
		 dmem0: out std_logic_vector(31 downto 0);
		 dmem1: out std_logic_vector(31 downto 0);
		 dmem2: out std_logic_vector(31 downto 0); 
		 dmem3:out std_logic_vector(31 downto 0);
		 dmem4:out std_logic_vector(31 downto 0);
		 dmem5:out std_logic_vector(31 downto 0);
		 dmem6:out std_logic_vector(31 downto 0);
		 dmem7:out std_logic_vector(31 downto 0);
		 dmem8:out std_logic_vector(31 downto 0);
		 dmem9:out std_logic_vector(31 downto 0);
		 dmem10:out std_logic_vector(31 downto 0);
		 dmem11:out std_logic_vector(31 downto 0);
		 dmem12:out std_logic_vector(31 downto 0);
		 dmem13:out std_logic_vector(31 downto 0);
		 dmem14:out std_logic_vector(31 downto 0);
		 dmem15:out std_logic_vector(31 downto 0);
		 dmem16:out std_logic_vector(31 downto 0);
		 dmem17:out std_logic_vector(31 downto 0);
		 dmem18:out std_logic_vector(31 downto 0);
		 dmem19:out std_logic_vector(31 downto 0);
		 dmem20:out std_logic_vector(31 downto 0);
		 dmem21:out std_logic_vector(31 downto 0);
		 dmem22:out std_logic_vector(31 downto 0);
		 dmem23:out std_logic_vector(31 downto 0);
		 dmem24:out std_logic_vector(31 downto 0);
		 dmem25:out std_logic_vector(31 downto 0);
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
	signal dmem0:  STD_LOGIC_VECTOR (31 downto 0);
	signal dmem1:  STD_LOGIC_VECTOR (31 downto 0);
	signal dmem2:  STD_LOGIC_VECTOR (31 downto 0);
	signal dmem3:  STD_LOGIC_VECTOR (31 downto 0);
	signal dmem4:  STD_LOGIC_VECTOR (31 downto 0);
	signal dmem5:  STD_LOGIC_VECTOR (31 downto 0);
	signal dmem6:  STD_LOGIC_VECTOR (31 downto 0);
	signal dmem7:  STD_LOGIC_VECTOR (31 downto 0);
	signal dmem8:  STD_LOGIC_VECTOR (31 downto 0);
	signal dmem9:  STD_LOGIC_VECTOR (31 downto 0);
	signal dmem10:  STD_LOGIC_VECTOR (31 downto 0);
	signal dmem11:  STD_LOGIC_VECTOR (31 downto 0);
	signal dmem12:  STD_LOGIC_VECTOR (31 downto 0);
	signal dmem13:  STD_LOGIC_VECTOR (31 downto 0);
	signal dmem14:  STD_LOGIC_VECTOR (31 downto 0);
	signal dmem15:  STD_LOGIC_VECTOR (31 downto 0);
	signal dmem16:  STD_LOGIC_VECTOR (31 downto 0);
	signal dmem17:  STD_LOGIC_VECTOR (31 downto 0);
	signal dmem18:  STD_LOGIC_VECTOR (31 downto 0);
	signal dmem19:  STD_LOGIC_VECTOR (31 downto 0);
	signal dmem20:  STD_LOGIC_VECTOR (31 downto 0);
	signal dmem21:  STD_LOGIC_VECTOR (31 downto 0);
	signal dmem22:  STD_LOGIC_VECTOR (31 downto 0);
	signal dmem23:  STD_LOGIC_VECTOR (31 downto 0);
	signal dmem24:  STD_LOGIC_VECTOR (31 downto 0);
	signal dmem25:  STD_LOGIC_VECTOR (31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
   --signal dout_reg: std_logic_vector(63 downto 0);
--	signal dout_cc: std_logic_vector(63 downto 0);
   --shared Variable  Dout_C: std_logic_vector(63 downto 0);
BEGIN    

--dout_cc<=Dout_C;
--dout_reg<=dout;
--UUT: cpu PORT MAP(clr=>clr,clk=>clk,ukey_vld=>ukey_vld,ukey=>ukey,Din_vld=>Din_vld,Din=>Din,sel=>sel,dout=>dout,do_rdy_dec=>do_rdy_dec,do_rdy_enc=>do_rdy_enc);
uut: cpu PORT MAP(clk=>clk,reset=>reset,sel=>sel,skey=>ukey,din=>Din,valid=>valid,dout=>dout,data_vld=>do_rdy,instruction=>instruction,dmem0=>dmem0,dmem1=>dmem1,dmem2=>dmem2,dmem3=>dmem3,dmem4=>dmem4,dmem5=>dmem5,dmem6=>dmem6,dmem7=>dmem7,dmem8=>dmem8,dmem9=>dmem9,dmem10=>dmem10,dmem11=>dmem11,dmem12=>dmem12,dmem13=>dmem13,dmem14=>dmem14,dmem15=>dmem15,dmem16=>dmem16,dmem17=>dmem17,dmem18=>dmem18,dmem19=>dmem19,dmem20=>dmem20,dmem21=>dmem21,dmem22=>dmem22,dmem23=>dmem23,dmem24=>dmem24,dmem25=>dmem25);
din <= X"0000000000000000";

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
	 FILE KeyFile : TEXT ;--IS IN "D:\nyu\17fa\AVH\lab6\whole.txt";
	-- FILE VHDL_out : TEXT IS IN "D:\nyu\17fa\AVH\lab6\vhdl.txt";
    Variable ukey_line, Din_line,Dout_line,vhdl_line : LINE;  
	 Variable L: LINE;
    Variable key : STD_LOGIC_VECTOR(127 DOWNTO 0); 
    Variable Din_v : STD_LOGIC_VECTOR(127 DOWNTO 0); 
    Variable Dout_C1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    Variable Dout_C2 : STD_LOGIC_VECTOR(31 DOWNTO 0); 	
  	 Variable Dout_C3 : STD_LOGIC_VECTOR(31 DOWNTO 0); 
	 Variable Dout_C4 : STD_LOGIC_VECTOR(31 DOWNTO 0); 
	 Variable Dout_C5 : STD_LOGIC_VECTOR(31 DOWNTO 0); 
	 Variable Dout_C6 : STD_LOGIC_VECTOR(31 DOWNTO 0); 
	 Variable Dout_C7 : STD_LOGIC_VECTOR(31 DOWNTO 0); 
	 Variable Dout_C8 : STD_LOGIC_VECTOR(31 DOWNTO 0); 
	 Variable Dout_C9 : STD_LOGIC_VECTOR(31 DOWNTO 0); 
	 Variable Dout_C10 : STD_LOGIC_VECTOR(31 DOWNTO 0); 
	 Variable Dout_C11 : STD_LOGIC_VECTOR(31 DOWNTO 0); 
	 Variable Dout_C12 : STD_LOGIC_VECTOR(31 DOWNTO 0); 
	 Variable Dout_C13 : STD_LOGIC_VECTOR(31 DOWNTO 0); 
	 Variable Dout_C14 : STD_LOGIC_VECTOR(31 DOWNTO 0); 
	 Variable Dout_C15 : STD_LOGIC_VECTOR(31 DOWNTO 0); 
	 Variable Dout_C16 : STD_LOGIC_VECTOR(31 DOWNTO 0); 
	 Variable Dout_C17 : STD_LOGIC_VECTOR(31 DOWNTO 0); 
	 Variable Dout_C18 : STD_LOGIC_VECTOR(31 DOWNTO 0); 
	 Variable Dout_C19 : STD_LOGIC_VECTOR(31 DOWNTO 0); 
	 Variable Dout_C20 : STD_LOGIC_VECTOR(31 DOWNTO 0); 
	 Variable Dout_C21 : STD_LOGIC_VECTOR(31 DOWNTO 0); 
	 Variable Dout_C22 : STD_LOGIC_VECTOR(31 DOWNTO 0); 
	 Variable Dout_C23 : STD_LOGIC_VECTOR(31 DOWNTO 0); 
	 Variable Dout_C24 : STD_LOGIC_VECTOR(31 DOWNTO 0); 
	 Variable Dout_C25 : STD_LOGIC_VECTOR(31 DOWNTO 0); 
	 Variable Dout_C26 : STD_LOGIC_VECTOR(31 DOWNTO 0); 
	 
	 variable good: boolean; --status of the read operation
    --Variable data : STD_LOGIC_VECTOR(31 DOWNTO 0);
    --Variable expectedResult : STD_LOGIC_VECTOR(31 DOWNTO 0);
    --Variable ActualResult : STD_LOGIC_VECTOR(31 DOWNTO 0);     
  BEGIN    
--      ukey_vld<='1';
--      Din_vld<='1';
      reset<='1';  
    FILE_OPEN(KeyFile,"E:\Final_Project\RoundKey.txt",READ_MODE); 
 -- WHILE (NOT ENDFILE(ukeyfile) and NOT ENDFILE(Dinfile) and NOT ENDFILE(Doutfile) )
	 LOOP               
      -- read a line from the input file 
		
            if endfile(KeyFile) then  -- Check EOF
                assert false
                    report "End of file encountered; exiting."
                    severity NOTE;
                exit;
            end if;		
--      READLINE( ukeyfile, ukey_line); 
--      READLINE( Dinfile, Din_line);  
--      READLINE( Doutfile, Dout_line);  
		READLINE(KeyFile,L);
		
      -- read a value from the line            
--      HREAD( ukey_line, key,good); 
--		            assert good
--                report "Text I/O read error"
--                severity ERROR;
--      HREAD( Din_line, Din ,good); 
--      HREAD( Dout_line, Dout_C ,good); 
----
		HREAD(L,Din_v,good);
				            assert good
                report "Text I/O read error"
                severity ERROR;
		HREAD(L,Dout_C1,good);
						            assert good
                report "Text I/O read error"
                severity ERROR;
		HREAD(L,Dout_C2,good);
								assert good
			 report "Text I/O read error"
			 severity ERROR;
		HREAD(L,Dout_C3,good);
					assert good
			 report "Text I/O read error"
			severity ERROR;
		HREAD(L,Dout_C4,good);
					assert good
			report "Text I/O read error"
			severity ERROR;
		HREAD(L,Dout_C5,good);
					assert good
			report "Text I/O read error"
			severity ERROR;
		HREAD(L,Dout_C6,good);
					assert good
			report "Text I/O read error"
			severity ERROR;
		HREAD(L,Dout_C7,good);
					assert good
			report "Text I/O read error"
			severity ERROR;
		HREAD(L,Dout_C8,good);
					assert good
			report "Text I/O read error"
			severity ERROR;
		HREAD(L,Dout_C9,good);
					assert good
			report "Text I/O read error"
			severity ERROR;
		HREAD(L,Dout_C10,good);
					assert good
			report "Text I/O read error"
			severity ERROR;
		HREAD(L,Dout_C11,good);
					assert good
			report "Text I/O read error"
			severity ERROR;
		HREAD(L,Dout_C12,good);
					assert good
			report "Text I/O read error"
			severity ERROR;
		HREAD(L,Dout_C13,good);
					assert good
			report "Text I/O read error"
			severity ERROR;
		HREAD(L,Dout_C14,good);
					assert good
			report "Text I/O read error"
			severity ERROR;
		HREAD(L,Dout_C15,good);
					assert good
			report "Text I/O read error"
			severity ERROR;
		HREAD(L,Dout_C16,good);
					assert good
			report "Text I/O read error"
			severity ERROR;
		HREAD(L,Dout_C17,good);
					assert good
			report "Text I/O read error"
			severity ERROR;
		HREAD(L,Dout_C18,good);
					assert good
			report "Text I/O read error"
			severity ERROR;
		HREAD(L,Dout_C19,good);
					assert good
			report "Text I/O read error"
			severity ERROR;
		HREAD(L,Dout_C20,good);
					assert good
			report "Text I/O read error"
			severity ERROR;
		HREAD(L,Dout_C21,good);
					assert good
			report "Text I/O read error"
			severity ERROR;
		HREAD(L,Dout_C22,good);
					assert good
			report "Text I/O read error"
			severity ERROR;
		HREAD(L,Dout_C23,good);
					assert good
			report "Text I/O read error"
			severity ERROR;
		HREAD(L,Dout_C24,good);
					assert good
			report "Text I/O read error"
			severity ERROR;
		HREAD(L,Dout_C25,good);
					assert good
			report "Text I/O read error"
			severity ERROR;
		HREAD(L,Dout_C26,good);
					assert good
			report "Text I/O read error"
			severity ERROR;

      reset<='1';
		wait for clk_period;
		reset<='0';
      valid<='1';
		ukey<=Din_v;
      wait for clk_period*25000;	
		sel<='0';
--		IF( do_rdy_enc='1')then
			assert(dmem0 = Dout_C1)
				report "RoundKey FAIL!"
					severity ERROR;
				assert(dmem0/= Dout_C1)
				report "RoundKey SUCCESS!"
					severity NOTE;
			assert(dmem1 = Dout_C2)
				report "RoundKey FAIL!"
					severity ERROR;
				assert(dmem1/= Dout_C2)
				report "RoundKey SUCCESS!"
					severity NOTE;
			assert(dmem2 = Dout_C3)
				report "RoundKey FAIL!"
					severity ERROR;
				assert(dmem2/= Dout_C3)
				report "RoundKey SUCCESS!"
					severity NOTE;
			assert(dmem3 = Dout_C4)
				report "RoundKey FAIL!"
				severity ERROR;
				assert(dmem3/= Dout_C4)
				report "RoundKey SUCCESS!"
				severity NOTE;
			assert(dmem4 = Dout_C5)
				report "RoundKey FAIL!"
				severity ERROR;
				assert(dmem4/= Dout_C5)
				report "RoundKey SUCCESS!"
				severity NOTE;
			assert(dmem5 = Dout_C6)
				report "RoundKey FAIL!"
				severity ERROR;
				assert(dmem5/= Dout_C6)
				report "RoundKey SUCCESS!"
				severity NOTE;
			assert(dmem6 = Dout_C7)
				report "RoundKey FAIL!"
				severity ERROR;
				assert(dmem6/= Dout_C7)
				report "RoundKey SUCCESS!"
				severity NOTE;
			assert(dmem7 = Dout_C8)
				report "RoundKey FAIL!"
				severity ERROR;
				assert(dmem7/= Dout_C8)
				report "RoundKey SUCCESS!"
				severity NOTE;
			assert(dmem8 = Dout_C9)
				report "RoundKey FAIL!"
				severity ERROR;
				assert(dmem8/= Dout_C9)
				report "RoundKey SUCCESS!"
				severity NOTE;
			assert(dmem9 = Dout_C10)
				report "RoundKey FAIL!"
				severity ERROR;
				assert(dmem9/= Dout_C10)
				report "RoundKey SUCCESS!"
				severity NOTE;
			assert(dmem10 = Dout_C11)
				report "RoundKey FAIL!"
				severity ERROR;
				assert(dmem10/= Dout_C11)
				report "RoundKey SUCCESS!"
				severity NOTE;
			assert(dmem11 = Dout_C12)
				report "RoundKey FAIL!"
				severity ERROR;
				assert(dmem11/= Dout_C12)
				report "RoundKey SUCCESS!"
				severity NOTE;
			assert(dmem12 = Dout_C13)
				report "RoundKey FAIL!"
				severity ERROR;
				assert(dmem12/= Dout_C13)
				report "RoundKey SUCCESS!"
				severity NOTE;
			assert(dmem13 = Dout_C14)
				report "RoundKey FAIL!"
				severity ERROR;
				assert(dmem13/= Dout_C14)
				report "RoundKey SUCCESS!"
				severity NOTE;
			assert(dmem14 = Dout_C15)
				report "RoundKey FAIL!"
				severity ERROR;
				assert(dmem14/= Dout_C15)
				report "RoundKey SUCCESS!"
				severity NOTE;
			assert(dmem15 = Dout_C16)
				report "RoundKey FAIL!"
				severity ERROR;
				assert(dmem15/= Dout_C16)
				report "RoundKey SUCCESS!"
				severity NOTE;
			assert(dmem16 = Dout_C17)
				report "RoundKey FAIL!"
				severity ERROR;
				assert(dmem16/= Dout_C17)
				report "RoundKey SUCCESS!"
				severity NOTE;
			assert(dmem17 = Dout_C18)
				report "RoundKey FAIL!"
				severity ERROR;
				assert(dmem17/= Dout_C18)
				report "RoundKey SUCCESS!"
				severity NOTE;
			assert(dmem18 = Dout_C19)
				report "RoundKey FAIL!"
				severity ERROR;
				assert(dmem18/= Dout_C19)
				report "RoundKey SUCCESS!"
				severity NOTE;
			assert(dmem19 = Dout_C20)
				report "RoundKey FAIL!"
				severity ERROR;
				assert(dmem19/= Dout_C20)
				report "RoundKey SUCCESS!"
				severity NOTE;
			assert(dmem20 = Dout_C21)
				report "RoundKey FAIL!"
				severity ERROR;
				assert(dmem20/= Dout_C21)
				report "RoundKey SUCCESS!"
				severity NOTE;
			assert(dmem21 = Dout_C22)
				report "RoundKey FAIL!"
				severity ERROR;
				assert(dmem21/= Dout_C22)
				report "RoundKey SUCCESS!"
				severity NOTE;
			assert(dmem22 = Dout_C23)
				report "RoundKey FAIL!"
				severity ERROR;
				assert(dmem22/= Dout_C23)
				report "RoundKey SUCCESS!"
				severity NOTE;
			assert(dmem23 = Dout_C24)
				report "RoundKey FAIL!"
				severity ERROR;
				assert(dmem23/= Dout_C24)
				report "RoundKey SUCCESS!"
				severity NOTE;
			assert(dmem24 = Dout_C25)
				report "RoundKey FAIL!"
				severity ERROR;
				assert(dmem24/= Dout_C25)
				report "RoundKey SUCCESS!"
				severity NOTE;
			assert(dmem25 = Dout_C26)
				report "RoundKey FAIL!"
				severity ERROR;
				assert(dmem25/= Dout_C26)
				report "RoundKey SUCCESS!"
				severity NOTE;

					
--					end if;
--		IF( do_rdy_dec='1')then
--      wait for clk_period;
		
--		sel<='1';
--		wait for clk_period*2;
--			assert(dout= Din)
--				report "DECRYPTION FAIL"
--					severity ERROR;
--							assert(dout/= Din)
--				report "DECRYPTION SUCCESS!"
--					severity NOTE;
--					end if;
					
		
--		wait for clk_period*10;
--		reset<='1';
--		sel<='0';
--		wait for clk_period;
--		valid<='0';
--		wait for clk_period;
--		reset<='0';
--		wait for clk_period;
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
