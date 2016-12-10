----------------------------------------------------------------------------------
-- Company: Digilent Inc.
-- Engineer: Andrew Skreen
-- 
-- Create Date:    17:25:25 03/01/2012 
-- Module Name:    command_lookup
-- Project Name: 	 PmodCLS_Demo
-- Target Devices: Nexys3
-- Tool versions:  ISE 14.1
-- Description: Outputs a byte of data to be sent to the PmodCLS.
--
-- Revision: 1.00 - Added debouncing, comments, fixed reset issue.
-- Revision: 0.01 - File Created
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



-- *******************************************************************************
--  								Define block inputs and outputs
-- *******************************************************************************
entity command_lookup is
    Port ( sel : in integer range 0 to 47;
	         sinput1 : in STD_LOGIC_VECTOR(127 downto 0);
			   sinput : in STD_LOGIC_VECTOR(127 downto 0);
           data_out : out  STD_LOGIC_VECTOR (7 downto 0)
			  );
			  
	end command_lookup;


architecture Behavioral of command_lookup is

-- *******************************************************************************
--  								Signals, Constants, and Types
-- *******************************************************************************

	
	type LOOKUP is array ( 0 to 47 ) of std_logic_vector (7 downto 0);

	-- Hexadecimal values below represent ASCII characters
	signal command : LOOKUP  := (  	X"1B",   --0
												X"5B",	--1
												X"6A",	--2
												
												X"1B",	--27	--3	esc
												X"5B",	--91	--4	[
												X"30",	--48	--5	0
												X"3B",	--59	--6	;
												X"30",	--48	--7	0		7
												X"48",	--72	--8	H
												
												X"20",	--9		space
												X"20",
												X"20",	--11		space
												X"20",
												X"20",	--13		space
												X"20",
												X"20",	--15		space
												X"20",
												X"20",	--17		space
												X"20",
												X"20",	--19		space
												X"20",
												X"20",	--21		space
												X"20",
												X"20",	--23		space
												X"20",	--24					
												
												X"1B",	--27		esc
												X"5B",	--91		[
												X"31",	--49		1
												X"3B",	--59		;
												X"30",	--48		0		25
												X"48",	--72		H
												
												X"20",	--0	--31	space
												X"20",
												X"20",	--2		space
												X"20",
												X"20",	--4		space
												X"20",
												X"20",	--6		space
												X"20",
												X"20",	--8		space
												X"20",
												X"20",	--10		space
												X"20",
												X"20",	--12		space
												X"20",
												X"20",	--14		space
												X"20",	--15
												
												X"00");	--0		null	35;

-- *******************************************************************************
--  										Implementation
-- *******************************************************************************

begin

	-- Assign byte to output
	
	F0to15: for i in 0 to 15 generate
	Fi: command(24-i)<=sinput1(8*i+7 downto 8*i);
   end generate;	
	
	H0to15: for j in 0 to 15 generate
	Hj: command(46-j)<=sinput(8*j+7 downto 8*j);
   end generate;	
	
	data_out <= command( sel );

end Behavioral;

