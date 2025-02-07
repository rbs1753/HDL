-------------------------------------------------------------------------------
-- Ryan Salmon
-- Counter with Hex test bench for Lab 4
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity top_tb is
end top_tb;

architecture arch of top_tb is

entity Top is
    port(
      a     : in std_logic_vector (2 downto 0);
      b:    : in std_logic_vector (2 downto 0);
      add   : in std_logic;
      sub   : in std_logic;
      clk   : in std_logic;
      reset : in std_logic;
      hex_4 : out std_logic_vector (6 downto 0);
      hex_2 : out std_logic_vector (6 downto 0);
      hex_0 : out std_logic_vector (6 downto 0)
    );
end add_sub;

signal a     : in std_logic_vector (2 downto 0):= "000";
signal b:    : in std_logic_vector (2 downto 0):= "000";
signal add   : in std_logic:= '1';
signal sub   : in std_logic:= '1';
signal clk   : in std_logic;
signal reset : in std_logic;
signal hex_4 : out std_logic_vector (6 downto 0);
signal hex_2 : out std_logic_vector (6 downto 0);
signal hex_0 : out std_logic_vector (6 downto 0)
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

-- Input procedure

  for j in 0 to 1 loop -- Sets addition first, then sets subtraction after
    add <= not j;
    sub <= j;
    for i in 0 to 7 loop
      a <= "
uut:top  
  generic map (
    max_count => 4
  )
  port map(
    a         => a,
    b         => b,
    add       => add,
    sub       => sub,
    clk       => clk,
    reset     => reset,
    hex_4     => hex_4,
    hex_2     => hex_2,
    hex_0     => hex_0
  );
end arch;