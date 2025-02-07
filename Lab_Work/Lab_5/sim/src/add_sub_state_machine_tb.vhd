-------------------------------------------------------------------------------
-- Dr. Kaputa
-- add sub test bench 
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity add_sub_state_machine_tb is
end add_sub_state_machine_tb;

architecture arch of add_sub_state_machine_tb is

component add_sub_state_machine is
    Port(switch                             : in std_logic_vector(7 downto 0);
		 button                             : in std_logic;
         clk                                : in std_logic;
         reset                              : in std_logic;
		 led                                : out std_logic_vector(3 downto 0);
         hex0, hex1, hex2                   : out std_logic_vector(6 downto 0)
        );
end component;

constant NUM_BITS   : integer := 3;


signal switch      : std_logic_vector(7 downto 0) := "00000000";
signal button      : std_logic := '0';
signal led         : std_logic_vector(3 downto 0) := "0000";

constant period     : time := 20ns;                                              
signal clk          : std_logic := '0';
signal reset        : std_logic := '1';

begin

-- clock process
clock: process
  begin
    clk <= not clk;
    wait for period/2;
end process; 
 
-- reset process
async_reset: process
  begin
    wait for 2 * period;
    reset <= '0';
    wait;
end process; 

uut: add_sub_state_machine 
  port map (
    clk          => clk,
    reset        => reset,
    switch       => switch,
    button       => button,
    hex2         => open,
    hex1         => open,
    hex0         => open
  );

sequential_tb : process 
  begin
    report "******************  A = 5, B = 2 ****************";  
	switch <= "00000101";
    wait for 60 ns;   -- let all the initial conditions trickle through
	button <= '1';
	wait for 60 ns;
	button <= '0';
    switch <= "00000010";
	wait for 20 ns;
	button <= '1';
	wait for 60 ns;
	button <= '0';
	wait for 20 ns;
	button <= '1';
	wait for 60 ns;
	button <= '0';
	wait for 20 ns;
	button <= '1';
	wait for 60 ns;
	button <= '0';
	report "******************  A = 5, B = 2 complete ****************";  
	
    report "****************** A = 2, B = 5 start ****************";
	switch <= "00000010";
	wait for 20 ns;
	button <= '1';
	wait for 60 ns;
	button <= '0';
	switch <= "00000101";
	wait for 20 ns;
	button <= '1';
	wait for 60 ns;
	button <= '0';
	wait for 20 ns;
	button <= '1';
	wait for 60 ns;
	button <= '0';
	wait for 20 ns;
	button <= '1';
	wait for 60 ns;
	button <= '0';
    report "****************** A = 2, B = 5 complete ****************";
	
    report "****************** A = 200, B = 100  ****************";
	switch <= "11001000";
	wait for 20 ns;
	button <= '1';
	wait for 60 ns;
	button <= '0';
	switch <= "01100100";
	wait for 20 ns;
	button <= '1';
	wait for 60 ns;
	button <= '0';
	wait for 20 ns;
	button <= '1';
	wait for 60 ns;
	button <= '0';
	wait for 20 ns;
	button <= '1';
	wait for 60 ns;
	button <= '0';
    report "****************** A = 200, B = 100 complete ****************";
    
	report "****************** A = 100, B = 200  ****************";

    switch <= "01100100";
	wait for 20 ns;
	button <= '1';
	wait for 60 ns;
	button <= '0';
	switch <= "11001000";
	wait for 20 ns;
	button <= '1';
	wait for 60 ns;
	button <= '0';
	wait for 20 ns;
	button <= '1';
	wait for 60 ns;
	button <= '0';
	wait for 20 ns;
	button <= '1';
	wait for 60 ns;
	button <= '0';
    report "****************** A = 100, B = 400 complete ****************";
    wait;
end process; 

end arch;