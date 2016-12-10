----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:05:22 10/20/2016 
-- Design Name: 
-- Module Name:    project1 - Behavioral 
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
--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity project1 is
port(

clk: in std_logic;

up: in std_logic;--N4
enter: in std_logic;--F5
down: in std_logic;--P3
right: in std_logic;--F6
reset: in std_logic;--P4
display: inout STD_LOGIC;

p: inout STD_LOGIC;

upline: out STD_LOGIC_VECTOR(127 downto 0);
downline: out STD_LOGIC_VECTOR(127 downto 0);
ver: out STD_LOGIC_VECTOR(1 to 5)
);

end project1;

--mode=1 'Auto mode'
--mode=2 'Higher denomination'


--currency=1 'Rupee'
--currency=2 'Euro'
--currency=3 'Dollar'
--currency=4 'Yen'
--currency=5 'Pound'

architecture Behavioral of project1 is	

TYPE	state_type IS	(S1,S2,S3,S4,S5);	
signal state:state_type:=S1;

signal mode:integer:=1; 
signal inputcurrency:integer:=1; 
signal outputcurrency:integer:=1; 

type arr is array (1 to 6) of integer;
type int_2darray is array (1 to 5) of arr;

----Rupee(1000,500,100,50,10,1)
--signal Rupee:int_array:=(20,20,20,20,20,20);
----Euro(100,50,20,10,5,1)
--signal Euro:int_array:=(20,20,20,20,20,20);
----Dollar(100,50,20,10,5,1)
--signal Dollar:int_array:=(20,20,20,20,20,20);
----Yen(1000,500,100,50,10,1)
--signal Yen:int_array:=(20,20,20,20,20,20);
----Pound(100,50,20,10,5,1)
--signal Pound:int_array:=(20,20,20,20,20,20);

--first is currency and second is denomination

--1,2,3,4,5
--Rupee,Euro,Dollar,Yen,Pound
signal den:int_2darray:=((20,20,20,20,20,20),(20,20,20,20,20,20),(20,20,20,20,20,20),(20,20,20,20,20,20),(20,20,20,20,20,20));
signal valden:int_2darray:=((1000,500,100,50,10,1),(100,50,20,10,5,1),(100,50,20,10,5,1),(1000,500,100,50,10,1),(100,50,20,10,5,1));


type ans_array is array (1 to 6) of integer;
signal ans:ans_array:=(4,10,0,9,3,0);

--signal u:STD_LOGIC_VECTOR:=(0,0,0,0,0,0);


signal temp,num,i,c:integer:=0; 
signal index:integer:=1; 
type amt_array is array (1 to 4) of integer;
signal amt:amt_array:=(Others=>0);
signal amount:integer:=0; 
signal amountout:integer:=0; 

--type amtout_array is array (0 to 6) of integer;
--signal amountout:amtout_array:=(0,0,0,0,0,0); 

type t_array is array (1 to 6) of integer;
signal t:t_array; 

--signal p:bit;

--type yy is array (1 to 2) of integer;
--type yyy is array (6 downto 1) of yy;
--type exarr is array (6 downto 1) of yyy;

signal REnum:integer:=16;
signal REden:integer:=1024;

signal RDnum:integer:=1;
signal RDden:integer:=64;

signal RYnum:integer:=2;
signal RYden:integer:=1;

signal RPnum:integer:=16;
signal RPden:integer:=1024;

signal count:integer:=0;

signal done:std_logic:='0';
signal zero:STD_LOGIC_VECTOR (7 downto 0):="00110000";

signal outputstring1: string(1 to 32);

--architecture till here

signal A_j:STD_LOGIC_VECTOR (7 downto 0):="01000001";
signal B_j:STD_LOGIC_VECTOR (7 downto 0):="01000010";
signal C_j:STD_LOGIC_VECTOR (7 downto 0):="01000011";
signal D_j:STD_LOGIC_VECTOR (7 downto 0):="01000100";
signal E_j:STD_LOGIC_VECTOR (7 downto 0):="01000101";
signal F_j:STD_LOGIC_VECTOR (7 downto 0):="01000110";
signal G_j:STD_LOGIC_VECTOR (7 downto 0):="01000111";
signal H_j:STD_LOGIC_VECTOR (7 downto 0):="01001000";
signal I_j:STD_LOGIC_VECTOR (7 downto 0):="01001001";
signal J_j:STD_LOGIC_VECTOR (7 downto 0):="01001010";
signal K_j:STD_LOGIC_VECTOR (7 downto 0):="01001011";
signal L_j:STD_LOGIC_VECTOR (7 downto 0):="01001100";
signal M_j:STD_LOGIC_VECTOR (7 downto 0):="01001101";
signal N_j:STD_LOGIC_VECTOR (7 downto 0):="01001110";
signal O_j:STD_LOGIC_VECTOR (7 downto 0):="01001111";
signal P_j:STD_LOGIC_VECTOR (7 downto 0):="01010000";
signal Q_j:STD_LOGIC_VECTOR (7 downto 0):="01010001";
signal R_j:STD_LOGIC_VECTOR (7 downto 0):="01010010";
signal S_j:STD_LOGIC_VECTOR (7 downto 0):="01010011";
signal T_j:STD_LOGIC_VECTOR (7 downto 0):="01010100";
signal U_j:STD_LOGIC_VECTOR (7 downto 0):="01010101";
signal V_j:STD_LOGIC_VECTOR (7 downto 0):="01010110";
signal W_j:STD_LOGIC_VECTOR (7 downto 0):="01010111";
signal X_j:STD_LOGIC_VECTOR (7 downto 0):="01011000";
signal Y_j:STD_LOGIC_VECTOR (7 downto 0):="01011001";
signal Z_j:STD_LOGIC_VECTOR (7 downto 0):="01011010";

signal a_i:STD_LOGIC_VECTOR (7 downto 0):="01100001";
signal b_i:STD_LOGIC_VECTOR (7 downto 0):="01100010";
signal c_i:STD_LOGIC_VECTOR (7 downto 0):="01100011";
signal d_i:STD_LOGIC_VECTOR (7 downto 0):="01100100";--01101110
signal e_i:STD_LOGIC_VECTOR (7 downto 0):=X"65";
signal f_i:STD_LOGIC_VECTOR (7 downto 0):="01100110";
signal g_i:STD_LOGIC_VECTOR (7 downto 0):="01100111";
signal h_i:STD_LOGIC_VECTOR (7 downto 0):="01101000";
signal i_i:STD_LOGIC_VECTOR (7 downto 0):="01101001";
signal j_i:STD_LOGIC_VECTOR (7 downto 0):="01101010";
signal k_i:STD_LOGIC_VECTOR (7 downto 0):="01101011";
signal l_i:STD_LOGIC_VECTOR (7 downto 0):="01101100";
signal m_i:STD_LOGIC_VECTOR (7 downto 0):="01101101";
signal n_i:STD_LOGIC_VECTOR (7 downto 0):=X"6E";--01100100
signal o_i:STD_LOGIC_VECTOR (7 downto 0):="01101111";
signal p_i:STD_LOGIC_VECTOR (7 downto 0):="01110000";
signal q_i:STD_LOGIC_VECTOR (7 downto 0):="01110001";
signal r_i:STD_LOGIC_VECTOR (7 downto 0):="01110010";
signal s_i:STD_LOGIC_VECTOR (7 downto 0):="01110011";
signal t_i:STD_LOGIC_VECTOR (7 downto 0):="01110100";
signal u_i:STD_LOGIC_VECTOR (7 downto 0):="01110101";
signal v_i:STD_LOGIC_VECTOR (7 downto 0):="01110110";
signal w_i:STD_LOGIC_VECTOR (7 downto 0):="01110111";
signal x_i:STD_LOGIC_VECTOR (7 downto 0):="01111000";
signal y_i:STD_LOGIC_VECTOR (7 downto 0):="01111001";
signal z_i:STD_LOGIC_VECTOR (7 downto 0):="01111010";

signal zerodis:STD_LOGIC_VECTOR (7 downto 0):="00110000";
signal onedis:STD_LOGIC_VECTOR (7 downto 0):="00110001";
signal twodis:STD_LOGIC_VECTOR (7 downto 0):="00110010";

signal enterdis:STD_LOGIC_VECTOR (39 downto 0);
signal outputdis:STD_LOGIC_VECTOR (47 downto 0);


signal colon:STD_LOGIC_VECTOR (7 downto 0):="00111010";
signal dollar:STD_LOGIC_VECTOR (7 downto 0):="00100100";
signal space:STD_LOGIC_VECTOR (7 downto 0):=X"20";

signal a2:STD_LOGIC_VECTOR (7 downto 0);
signal a1:STD_LOGIC_VECTOR (7 downto 0);
signal b2:STD_LOGIC_VECTOR (7 downto 0);
signal b1:STD_LOGIC_VECTOR (7 downto 0);
signal c2:STD_LOGIC_VECTOR (7 downto 0);
signal c1:STD_LOGIC_VECTOR (7 downto 0);
signal d2:STD_LOGIC_VECTOR (7 downto 0);
signal d1:STD_LOGIC_VECTOR (7 downto 0);
signal e2:STD_LOGIC_VECTOR (7 downto 0);
signal e1:STD_LOGIC_VECTOR (7 downto 0);
signal f2:STD_LOGIC_VECTOR (7 downto 0);
signal f1:STD_LOGIC_VECTOR (7 downto 0);


begin


enterdis<=E_j & n_i & t_i & e_i & r_i;
outputdis<=O_j & u_i & t_i & p_i & u_i & t_i;

p<=done;


--(1) numerator
--(2) denominator

--process(enter)
--begin
--exfactor(1)(1)(1)<=1;
--exfactor(1)(1)(2)<=1;
--
--exfactor(1)(2)(1)<=14;
--exfactor(1)(2)(2)<=1000;
--
--exfactor(1)(3)(1)<=1;
--exfactor(1)(3)(2)<=67;
--
--exfactor(1)(4)(1)<=155;
--exfactor(1)(4)(2)<=100;
--
--exfactor(1)(5)(1)<=12;
--exfactor(1)(5)(2)<=1000;
--
--
--exfactor(2)(1)(1)<=1000;
--exfactor(2)(1)(2)<=14;
--
--exfactor(3)(1)(1)<=67;
--exfactor(3)(1)(2)<=1;
--
--exfactor(4)(1)(1)<=100;
--exfactor(4)(1)(2)<=155;
--
--exfactor(5)(1)(1)<=1000;
--exfactor(5)(1)(2)<=12;
--end process;


process(up,down) 
begin

if(up='1' and down='0' and up'event)then
if(state=S1) then
mode<=mode+1;
	if(mode=3) then
	mode<=1;
	end if;

elsif(state=S2) then
inputcurrency<=inputcurrency+1;
if(inputcurrency=6) then
inputcurrency<=1;
end if;

elsif(state=S3) then
amt(index)<=amt(index)+1;
if(amt(index)=10) then
amt(index)<=0;
end if;

elsif(state=S4) then
outputcurrency<=outputcurrency+1;
if(outputcurrency=6) then
outputcurrency<=1;
end if;

end if;
--end if;
elsif(down='1' and up='0' and down'event)then

if(state=S1) then
mode<=mode-1;
if(mode=0) then
mode<=2;
end if;

elsif(state=S2) then
inputcurrency<=inputcurrency-1;
if(inputcurrency=0) then
inputcurrency<=5;
end if;

elsif(state=S3) then
amt(index)<=amt(index)-1;
if(amt(index)=-1) then
amt(index)<=9;
end if;

elsif(state=S4) then
outputcurrency<=outputcurrency-1;
if(outputcurrency=0) then
outputcurrency<=5;
end if;

end if;

end if;

if(inputcurrency/=1)then
	outputcurrency<=1;
end if;

end process;

--
--process(right,reset)
--begin
--
--if(reset='1' and state/=S3 and reset'event)then
--index<=1;
--elsif(right='1' and state=S3 and right'event)then
--index<=index+1;
--
--	if(index=5)then
--	index<=4;
--	end if;
--
--end if;
--
--end process;





process(enter,reset,right)
begin

if(reset='1' and enter='0') then --reset everything to initial state
--amount<=0;
--amt<=(Others=>0);
--done<='0';
state<=S1;
elsif(right='1' and state=S3 and right'event)then
index<=index+1;

	if(index=5)then
	index<=4;
	end if;

elsif(enter='1' and reset='0' and enter'event) then

	if(state=S1) then state<=S2;--amt<=(Others=>0);done<='0';
	elsif(state=S2) then state<=S3;
	elsif(state=S3) then if(inputcurrency/=1)then state<=S5;else state<=S4;end if;
	elsif(state=S4) then state<=S5;--p<=not p;
	elsif(state=S5) then state<=S5;
	end if;

end if;

end process;



process(clk) --Do computation
begin

--ans<=(Others=>0);
--if(state=S1)then
--done<='0';
--end if;
--convert from amt(1 to index) to amount
if(clk='1' and clk'event and state=S5 and done='0')then

temp<=1;
amount<=0;
for i in 4 downto 1 loop
	if(i<=index)then
	amount<=amount+amt(i)*temp;
	temp<=temp*10;
	end if;
end loop;


--convert the amount from input currency(amount) to output currency(amountout)
if(inputcurrency=1) then

	if(outputcurrency=1) then
	amountout<=amount;
	elsif(outputcurrency=2) then
	amountout<=amount*REnum;
	amountout<=amountout/REden;
	elsif(outputcurrency=3) then
	amountout<=amount*RDnum;
	amountout<=amountout/RDden;
	elsif(outputcurrency=4) then
	amountout<=amount*RYnum;
	amountout<=amountout/RYden;
	elsif(outputcurrency=5) then
	amountout<=amount*RPnum;
	amountout<=amountout/RPden;
	end if;

elsif(inputcurrency=2) then
	amountout<=amount*REden;
	amountout<=amountout/REnum;

elsif(inputcurrency=3) then
	amountout<=amount*RDden;
	amountout<=amountout/RDnum;

elsif(inputcurrency=4) then
	amountout<=amount*RYden;
	amountout<=amountout/RYnum;

elsif(inputcurrency=5) then
	amountout<=amount*RPden;
	amountout<=amountout/RPnum;

end if;



-- !! money has to be generated in outputcurrency


	for i in 1 to 6 loop-- 1 to 6 is from higher denomination to lower denomination
		for c in 21 to 1 loop
			
			if(c<=den(outputcurrency)(i) and amountout>0)then
			temp<=c*valden(outputcurrency)(i);
			
				if(temp<=amountout)then
				amountout<=amountout-temp; 
				den(outputcurrency)(i)<=den(outputcurrency)(i)-c;
				ans(i)<=c;
				end if;
			
			end if;
			
		end loop;
	end loop;
	
--end if;

done<='1';

end if;
end process;



PROCESS(clk)
begin
if(state=S1)then
ver<="10000";
elsif(state=S2)then
ver<="01000";
elsif(state=S3)then
ver<="00100";
elsif(state=S4)then
ver<="00010";
elsif(state=S5)then
ver<="00001";
end if;

end process;



--handles the lcd output

--process(clock)
--begin
--CASE	state	IS	
--		WHEN	S1	=>	
--								IF	(mode=1)	   THEN	outputstring1<= "Enter Mode:     Auto Mode       ";	
--								ELSIF	(mode=2)	THEN	outputstring1<= "Enter Mode:     Higher Denominat";	
--								END	IF;	
--		WHEN	S2	=>	
--								IF	(inputcurrency=1)	   THEN	outputstring1<= "Enter Inputcurrency: Rupee             ";	
--								ELSIF	(inputcurrency=2)	THEN	outputstring1<= "Enter Inputcurrency: Euro";	
--								ELSIF	(inputcurrency=3)	THEN	outputstring1<= "Enter Inputcurrency: Dollar";
--								ELSIF	(inputcurrency=4)	THEN	outputstring1<= "Enter Inputcurrency: Yen";
--								ELSIF	(inputcurrency=5)	THEN	outputstring1<= "Enter Inputcurrency: Pound";
--								END	IF;
--		WHEN	S3	=>	
--								outputstring1<="Enter Amount: amt(1)amt(2)....amt(index)";	
--		WHEN	S4	=>	
--								
--								IF	(outputcurrency=1)	   THEN	outputstring<="Enter outputcurrency: Rupee";	
--								ELSIF	(outputcurrency=2)	THEN	outputstring<="Enter outputcurrency: Euro";	
--								ELSIF	(outputcurrency=3)	THEN	outputstring<="Enter outputcurrency: Dollar";
--								ELSIF	(outputcurrency=4)	THEN	outputstring<="Enter outputcurrency: Yen";
--								ELSIF	(outputcurrency=5)	THEN	outputstring<="Enter outputcurrency: Pound";
--								END	IF;
--		WHEN	S5	=>	
--								IF	(outputcurrency=1)	   THEN	outputstring<="amountout R 1:ans[1] 10:ans[2] 50:ans[3] 100:ans[4] 500:ans[5] 1000:ans[6]";	
--								ELSIF	(outputcurrency=2)	THEN	outputstring<="amountout € 1:ans[1] 5:ans[2] 10:ans[3] 20:ans[4] 50:ans[5] 100:ans[6]";	
--								ELSIF	(outputcurrency=3)	THEN	outputstring<="amountout $ 1:ans[1] 5:ans[2] 10:ans[3] 20:ans[4] 50:ans[5] 100:ans[6]";
--								ELSIF	(outputcurrency=4)	THEN	outputstring<="amountout ¥ 1:ans[1] 10:ans[2] 50:ans[3] 100:ans[4] 500:ans[5] 1000:ans[6]";
--								ELSIF	(outputcurrency=5)	THEN	outputstring<="amountout £ 1:ans[1] 5:ans[2] 10:ans[3] 20:ans[4] 50:ans[5] 100:ans[6]";
--								END	IF;	
--								every ans[i] will have two digits, if single digit pad zero
--END	CASE;	
--
--end process;


--process(clock)
--begin
--
--
--if(clock='1' and clock'event)then
--
--count<=count+1;
--if(count<100000)then
--display<='0';	
--elsif(count=100000)then
--display<='1';
--elsif(count=100001)then
--display<='0';
--count<=0;
--end if;
--end if;
--
--end process;

--process(clk)
--begin
--upline<=E_j & n_i & t_i & e_i & r_i & space & M_j & o_i & d_i & e_i & colon & space & space & space & space & colon;
--downline<=A_j & u_i & dollar & o_i & colon & M_j & o_i & d_i & e_i & dollar & dollar & dollar & dollar & dollar & dollar & dollar;
--end process;	
	
process(clk)
begin

if(clk='1' and clk'event)then


--count<=count+1;
--
--if(count<50)then
--display<='0';	
--elsif(count>=50)then
--display<='1';
--elsif(count=100)then
--display<='1';
--count<=0;
--end if;

---if(count=50)then
if (state=S1) then
	
	if(mode=1)then
	upline<=E_j & n_i & t_i & e_i & r_i & space & M_j & o_i & d_i & e_i & colon & space & space & space & space & space;
	downline<=A_j & u_i & t_i & o_i & space & M_j & o_i & d_i & e_i & space & space & space & space & space & space & space;
	else
	upline<=E_j & n_i & t_i & e_i & r_i & space & M_j & o_i & d_i & e_i & colon & space & space & space & space & space;
	downline<=H_j & i_i & g_i & h_i & e_i & r_i & space & D_j & e_i & n_i & o_i & m_i & i_i & n_i & a_i & space;		
	end if;
	
elsif(state=S2)then
		
	IF	(inputcurrency=1)	   THEN	
upline<= E_j & n_i & t_i & e_i & r_i & space & I_j & n_i & p_i & u_i & t_i & c_i & u_i & r_i & r_i & e_i;
downline<=n_i & c_i & y_i & colon & space & R_j & u_i & p_i & e_i & e_i & space & space & space & space & space & space;	
	ELSIF	(inputcurrency=2)	THEN	
upline<= E_j & n_i & t_i & e_i & r_i & space & I_i & n_i & p_i & u_i & t_i & c_i & u_i & r_i & r_i & e_i;
downline<=n_i & c_i & y_i & colon & space & E_j & u_i & r_i & o_i & space & space & space & space & space & space & space;	
	ELSIF	(inputcurrency=3)	THEN	
upline<= E_j & n_i & t_i & e_i & r_i & space & I_i & n_i & p_i & u_i & t_i & c_i & u_i & r_i & r_i & e_i;
downline<=n_i & c_i & y_i & colon & space & D_j & o_i & l_i & l_i & a_i & r_i & space & space & space & space & space;	

	ELSIF	(inputcurrency=4)	THEN	
upline<= E_j & n_i & t_i & e_i & r_i & space & I_j & n_i & p_i & u_i & t_i & c_i & u_i & r_i & r_i & e_i;
downline<=n_i & c_i & y_i & colon & space & Y_j & e_i & n_i & space & space & space & space & space & space & space & space;	

	ELSIF	(inputcurrency=5)	THEN	
upline<= E_j & n_i & t_i & e_i & r_i & space & I_j & n_i & p_i & u_i & t_i & c_i & u_i & r_i & r_i & e_i;
downline<=n_i & c_i & y_i & colon & space & P_j & o_i & u_i & n_i & d_i & space & space & space & space & space & space;	

	END	IF;

	elsif(state=S3)then
	

   a1<=std_logic_vector(to_unsigned(48,8)+(to_unsigned(amt(1),8)));
	a2<=std_logic_vector(to_unsigned(48,8)+(to_unsigned(amt(2),8)));
	b1<=std_logic_vector(to_unsigned(48,8)+(to_unsigned(amt(3),8)));
	b2<=std_logic_vector(to_unsigned(48,8)+(to_unsigned(amt(4),8)));
	
	upline<=E_j & n_i & t_i & e_i & r_i & space & A_i & m_i & o_i & u_i & n_i & t_i & colon & space & space & space;
	downline<=a1 & a2 & b1 & b2 & space & space & space & space & space & space & space & space & space & space & space & space;
	

	

elsif(state=S4)then
	
		
	IF	(outputcurrency=1)	   THEN	
upline<= E_j & n_i & t_i & e_i & r_i & space & O_i & u_i & t_i & p_i & u_i & t_i & C_j & u_i & r_i & r_i ;
downline<=e_i & n_i & c_i & y_i & colon & space & R_j & u_i & p_i & e_i & e_i & space & space & space & space & space;	
	ELSIF	(outputcurrency=2)	THEN	
upline<= E_j & n_i & t_i & e_i & r_i & space & O_i & u_i & t_i & p_i & u_i & t_i & C_j & u_i & r_i & r_i ;
downline<=e_i & n_i & c_i & y_i & colon & space & E_j & u_i & r_i & o_i & space & space & space & space & space & space;	
	ELSIF	(outputcurrency=3)	THEN	
upline<= E_j & n_i & t_i & e_i & r_i & space & O_i & u_i & t_i & p_i & u_i & t_i & C_j & u_i & r_i & r_i ;
downline<=e_i & n_i & c_i & y_i & colon & space & D_j & o_i & l_i & l_i & a_i & r_i & space & space & space & space;	

	ELSIF	(outputcurrency=4)	THEN	
upline<= E_j & n_i & t_i & e_i & r_i & space & O_i & u_i & t_i & p_i & u_i & t_i & C_j & u_i & r_i & r_i ;
downline<=e_i & n_i & c_i & y_i & colon & space & Y_j & e_i & n_i & space & space & space & space & space & space & space;	

	ELSIF	(outputcurrency=5)	THEN	
upline<= E_j & n_i & t_i & e_i & r_i & space & O_i & u_i & t_i & p_i & u_i & t_i & C_j & u_i & r_i & r_i ;
downline<=e_i & n_i & c_i & y_i & colon & space & P_j & o_i & u_i & n_i & d_i & space & space & space & space & space;	

	END	IF;


elsif(state=S5)then
	

  
	-- ans(1) ans(2) ans(3) ans(4) ans(5) ans(6)
	if(ans(1)<10)then 
	a2<=zerodis;a1<=std_logic_vector(to_unsigned(48,8)+to_unsigned(ans(1),8));
	elsif(ans(1)<20)then
	a2<=onedis;a1<=std_logic_vector(to_unsigned(48,8)+to_unsigned(ans(1)-10,8));
	elsif(ans(1)<30)then
	a2<=twodis;a1<=std_logic_vector(to_unsigned(48,8)+to_unsigned(ans(1)-20,8));
	end if;
	
	if(ans(2)<10)then 
	b2<=zerodis;b1<=std_logic_vector(to_unsigned(48,8)+to_unsigned(ans(2),8));
	elsif(ans(2)<20)then
	b2<=onedis;b1<=std_logic_vector(to_unsigned(48,8)+to_unsigned(ans(2)-10,8));
	elsif(ans(2)<30)then
	b2<=twodis;b1<=std_logic_vector(to_unsigned(48,8)+to_unsigned(ans(2)-20,8));
	end if;
	
	if(ans(3)<10)then 
	c2<=zerodis;c1<=std_logic_vector(to_unsigned(48,8)+to_unsigned(ans(3),8));
	elsif(ans(3)<20)then
	c2<=onedis;c1<=std_logic_vector(to_unsigned(48,8)+to_unsigned(ans(3)-10,8));
	elsif(ans(3)<30)then
	c2<=twodis;c1<=std_logic_vector(to_unsigned(48,8)+to_unsigned(ans(3)-20,8));
	end if;
	
	if(ans(4)<10)then 
	d2<=zerodis;d1<=std_logic_vector(to_unsigned(48,8)+to_unsigned(ans(4),8));
	elsif(ans(4)<20)then
	d2<=onedis;d1<=std_logic_vector(to_unsigned(48,8)+to_unsigned(ans(4)-10,8));
	elsif(ans(4)<30)then
	d2<=twodis;d1<=std_logic_vector(to_unsigned(48,8)+to_unsigned(ans(4)-20,8));
	end if;
	
	if(ans(5)<10)then 
	e2<=zerodis;e1<=std_logic_vector(to_unsigned(48,8)+to_unsigned(ans(5),8));
	elsif(ans(5)<20)then
	e2<=onedis;e1<=std_logic_vector(to_unsigned(48,8)+to_unsigned(ans(5)-10,8));
	elsif(ans(5)<30)then
	e2<=twodis;e1<=std_logic_vector(to_unsigned(48,8)+to_unsigned(ans(5)-20,8));
	end if;
	
	if(ans(6)<10)then 
	f2<=zerodis;f1<=std_logic_vector(to_unsigned(48,8)+to_unsigned(7,8));--ans(6)
	elsif(ans(6)<20)then
	f2<=onedis;f1<=std_logic_vector(to_unsigned(48,8)+to_unsigned(ans(6)-10,8));
	elsif(ans(6)<30)then
	f2<=twodis;f1<=std_logic_vector(to_unsigned(48,8)+to_unsigned(ans(6)-20,8));
	end if;
	
	upline<=Outputdis & colon & a2 & a1 & space & b2 & b1 & space & c2 & c1 & space;
	downline<=d2 & d1 & space & e2 & e1 & space & f2 & f1 & space & space & space & space & space & space & space & space;
	
	
	
end if;

end if;
--end if;
end process;



end Behavioral;

