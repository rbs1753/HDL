---------------------------------------------------------
-- Ryan Salmon
-- October 10, 2024
-- Addition and subtraction file for lab 5
---------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

entity generic_add_sub is
    generic(
      size : integer := 8
    );
    Port( 
      a    : in std_logic_vector(size-1 downto 0);
      b    : in std_logic_vector(size-1 downto 0);
      diff    : out std_logic_vector(size downto 0);
      sum    : out std_logic_vector(size downto 0)
      );
end generic_add_sub;

architecture model of generic_add_sub is
  
begin
  sum  <= std_logic_vector(unsigned('0' & a) + unsigned('0' & b));
  diff <= std_logic_vector(unsigned('0' & a) - unsigned('0' & b));
  
  
  
end model;