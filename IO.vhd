library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity IO is
port (
         clk : in std_logic;
         bcd_in : in std_logic_vector(3 downto 0);
			ans : out std_logic_vector(31 downto 0);
			sout : out std_logic;
			oflow: out std_logic
			);
end IO;





architecture Behavioral of IO is

----------------------------------------------------------------------------
component BCD_inout is
port (
clk: in std_logic;
a : in std_logic_vector(31 downto 0);
b : in std_logic_vector(31 downto 0);
sin1 : in std_logic ;
sin2 : in std_logic ;
op   : in std_logic_vector(1 downto 0);
bcdout : out std_logic_vector(31 downto 0);
sinout : out std_logic;
oflow : out std_logic
);

end component;
----------------------------------------------------------------------------------

component bin_inout is
port (
clk: in std_logic;
a : in std_logic_vector(31 downto 0);
b : in std_logic_vector(31 downto 0);
sin1 : in std_logic ;
sin2 : in std_logic ;
op   : in std_logic_vector(1 downto 0);
bcdout : out std_logic_vector(35 downto 0);
sinout : out std_logic
);

end component;

--------------------------------------------------------------------------------------


signal t1,t3,t4 :std_logic_vector(31 downto 0):="00000000000000000000000000000000";
signal s1,s2: std_logic;
signal op: std_logic_vector(1 downto 0);
signal pt : std_logic := '0';
signal c : std_logic := '0';
signal err : std_logic:='0';
signal i,i1,i2: integer:=0;
signal bin_out: std_logic_vector(35 downto 0);
signal bcd_out: std_logic_vector(31 downto 0);


begin

  process (clk)
   begin
	
	  	if bcd_in="0001" then
			
			t1(31 downto 4)<=t1(27 downto 0);
			t1( 3 downto 0)<=bcd_in;
			i1<=i1+1;
		elsif bcd_in="0010" then
			t1(31 downto 4)<=t1(27 downto 0);
			t1( 3 downto 0)<=bcd_in;
				i1<=i1+1;
		elsif bcd_in="0011" then
			t1(31 downto 4)<=t1(27 downto 0);
			t1( 3 downto 0)<=bcd_in;
				i1<=i1+1;
		elsif bcd_in="0100" then
			t1(31 downto 4)<=t1(27 downto 0);
			t1( 3 downto 0)<=bcd_in;
				i1<=i1+1;
		elsif bcd_in="0101" then
			t1(31 downto 4)<=t1(27 downto 0);
			t1( 3 downto 0)<=bcd_in;
				i1<=i1+1;
		elsif bcd_in="0110" then
			t1(31 downto 4)<=t1(27 downto 0);
			t1( 3 downto 0)<=bcd_in;
		      	i1<=i1+1;
		elsif bcd_in="0111" then
			t1(31 downto 4)<=t1(27 downto 0);
			t1( 3 downto 0)<=bcd_in;
		   	i1<=i1+1;
		elsif bcd_in="1000" then
		t1(31 downto 4)<=t1(27 downto 0);
			t1(3 downto 0)<=bcd_in;	
		  	i1<=i1+1;
		elsif bcd_in="1001" then
			t1(31 downto 4)<=t1(27 downto 0);
			t1( 3 downto 0)<=bcd_in;
		    	i1<=i1+1; 
		elsif bcd_in="0000" then
			t1(31 downto 4)<=t1(27 downto 0);
			t1( 3 downto 0)<=bcd_in;
			i1<=i1+1;
		elsif bcd_in="1010" then      --  + operator
			if i=0 then
	         s1<='0';
				i<=1;
			elsif i=1 then
			   op<="00";
				i<=2;
				t3<=t1; 
            t1<="00000000000000000000000000000000"; 
			elsif i=2 then 
				s2<='0';
			else 
			  err<='1';
			end if;
				i1<=i1+1;
				
		elsif bcd_in="1011" then             -- (- op)
		   if i=0 then
	         s1<='1';
				i<=1;
			elsif i=1 then
			   op<="01";
				i<=2;
				t3<=t1; 
            t1<="00000000000000000000000000000000"; 
			elsif i=2 then 
				s2<='1';
			else 
			  err<='1';
			end if;
			i1<=i1+1;
			
     elsif bcd_in="1011" then             -- (* op)
		   if i=1 then
			   op<="10";
				i<=2;
				t3<=t1; 
            t1<="00000000000000000000000000000000"; 
			else 
			  err<='1';
			end if;
				i1<=i1+1;
				
	  elsif bcd_in="1011" then             -- (/ op)
		   if i=1 then
			   op<="11";
				i<=2;
				t3<=t1; 
            t1<="00000000000000000000000000000000"; 
			else 
			  err<='1';
			end if;
			i1<=i1+1;
	
		
		end if;
	
     
	
--	if i2=1 then terminate; end if;
   end process;
	
	--f1: bcd_inout port map(clk,t3,t1,s1,s2,op,bcd_out,sout);
	f2: bin_inout port map(clk,t3,t1,s1,s2,op,bin_out,sout);
	ans<=bin_out(31 downto 0);
	
end Behavioral;



