---------------------------------------------------------
-- Ryan Salmon
-- September 30, 2024
-- Addition and subtraction file for lab 4
---------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

entity generic_add_sub is
    generic(
      size : integer := 3
    );
    Port( 
      a    : in std_logic_vector(size-1 downto 0);
      b    : in std_logic_vector(size-1 downto 0);
      flag : in std_logic;
      c    : out std_logic_vector(size downto 0)
      );
end generic_add_sub;

architecture model of generic_add_sub is

  signal sum : std_logic_vector (size downto 0);
  signal diff : std_logic_vector (size downto 0);
  
begin
  sum  <= std_logic_vector(unsigned('0' & a) + unsigned('0' & b));
  diff <= std_logic_vector(unsigned('0' & a) - unsigned('0' & b));
  
  c <= sum when flag = '0' else diff;
  
end model;