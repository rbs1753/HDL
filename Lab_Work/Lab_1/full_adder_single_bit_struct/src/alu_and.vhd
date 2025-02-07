-------------------------------------------------------------------------------
-- Ryan Salmon
-- September 11, 2024
-- Lab 1, AND gate file
-------------------------------------------------------------------------------
   
library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all;      

entity alu_AND is
	port(
		a : in  std_logic;
		b : in  std_logic;
		y : out std_logic
	);
end alu_AND;

architecture model of alu_AND is
begin
	y <= a and b;
end model;
	
