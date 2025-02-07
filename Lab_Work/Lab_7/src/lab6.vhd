--------------------------------------------------
-- Ryan Salmon
-- Lab 6 Top Level File 
--------------------------------------------------

library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;     
use work.components.all;

entity lab6 is 
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
end lab6;

architecture model of lab6 is 

signal reset_sync    : std_logic; -- Make sure 
signal addr          : std_logic_vector(1 downto 0);
signal memory_grab   : std_logic_vector(7 downto 0); --Value of the memory map
signal alu_out       : std_logic_vector(7 downto 0);
signal input_sync    : std_logic_vector(7 downto 0);
signal we            : std_logic;
signal mr_sync       : std_logic;
signal ms_sync       : std_logic;
signal execute_sync  : std_logic;
signal op_sync       : std_logic_vector(1 downto 0) := "00";
signal mux_out       : std_logic_vector(7 downto 0) := "00000000"; --Mux value of either the mr output or the alu output
signal result_padded : std_logic_vector(11 downto 0) := "000000000000"; --Padded value of the mux for double_dabble use
signal ones          : std_logic_vector(3 downto 0); --For use with the double dabble
signal tens          : std_logic_vector(3 downto 0);
signal hundreds      : std_logic_vector(3 downto 0);

Type state_type is (read_w, read_s, write_w_no_op, write_w, write_s);
Signal current_state, next_state : state_type;

begin

    sync : process(clk, reset_sync) --State transition to clock logic 
      begin
        if(reset_sync = '1') then -- Active low button
          current_state <= read_w;
        elsif (rising_edge(clk)) then
          current_state <= next_state;
        end if;
      end process;
      
    comb : process(current_state, ms_sync, mr_sync, execute_sync) --Combination state transition logic
      begin
      next_state <= current_state;
        case(current_state) is
          when read_w =>
            led <= "00001";
            if(execute_sync = '1') then 
              next_state <= write_w_no_op;
            elsif(ms_sync = '1') then 
              next_state <= write_s;
            elsif(mr_sync = '1') then
              next_state <= read_s;
            else next_state <= read_w;
            end if;
            
          when read_s =>
          led <= "00010";
            if(execute_sync = '1') then
              next_state <= write_w_no_op;
            else next_state <= read_s;
            end if;
         
          when write_s =>
          led <= "00100";
            next_state <= read_w;
           
          when write_w_no_op =>
          led <= "01000";
            next_state <= write_w;
            
          when write_w =>
          led <= "10000";
            next_state <= read_w;
            
        end case;
      end process;
        
    we_proc: process(current_state) -- Process that writes when write is enabled
      begin
        case(current_state) is
          when read_w        => we <= '0';
          when read_s        => we <= '0';
          when write_w_no_op => we <= '0';
          when write_s       => we <= '1';
          when write_w       => we <= '1';
          when others        => we <= '0';
        end case;
      end process;
          
    addr_proc: process(current_state) -- Sets the address location based on the states, only access save reg when save is pressed 
      begin
        case(current_state) is
          when read_w        => addr <= "00";
          when write_w_no_op => addr <= "00";
          when write_w       => addr <= "00";
          when read_s        => addr <= "01";
          when write_s       => addr <= "01";
          when others        => addr <= "00";
        end case;
      end process;
      
    mux_proc: process(current_state, mux_out, memory_grab, alu_out, reset_sync, clk) 
      begin
      if(reset_sync = '1') then -- Added this to remove latches 
          mux_out <= (others => '0');
      elsif (rising_edge(clk)) then
        case(current_state) is
        when write_w_no_op => mux_out <= alu_out;
        when read_s        => mux_out <= memory_grab;
        when read_w        => mux_out <= memory_grab;
        when others        => mux_out <= mux_out;
        end case;
      end if;
      end process;
      
      result_padded <= "0000" & mux_out;
      
    mem: memory port map(
      clk => clk,
      we  => we,
      addr => addr,
      reset => reset_sync,
      din => mux_out,
      dout => memory_grab
      );

    alu_map : alu port map(
      a      => memory_grab,
      b      => input_sync,
      clk    => clk,
      reset  => reset_sync,
      op     => op_sync,
      result => alu_out
      );


    RES_1 : rising_edge_synchronizer port map(
      input => mr,
      clk   => clk,
      reset => reset_sync,
      edge  => mr_sync
      );
    
    RES_2 : rising_edge_synchronizer port map(
      input => ms,
      clk   => clk,
      reset => reset_sync,
      edge  => ms_sync
      );
    
    RES_3 : rising_edge_synchronizer port map(
      input => execute,
      clk   => clk,
      reset => reset_sync,
      edge  => execute_sync
        );
    
    RES_4 : rising_edge_synchronizer port map(
      input => reset,
      clk   => clk,
      reset => '0',
      edge  => reset_sync
        );
    
    sync_input1 : synchronizer 
      generic map( 
        size => 8
        )
      port map(
        clk      => clk,
        reset    => reset_sync,
        async_in => input,
        sync_out => input_sync
        );

    sync_input2 : synchronizer
      generic map( 
        size => 2
        )
      port map(
        clk      => clk,
        reset    => reset_sync,
        async_in => op,
        sync_out => op_sync
        );
    
    dabble : double_dabble port map(
      result_padded => result_padded,
      ones          => ones,
      tens          => tens,
      hundreds      => hundreds
        );
        
    ssd_0 : seven_seg port map(
      bcd           => ones,
      seven_seg_out => hex0
        );
    
    ssd_1 : seven_seg port map(
      bcd           => tens,
      seven_seg_out => hex1
        );
        
    ssd_2 : seven_seg port map(
      bcd           => hundreds,
      seven_seg_out => hex2
        );
        
    
end model;