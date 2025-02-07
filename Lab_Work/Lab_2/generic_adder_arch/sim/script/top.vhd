---------------------------------------------------------
-- Ryan Salmon
-- September 30, 2024
-- Top Level File for Lab 4
---------------------------------------------------------

Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

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

architecture model of Top is

signal s      : std_logic := '0';
signal result : std_logic_vector (3 downto 0):= "0000";