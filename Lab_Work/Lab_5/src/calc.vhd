Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

Entity Calc is
    Port(switch                             : in std_logic_vector(7 downto 0);
		 execute,ms,mr                      : in std_logic;
         clk                                : in std_logic;
         reset                              : in std_logic;
		 led                                : out std_logic_vector(3 downto 0);
         hex0, hex1, hex2                   : out std_logic_vector(6 downto 0)
        );
end Calc;

architecture model of Calc is

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

Type state_type is (read_w, write_s, write_w_no_op, write_w, read_s); --Enumerated Types for my state machine.
Signal current_state, next_state : state_type;

signal mr_sync, ms_sync, execute_sync : std_logic;
signal switch_sync                    : std_logic_vector(7 downto 0);
signal we                             : std_logic_vector(1 downto 0); --Memory Write enable Signal
signal addr                           : std_logic_vector(2 downto 0); --Memory Address location


begin
	
	sync : process(clk, reset) --State transition to clock logic 
	  begin
	    if(reset = '1') then
		  current_state <= read_w;
		elsif (rising_edge(clk)) then
		  current_state <= next_state;
		end if;
	  end process;

    comb : process(current_state, button_sync) --Combination state transition logic
	  begin
        case current_state is
          when read_w =>
            if(ms_sync = '1') then
              next_state <= write_s;
            elsif(execute_sync = '1') then 
              next_state <= write_w_no_op;
            elsif(mr_sync = '1') then
              next_state <= read_s;
            else next_state <= read_w;
            end if;
          when write_s => next_state <= read_w;
          when write_w_no_op => next_state <= write_w;
          when read_s => 
            if(execute_sync = '1') then
              next_state <= write_w_no_op;
            else next_state <= read_s;
            end if;
          when write_w => next_state <= read_w;
          end case;
        end process;
        
       
       write_address: process(current_state)
         begin
           case current_state is
             when read_w  => addr <= "00";
             when read_s  => addr <= "01"; 
             when write_w => addr <= "00";
             when write_s => addr <= "01";
             when others  => addr <= "00";
            end case;
          end process;
        
        write_enable: process(current_state)
         begin
           case current_state is
             when read_w  => we <= '0';
             when read_s  => we <= '0'; 
             when write_w => we <= '1';
             when write_s => we <= '1';
             when others  => we <= '0';
            end case;
          end process;
       
       RES_1 : rising_edge_synchronizer port map(
		input => execute,
		clk   => clk,
		reset => reset,
		edge  => execute_sync
		);

       RES_2 : rising_edge_synchronizer port map(
		input => mr,
		clk   => clk,
		reset => reset,
		edge  => mr_sync
		);
        
       RES_3 : rising_edge_synchronizer port map(
		input => ms,
		clk   => clk,
		reset => reset,
		edge  => ms_sync
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
