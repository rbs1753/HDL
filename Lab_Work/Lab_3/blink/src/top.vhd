-------------------------------------------------------------------------------
-- Dr. Kaputa
-- blink top
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity top is
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    output          : out std_logic
  );
end top;

architecture beh of top is

component blink is
  generic (
    max_count       : integer := 12500000 --Was 25000000, cut in half
  );
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    output          : out std_logic
  );  
end component;  

begin

uut: blink  
  generic map (
    max_count => 12500000 --Was 50000000, cut by 1/4
  )
  port map(
    clk       => clk,
    reset     => reset,
    output    => output
  );
end beh;