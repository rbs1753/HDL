-------------------------------------------------------------------------------
-- Ryan Salmon
-- single bit full adder [Structural]
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;     
use ieee.numeric_std.all;      

entity full_adder_single_bit_struct is 
  port (
    a       : in std_logic;
    b       : in std_logic;
    cin     : in std_logic;
    sum     : out std_logic;
    cout    : out std_logic
  );
end full_adder_single_bit_struct;

architecture struct of full_adder_single_bit_struct is

signal and1 :  std_logic; --Output of A and B
signal and2 :  std_logic; --Output of A and cin
signal and3 :  std_logic; --Output of B and cin
signal xor_AB: std_logic; --Output of A XOR B



component alu_OR is
	port(
		a : in  std_logic;
		b : in  std_logic;
		c : in  std_logic;
		y : out std_logic
	);
end component;

component alu_XOR is
	port(
		a : in  std_logic;
		b : in  std_logic;
		y : out std_logic
	);
end component;

component alu_AND is
	port(
		a : in  std_logic;
		b : in  std_logic;
		y : out std_logic
	);
end component;


begin
	And_gate1: alu_AND Port Map(a => a,
								b => b,
								y => and1); --A and B combination
	
	And_gate2: alu_AND Port Map(a => a,
								b => cin,
								y => and2); --A and Cin combination
	
	And_gate3: alu_AND Port Map(a => b,
								b => cin,
								y => and3); --B and Cin combination
	
	Or_Gate: alu_OR Port Map(a => and1,
							 b => and2,
							 c => and3,
							 y => cout);
							 
	XOR_gate1: alu_XOR Port Map(a => a,
								b => b,
								y => xor_AB);
								
	XOR_gate2: alu_XOR Port Map(a => xor_AB,
								b => cin, 
								y => sum);
								
end struct; 