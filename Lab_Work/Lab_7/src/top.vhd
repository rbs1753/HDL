--------------------------------------------------
-- Ryan Salmon
-- Lab 7 Top Level File 
--------------------------------------------------

library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;     
use work.components.all;

entity top is
    port(
         ex    : in std_logic;
         clk   : in std_logic;
         reset : in std_logic;
         hex2  : out std_logic_vector(6 downto 0);
         hex1  : out std_logic_vector(6 downto 0);
         hex0  : out std_logic_vector(6 downto 0);
         led   : out std_logic_vector(4 downto 0)
         );
end top;

architecture beh of top is
component lab6 is 
    port(
         input   : in std_logic_vector(7 downto 0);
         mr      : in std_logic; --Key 1
         ms      : in std_logic; --Key 2
         clk     : in std_logic;
         reset   : in std_logic;
         execute : in std_logic;
         op      : in std_logic_vector (1 downto 0);
         Hex0    : out std_logic_vector(6 downto 0);
         Hex1    : out std_logic_vector(6 downto 0);
         Hex2    : out std_logic_vector(6 downto 0);
         led     : out std_logic_vector(4 downto 0)
         );
end component;

component blink_rom
  PORT(
    address         : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
    clock           : IN STD_LOGIC  := '1';
    q               : OUT STD_LOGIC_VECTOR (12 DOWNTO 0)
  );
end component;


signal address_sig : std_logic_vector(4 downto 0) := "00000";
signal q_sig       : std_logic_vector(12 downto 0);
signal ex_sync     : std_logic;
signal reset_sync  : std_logic;
alias ex_in        : std_logic is q_sig(12);
alias op_in        : std_logic_vector(1 downto 0) is q_sig(11 downto 10);
alias mr_in        : std_logic is q_sig(9);
alias ms_in        : std_logic is q_sig(8);
alias input_in     : std_logic_vector(7 downto 0) is q_sig(7 downto 0);

begin

  RES : rising_edge_synchronizer port map(
    input => ex,
    clk   => clk,
    reset => reset_sync,
    edge  => ex_sync
  );
  
  RES_2 : rising_edge_synchronizer port map(
    input => reset,
    clk   => clk,
    reset => '0',
    edge  => reset_sync
  );

  rom_inst : blink_rom 
    port map (
      address     => address_sig,
      clock       => clk,
      q           => q_sig
    );
  
  lab_6 : lab6 
    port map(
     input   => input_in,
     mr      => mr_in,
     ms      => ms_in,
     clk     => clk,
     reset   => reset,
     execute => ex_in,
     op      => op_in,
     Hex0    => Hex0,
     Hex1    => Hex1,
     Hex2    => Hex2,
     led     => led
);

update_address: process(clk,reset_sync,address_sig,ex_sync)
  begin
    if reset_sync = '1' then
      address_sig <= (others => '0');
    elsif clk'event and clk = '1' then
      if ex_sync = '1' then
        address_sig <= std_logic_vector(unsigned(address_sig) + 1 );
      end if;
    end if;
  end process;
end beh;