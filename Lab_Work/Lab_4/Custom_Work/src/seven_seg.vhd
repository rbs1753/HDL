Library ieee;
USE ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

Entity seven_seg is
    Port(
          bcd            :in std_logic_vector(3 downto 0);
          clk            :in std_logic;
          reset          :in std_logic;
          seven_seg_out :out std_logic_vector(6 downto 0));
End seven_seg;

Architecture model of seven_seg is

    Constant zero  : std_logic_vector(6 downto 0) := "1000000";
    Constant one   : std_logic_vector(6 downto 0) := "1111001";
    Constant two   : std_logic_vector(6 downto 0) := "0100100";
    Constant three : std_logic_vector(6 downto 0) := "0110000";
    Constant four  : std_logic_vector(6 downto 0) := "0011001";
    Constant five  : std_logic_vector(6 downto 0) := "0010010";
    Constant six   : std_logic_vector(6 downto 0) := "0000010";
    Constant seven : std_logic_vector(6 downto 0) := "1111000";
    Constant eight : std_logic_vector(6 downto 0) := "0000000";
    Constant nine  : std_logic_vector(6 downto 0) := "0011000";
    Constant blank : std_logic_vector(6 downto 0) := "1111111";
    Constant dash  : std_logic_vector(6 downto 0) := "0111111";
    Constant A     : std_logic_vector(6 downto 0) := "0001000";
    Constant B     : std_logic_vector(6 downto 0) := "0000011";
    Constant C     : std_logic_vector(6 downto 0) := "1000110";
    Constant D     : std_logic_vector(6 downto 0) := "0100000";
    Constant E     : std_logic_vector(6 downto 0) := "0000110";
    Constant F     : std_logic_vector(6 downto 0) := "0001110";
    

Begin 
    
    case_proc : Process(bcd, clk, reset) is
    Begin
         Case bcd is    
            when "0000" => seven_seg_out <= zero;
            when "0001" => seven_seg_out <= one;
            when "0010" => seven_seg_out <= two;
            when "0011" => seven_seg_out <= three;
            when "0100" => seven_seg_out <= four;
            when "0101" => seven_seg_out <= five;
            when "0110" => seven_seg_out <= six;
            when "0111" => seven_seg_out <= seven;
            when "1000" => seven_seg_out <= eight;
            when "1001" => seven_seg_out <= nine;
            when "1010" => seven_seg_out <= A;
            when "1011" => seven_seg_out <= B;
            when "1100" => seven_seg_out <= C;
            when "1101" => seven_seg_out <= D;
            when "1110" => seven_seg_out <= E;
            when "1111" => seven_seg_out <= F;
            when others => seven_seg_out <= blank;
        End Case;
    End Process;
End model;
    
