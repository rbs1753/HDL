---------------------------------------------------------
-- Ryan Salmon
-- September 30, 2024
-- Top level file for lab 4
---------------------------------------------------------

Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

entity add_sub is
    port(
      a      : in std_logic_vector (2 downto 0); --Number 1 
      b      : in std_logic_vector (2 downto 0); --Number 2
      add    : in std_logic;
      sub    : in std_logic;
      clk    : in std_logic;
      reset  : in std_logic;
      hex_4 : out std_logic_vector (6 downto 0); --Number 1 (a)
      hex_2 : out std_logic_vector (6 downto 0); --Number 2 (b)
      hex_0 : out std_logic_vector (6 downto 0) --Result Number
    );
end add_sub;

architecture model of add_sub is

signal a_sync   : std_logic_vector (2 downto 0):= "000"; --Is the inputs after the synchronizer
signal b_sync   : std_logic_vector (2 downto 0):= "000";

signal add_sync : std_logic; --Add and sub buttons after RES
signal sub_sync : std_logic;
signal result   : std_logic_vector (3 downto 0); --Helps me keep track of hex names

signal four_a_sync     : std_logic_vector(3 downto 0); --Four bit inputs to pass to BCD without error 
signal four_b_sync     : std_logic_vector(3 downto 0);

signal result_sig      : std_logic_vector(3 downto 0);

signal flag : std_logic;



component synchronizer is 
  port (
    clk               : in std_logic;
    reset             : in std_logic;
    async_in          : in std_logic_vector (2 downto 0);
    sync_out          : out std_logic_vector (2 downto 0)
  );
end component;

component rising_edge_synchronizer is 
  port (
    clk               : in std_logic;
    reset             : in std_logic;
    input             : in std_logic;
    edge              : out std_logic
  );
end component;

component seven_seg is
    Port(
          bcd            :in std_logic_vector(3 downto 0); --Have to add a 0 to the end of each input to offset bit size
          clk            :in std_logic;
          reset          :in std_logic;
          seven_seg_out  :out std_logic_vector(6 downto 0)
	 );
End component;

component generic_add_sub is
    generic(
      size : integer := 3
    );
    Port( 
      a    : in std_logic_vector(size-1 downto 0);
      b    : in std_logic_vector(size-1 downto 0);
      flag : in std_logic;
      c    : out std_logic_vector(size downto 0)
      );
end component;

Begin
    
    flag_proc : process(add, sub, reset)
      Begin
        if(reset = '1') then
          flag <= '0';
        elsif (rising_edge(clk)) then
          if(add_sync = '1') then
            flag <= '0';
          elsif(sub_sync = '1') then
            flag <= '1';
          end if;
        end if;
      end process;
      
    sync_output: process(reset,clk)
  begin
    if reset = '1' then
      result_sig <= "0000";
    elsif rising_edge(clk) then
      result_sig <= result;
    end if;
end process;
    
    four_a_sync <= '0' & a_sync;
    four_b_sync <= '0' & b_sync;
    
    
    a_synchronizer: synchronizer
                    Port Map(
                             clk => clk,
                             reset => reset,
                             async_in => a,
                             sync_out => a_sync
                            );
    
    b_synchronizer: synchronizer
                    Port Map(
                             clk => clk,
                             reset => reset,
                             async_in => b,
                             sync_out => b_sync
                            );
                            
    add_RES       : rising_edge_synchronizer
                    Port Map(
                             clk => clk,
                             reset => reset,
                             input => add,
                             edge => add_sync
                            );
                            
    sub_RES       : rising_edge_synchronizer
                    Port Map(
                             clk => clk,
                             reset => reset,
                             input => sub,
                             edge => sub_sync
                            );
                            
    math :generic_add_sub
              Port Map(
                       a => a_sync,
                       b => b_sync,
                       flag => flag,
                       c => result
                       );
	  
	bcd_a : seven_seg 
              Port Map(
                       bcd => four_a_sync,
                       clk => clk,
                       reset => reset,
                       seven_seg_out => hex_4
                       );
                       
    bcd_b : seven_seg 
              Port Map(
                       bcd => four_b_sync,
                       clk => clk,
                       reset => reset,
                       seven_seg_out => hex_2
                       );
    bcd_r : seven_seg 
              Port Map(
                       bcd => result_sig,
                       clk => clk,
                       reset => reset,
                       seven_seg_out => hex_0
                       );
 
end model;