-------------------------------------------------------------------------------
-- Ryan Salmon
-- September 11, 2024
-- Lab 1, OR gate file
-------------------------------------------------------------------------------
   
library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all;      

entity alu_OR is
	port(
		a : in  std_logic;
		b : in  std_logic;
		c : in  std_logic;
		y : out std_logic
	);
end alu_OR;

architecture model of alu_OR is
begin
	y <= c or (a or b);
end model;
	
