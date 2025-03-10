-------------------------------------------------------------------------------
-- Ryan Salmon
-- Counter with Hex test bench for Lab 3
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity top_tb is
end top_tb;

architecture arch of top_tb is

Component top is
  Port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    seven_seg_out   : out std_logic_vector(6 downto 0)
  );
End Component; 

signal seven_seg_out       : std_logic_vector(6 downto 0);
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

uut:top  
  generic map (
    max_count => 4
  )
  port map(
    clk       => clk,
    reset     => reset,
    seven_seg_out    => seven_seg_out
  );
end arch;