----------------------------------------------------------------------------------
-- Company: Digilent Inc.
-- Engineer: Andrew Skreen
-- 
-- Create Date:    17:25:25 03/01/2012 
-- Module Name:    PmodCLS_Demo
-- Project Name: 	 PmodCLS_Demo
-- Target Devices: Nexys3
-- Tool versions:  ISE 14.1
-- Description: Prints "Hello From Digilent" on PmodCLS connected to Nexys3
--					 on pins JA1-JA4. SPI protocol is utilized for communications
--					 between the PmodCLS and the Nexys3, hence the appropriate
--					 jumpers should be set on the PmodCLS, for details see
--					 PmodCLS reference manual.
--
-- Revision: 1.00 - Added debouncing, comments, fixed reset issue.
-- Revision: 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- *******************************************************************************
--  								Define block inputs and outputs
-- *******************************************************************************
entity PmodCLS_Demo is
    Port ( sw : in  STD_LOGIC_VECTOR (2 downto 0);		-- sw[0] is reset
																		-- sw[1] is clear
																		-- sw[2] is start
           JA : inout  STD_LOGIC_VECTOR (3 downto 0); -- Port JA[4:1]
           Led : inout  STD_LOGIC_VECTOR (0 downto 0); -- Led<0>
			  clock: in std_logic;-- Onboard 100 Mhz clock
			  

  buttons : in std_logic_vector(4 downto 0);

 up:inout std_logic;--N4
 enter:inout std_logic;--F5
 down:inout std_logic;--P3
 right:inout std_logic;--F6
 reset:inout std_logic;--P4
  ver: inout STD_LOGIC_VECTOR(1 to 5);
  p: inout STD_LOGIC;
  p2: inout STD_LOGIC

);								
end PmodCLS_Demo;

architecture Behavioral of PmodCLS_Demo is

-- *******************************************************************************
--  									Component Declarations
-- *******************************************************************************


		-- ++++++++++++++++++++++++++++++++++++++++++++++
		-- 					Master Interface
		-- ++++++++++++++++++++++++++++++++++++++++++++++
signal outbuttons : std_logic_vector(4 downto 0);


signal clk : STD_LOGIC;

		component master_interface
			port ( begin_transmission : out std_logic;
					 end_transmission : in std_logic;
					 clk : in std_logic;
					 rst : in std_logic;
					 start : in std_logic;
					 clear : in std_logic;
					 slave_select : out std_logic;
					 sel : out integer range 0 to 47;
					 temp_data : in std_logic_vector(7 downto 0);
					 send_data : out std_logic_vector(7 downto 0));
		end component;

		-- ++++++++++++++++++++++++++++++++++++++++++++++
		-- 				Serial Port Interface
		-- ++++++++++++++++++++++++++++++++++++++++++++++
		component spi_interface
			port ( begin_transmission : in std_logic;
					 slave_select : in std_logic;
					 send_data : in std_logic_vector(7 downto 0);
					 miso : in std_logic;
					 clk : in std_logic;
					 rst : in std_logic;
					 --recieved_data : out std_logic_vector(7 downto 0);
					 end_transmission : out std_logic;
					 mosi : out std_logic;
					 sclk : out std_logic);
		end component;


		-- ++++++++++++++++++++++++++++++++++++++++++++++
		-- 					Command Lookup
		-- ++++++++++++++++++++++++++++++++++++++++++++++
		component command_lookup
			port( sel : in integer range 0 to 47;
				sinput1 : in STD_LOGIC_VECTOR(127 downto 0);
			   sinput : in STD_LOGIC_VECTOR(127 downto 0);
					data_out : out std_logic_vector(7 downto 0));
		end component;
		
		-- ++++++++++++++++++++++++++++++++++++++++++++++
		-- 						Debouncer
		-- ++++++++++++++++++++++++++++++++++++++++++++++
		component three_bit_debouncer
			port( 
					CLK : in STD_LOGIC;							
					RST : in STD_LOGIC;							
					DIN : in STD_LOGIC_VECTOR(2 downto 0);
					DOUT : out STD_LOGIC_VECTOR(2 downto 0)
			);
		end component;

component btn_debounce is
    Port ( BTN_I : in  STD_LOGIC_VECTOR (4 downto 0);
           CLK : in  STD_LOGIC;
           BTN_O : out  STD_LOGIC_VECTOR (4 downto 0));
end component;

-- *******************************************************************************
--  									Signals and Constants
-- *******************************************************************************

	-- Active low signal for writing data to PmodCLS
	signal slave_select : std_logic;
	-- Initializes data transfer with PmodCLS
	signal begin_transmission : std_logic;
	-- Handshake signal to signify data transfer done
	signal end_transmission : std_logic;
	-- Selects which ASCII value to send to PmodCLS
	signal sel : integer range 0 to 33;
	-- Output data from C2 to C0
	signal temp_data : std_logic_vector(7 downto 0);
	-- Output data from C0 to C1
	signal send_data : std_logic_vector(7 downto 0);
	-- Ground, i.e. logic low
	signal GRND : std_logic := '0';
	-- dbSW[0] Debounced SW[0], dbSW[1] Debounced SW[1], dbSW[2] Debounced SW[2]
	signal dbSW : std_logic_vector(2 downto 0) := "000";
	
	signal sinput1:  STD_LOGIC_VECTOR(127 downto 0);
	signal sinput:  STD_LOGIC_VECTOR(127 downto 0);
	SIGNAL rst : std_logic:='0';
	signal display: STD_LOGIC;
   
	   -- ++++++++++++++++++++++++++++++++++++++++++++++
		-- 				Serial Port Interface
		-- ++++++++++++++++++++++++++++++++++++++++++++++
		component project1
			port ( clk: in std_logic;
up: in std_logic;--N4
enter: in std_logic;--F5
down: in std_logic;--P3
right: in std_logic;--F6
reset: in std_logic;--P4

p: inout STD_LOGIC;


display: inout STD_LOGIC;
upline: out STD_LOGIC_VECTOR(127 downto 0);
downline: out STD_LOGIC_VECTOR(127 downto 0);
ver: out STD_LOGIC_VECTOR(1 to 5)
);
		end component;

signal prescaler : STD_LOGIC_VECTOR(23 downto 0);
-- *******************************************************************************
--  										Implementation
-- *******************************************************************************
begin

	-- Debounces the input control signals from switches.
	DebounceInputs : Three_Bit_Debouncer port map(
			CLK=>CLK,
			RST=>GRND,
			DIN=>SW,
			DOUT=>dbSW
	);

	-- Produces signals for controlling SPI interface, and selecting output data.
	C0: master_interface port map( 
			begin_transmission => begin_transmission,
			end_transmission => end_transmission,
			clk => clk,
			rst => dbSW(0),
			start => dbSW(2),--display,
			clear => dbSW(1),
			slave_select => slave_select,
			temp_data => temp_data,
			send_data => send_data,
			sel => sel
	);

	-- Interface between the PmodCLS and FPGA, proeduces SCLK signal, etc.
	C1 : spi_interface port map(
			begin_transmission => begin_transmission,
			slave_select => slave_select,
			send_data => send_data,
			--recieved_data => recieved_data,
			miso => JA(2),
			clk => clk,
			rst => dbSW(0),
			end_transmission => end_transmission,
			mosi => JA(1),
			sclk => JA(3)
	);

	-- Contains the ASCII characters for commands
	C2 : project1 port map (

clk=>clk,

up=>up,--N4
enter=>enter,--F5
down=>down,--P3
right=>right,--F6
reset=>reset,--P4

display=>display,
p=>p,

upline => sinput1,
downline => sinput,
ver=>ver
);


   C9 : btn_debounce port map (
			BTN_I=>buttons,
           CLK=>clk,
           BTN_O=>outbuttons
	);

	C99 : command_lookup port map (
			sel => sel,	
         sinput1 => sinput1,			
			sinput => sinput,
			data_out => temp_data
	);

	--  Active low slave select signal
	 
	JA(0) <= slave_select;

	--  Assign Led<0> the value of SW(0)
	Led(0) <= '1' when SW(0) = '1' else '0';


gen_clk : process (clock, rst)
  begin  -- process gen_clk
    if rst = '1' then
      clk   <= '0';
      prescaler   <= (others => '0');
    elsif rising_edge(clock) then   -- rising clock edge
      if (prescaler = X"7D") then     -- 125 in hex
        prescaler   <= (others => '0');
        clk   <= not clk;
      else
        prescaler <= prescaler + "1";
      end if;
    end if;
  end process gen_clk;
  
  
  
right<=outbuttons(0);
up<=outbuttons(1);
down<=outbuttons(2);
enter<=outbuttons(3);
reset<=outbuttons(4);

--p2<=right or up or down or enter or reset;

end Behavioral;

