-------------------------------------------------------------------------------
-- Dr. Kaputa
-- block mem test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity rom_memory_calc_tb is
end rom_memory_calc_tb;

architecture arch of rom_memory_calc_tb is

component top is
    port(
         ex    : in std_logic;
         clk   : in std_logic;
         reset : in std_logic;
         hex2  : out std_logic_vector(6 downto 0);
         hex1  : out std_logic_vector(6 downto 0);
         hex0  : out std_logic_vector(6 downto 0);
         led   : out std_logic_vector(4 downto 0)
         );
end component;

-- signal led_out        : std_logic_vector(6 downto 0);
constant period       : time := 20ns;                                              
signal clk            : std_logic := '0';
signal reset          : std_logic := '1';

signal ex   : std_logic := '0';
signal hex2 : std_logic_vector(6 downto 0);
signal hex1 : std_logic_vector(6 downto 0);
signal hex0 : std_logic_vector(6 downto 0);
signal led  : std_logic_vector(4 downto 0);

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

-- Execute process

ex_proc : process
  begin
    wait for 4 * period;
    ex <= not ex;
  end process; 

uut: top  
  port map(
   ex    => ex,
   clk   => clk,
   reset => reset,
   hex2  => hex2,
   hex1  => hex1,
   hex0  => hex0,
   led   => led
  );
end arch;