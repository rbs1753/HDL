-------------------------------------------------------------------------------
-- Ryan Salmon
-- September 11, 2024
-- Lab 1, XOR gate file
-------------------------------------------------------------------------------
   
library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all;      

entity alu_XOR is
	port(
		a : in  std_logic;
		b : in  std_logic;
		y : out std_logic
	);
end alu_XOR;

architecture model of alu_XOR is
begin
	y <= a xor b;
end model;
	
