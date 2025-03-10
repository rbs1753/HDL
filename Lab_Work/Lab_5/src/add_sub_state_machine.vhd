Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

Entity add_sub_state_machine is
    Port(switch                             : in std_logic_vector(7 downto 0);
		 button                             : in std_logic;
         clk                                : in std_logic;
         reset                              : in std_logic;
		 led                                : out std_logic_vector(3 downto 0);
         hex0, hex1, hex2                   : out std_logic_vector(6 downto 0)
        );
end add_sub_state_machine;

architecture model of add_sub_state_machine is

component rising_edge_synchronizer is 
  port (
    clk               : in std_logic;
    reset             : in std_logic;
    input             : in std_logic;
    edge              : out std_logic
  );
end component;

component synchronizer is 
  port (
    clk               : in std_logic;
    reset             : in std_logic;
    async_in          : in std_logic_vector (7 downto 0);
    sync_out          : out std_logic_vector (7 downto 0)
  );
end component;

component alu is
  port (
    clk           : in  std_logic;
    reset         : in  std_logic;
    a             : in  std_logic_vector(7 downto 0); 
    b             : in  std_logic_vector(7 downto 0);
    op            : in  std_logic_vector(1 downto 0); -- 00: add, 01: sub, 10: mult, 11: div
    result        : out std_logic_vector(7 downto 0)
  );  
end component;

component double_dabble is
  port (
    result_padded           : in  std_logic_vector(11 downto 0); 
    ones                    : out std_logic_vector(3 downto 0);
    tens                    : out std_logic_vector(3 downto 0);
    hundreds                : out std_logic_vector(3 downto 0)
  );  
end component;  

component seven_seg is
    Port(
          bcd            :in std_logic_vector(3 downto 0);
          seven_seg_out :out std_logic_vector(6 downto 0));
End component;



Type state_type is (input_a, input_b, disp_sum, disp_diff); --Enumerated Types for my state machine.
Signal current_state, next_state : state_type;

signal switch_sync        : std_logic_vector(7 downto 0); --Synced switch inputs
signal a_sync, b_sync     : std_logic_vector(7 downto 0):= "00000000"; --Synced inputs that store switch value

signal button_sync        : std_logic; --Sync button
signal math_sum               : std_logic_vector(8 downto 0); --Stores the value of the generic_add_sub.
signal math_diff               : std_logic_vector(8 downto 0); --Stores the value of the generic_add_sub.
signal result             : std_logic_vector(11 downto 0); --output to be sent to ssd

signal ones               : std_logic_vector(3 downto 0); --For use with the double dabble
signal tens               : std_logic_vector(3 downto 0);
signal hundreds           : std_logic_vector(3 downto 0);

signal flag               :std_logic;

begin
	
	sync : process(clk, reset) --State transition to clock logic 
	  begin
	    if(reset = '1') then
		  current_state <= input_a;
		elsif (rising_edge(clk)) then
		  current_state <= next_state;
		end if;
	  end process;
	  
	
	comb : process(current_state, button_sync) --Combination state transition logic
	  begin
		next_state <= current_state;
	    case(current_state) is
		  when input_a => 
			if(button_sync = '1') then
              next_state <= input_b;
			else next_state <= input_a;
			end if;
		
		  when input_b => 
			if(button_sync = '1') then
              next_state <= disp_sum;
			else next_state <= input_b;
			end if;
		  
		  when disp_sum => 
			if(button_sync = '1') then
              next_state <= disp_diff;
			else next_state <= disp_sum;
			end if;
			
		  when disp_diff => 
			if(button_sync = '1') then
              next_state <= input_a;
			else next_state <= disp_diff;
			end if;
			
		end case;
	  end process;
	  
	a_input : process(switch_sync, current_state, a_sync) --A value output process
	 begin
	    case next_state is
		   when input_a => a_sync <= switch_sync;
		   when input_b => a_sync <= a_sync;
		   when disp_sum => a_sync <= a_sync;
		   when disp_diff => a_sync <= a_sync;
		   when others => a_sync  <= a_sync;
		 end case;
	  end process;
	  
	b_input : process(switch_sync, current_state, b_sync) --A value output process
	   begin
	     case next_state is
		   when input_a => b_sync <= b_sync;
		   when input_b => b_sync <= switch_sync;
		   when disp_sum => b_sync <= b_sync;
		   when disp_diff => b_sync <= b_sync;
		   when others => b_sync  <= b_sync;
		 end case;
	  end process;
	  
	output_set : process(current_state, a_sync, b_sync, math_sum, math_diff)
	  begin
	     case(current_state) is
		    when input_a =>   result    <= "0000" & a_sync;--"0000"&
		    when input_b =>   result    <= "0000" & b_sync;
		    when disp_sum =>  result    <= "000" & math_sum;
		    when disp_diff => result    <= "000" & math_diff;
			when others =>    result     <= "000" & math_sum;
		  end case;
	    end process;
		
	led_set : process(current_state)
	  begin
	    case (current_state) is
		    when input_a =>   led    <= "0001";
		    when input_b =>   led    <= "0010";
		    when disp_sum =>  led    <= "0100";
		    when disp_diff => led    <= "1000";
			when others =>    led    <= "0000";
		  end case;
	    end process;
		
	RES : rising_edge_synchronizer port map(
		input => button,
		clk   => clk,
		reset => reset,
		edge  => button_sync
		);

	sync_input : synchronizer port map(
		clk      => clk,
		reset    => reset,
		async_in => switch,
		sync_out => switch_sync
		);
		
	
		
	dabble : double_dabble port map(
		result_padded => result,
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