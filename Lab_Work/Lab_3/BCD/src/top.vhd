-------------------------------------------------------------------------------
-- Ryan Salmon
-- 9/23/2024
-- Top level Component for HDL lab 3
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

Entity top is
  Port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    seven_seg_out   : out std_logic_vector(6 downto 0)
  );
End top;

architecture model of top is

signal sum     : std_logic_vector(3 downto 0) := "0000";
signal sum_sig : std_logic_vector(3 downto 0) := "0000";
signal enable  : std_logic;

Component generic_adder_beh is
  generic (
    bits    : integer := 4
  );
  Port (
    a       : in  std_logic_vector(bits-1 downto 0);
    b       : in  std_logic_vector(bits-1 downto 0);
    cin     : in  std_logic;
    sum     : out std_logic_vector(bits-1 downto 0);
    cout    : out std_logic
  );
End Component;

Component generic_counter is
  generic (
    max_count       : integer := 3
  );
  Port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    output          : out std_logic
  );  
End Component;

Component sum_register is
    Port(sum     :in std_logic_vector (3 downto 0);
         clk     :in std_logic;
         reset   :in std_logic;
			enable  :in std_logic;
         sum_sig :out std_logic_vector(3 downto 0));
End Component;

Component seven_seg is
    Port(
          bcd            :in std_logic_vector(3 downto 0);
          clk            :in std_logic;
          reset          :in std_logic;
          seven_seg_out :out std_logic_vector(6 downto 0));
End Component;

Begin
    adder: generic_adder_beh
        Port Map(
                 a => sum_sig,
                 b => "0001",
                 cin => '0',
                 sum => sum,
                 cout => open
                );

    counter : generic_counter
		  Generic Map(
						  max_count => 4)
        Port Map( 
                 clk => clk,
                 reset => reset,
                 output => enable
                );

     doing_stuff : sum_register
        Port Map(
                 sum => sum,
                 clk => clk,
                 reset => reset,
					  enable => enable,
                 sum_sig => sum_sig
                );

    Hex_Display : seven_seg
        Port Map(
                 bcd => sum_sig,
                 clk => clk,
                 reset => reset,
                 seven_seg_out => seven_seg_out
                );
End model;