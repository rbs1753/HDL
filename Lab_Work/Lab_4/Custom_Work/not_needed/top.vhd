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

component add_sub is
    port(
      a      : in std_logic_vector (2 downto 0);
      b      : in std_logic_vector (2 downto 0);
      clk    : in std_logic;
      reset  : in std_logic;
      s      : in std_logic; --The result of combining add and subtract into one simple signal
      result : out std_logic_vector (3 downto 0) --Don't feel like type casting this outside of the file
    );
end component;

component seven_seg is
    Port(
          bcd            :in std_logic_vector(3 downto 0); --Have to add a 0 to the end of each input to offset bit size
          clk            :in std_logic;
          reset          :in std_logic;
          seven_seg_out :out std_logic_vector(6 downto 0));
End component;

begin
    
    operation : process(add, sub) 
      begin
        if(add = '1') then 
          s <= '0';
        elsif (sub = '1') then
          s <= '1';
        end if;
      end process;
    
    bcd_1 : seven_seg 
              Port Map(
                       bcd => '0' & a,
                       clk => clk,
                       reset => reset,
                       seven_seg_out => hex_4
                       );
                       
    bcd_2 : seven_seg 
              Port Map(
                       bcd => '0' & b,
                       clk => clk,
                       reset => reset,
                       seven_seg_out => hex_4
                       );
                       
    math_op : add_sub
                Port Map(
                        a      => a,
                        b      => b,
                        clk    => clk,
                        reset  => reset,
                        s      => s,
                        result => result
                        );
    
    bcd_3 : seven_seg 
              Port Map(
                       bcd => '0' & a,
                       clk => clk,
                       reset => reset,
                       seven_seg_out => hex_4
                       );