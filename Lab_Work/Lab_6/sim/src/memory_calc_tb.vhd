-------------------------------------------------------------------------------
-- Dr. Kaputa
-- add sub test bench 
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity memory_calc_tb is
end memory_calc_tb;

architecture arch of memory_calc_tb is

component top is 
	port(
		 input   : in std_logic_vector(7 downto 0);
		 mr      : in std_logic;
		 ms      : in std_logic;
		 clk     : in std_logic;
		 reset   : in std_logic;
		 execute : in std_logic;
		 op      : in std_logic_vector (1 downto 0);
		 Hex0    : out std_logic_vector(6 downto 0);
		 Hex1    : out std_logic_vector(6 downto 0);
		 Hex2    : out std_logic_vector(6 downto 0); 
		 led     : out std_logic_vector(4 downto 0)
		 );
end component;

constant NUM_BITS   : integer := 3;


signal input       : std_logic_vector(7 downto 0) := "00000000";
signal led         : std_logic_vector(4 downto 0) := "00000";

constant period     : time := 20ns;                                              
signal clk          : std_logic := '0';
signal reset        : std_logic := '1';
signal mr           : std_logic := '0';
signal ms           : std_logic := '0';
signal execute      : std_logic := '0'; 
signal op           : std_logic_vector(1 downto 0) := "00";

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

uut: top 
  port map (
    input   => input,
    mr      => mr,
    ms      => ms,
    clk     => clk,
    reset   => reset,
    execute => execute,
    op      => op,
    Hex0    => open,   
    Hex1    => open,
    Hex2    => open,	
    led	    => led
  );

sequential_tb : process 
  begin
  report "**** Add 4 + 0 ****";
  wait for 80 ns;
  input <= x"04";
  op <= "00";
  wait for 60 ns;
  execute <= '1';
  wait for 120 ns;
  execute <= '0';
  report "**** Add 4 + 0 complete ****";
  
  
  report "**** Multiply 4 and 8 ****";
  input <= x"08";
  op <= "10";
  wait for 60 ns;
  execute <= '1';
  wait for 120 ns;
  execute <= '0';
  report "**** Multiply 4 and 8 complete ****";
  
  report "**** Save 32 ****";
  op <= "00";
  ms <= '1';
  wait for 60 ns;
  ms <= '0';
  report "**** Save 32 complete ****"; 
  
  report "**** Subtract 32 and 8 ****";
  input <= x"08";
  op <= "01";
  wait for 60 ns;
  execute <= '1';
  wait for 120 ns;
  execute <= '0';
  op <= "00";
  report "**** Subtract 32 and 8 complete ****";
  
  report "**** Divide 24 and 2 ****";
  input <= x"02";
  op <= "11";
  wait for 60 ns;
  execute <= '1';
  wait for 120 ns;
  execute <= '0';
  op <= "00";
  report "**** Divide 24 and 2 complete ****";
  
  report "Hit mr to get 32 ****";
  mr <= '1';
  wait for 60 ns;
  mr <= '0';
  report "Hit mr to get 32 complete ****";
  
  report "Divide 32 and 2 ****";
  input <= x"02";
  op <= "11";
  wait for 60 ns;
  execute <= '1';
  wait for 120 ns;
  execute <= '0';
  op <= "00";
  report "Divide 32 and 2 complete ****";
  end process;

end arch;
  
  
  