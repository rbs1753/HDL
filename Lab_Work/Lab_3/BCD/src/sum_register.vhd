-------------------------------------------------------------------------------
-- Ryan Salmon
-- 9/23/2024
-- Sum Register component for HDL lab 3
-------------------------------------------------------------------------------
Library ieee;
USE ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

Entity sum_register is
    Port(sum     :in std_logic_vector (3 downto 0); --The value carried from generic_adder to sum_register
         clk     :in std_logic;
         reset   :in std_logic;
			enable  :in std_logic;
         sum_sig :out std_logic_vector(3 downto 0)); --The value sent from sum_register to seven_seg
End sum_register;

Architecture model of sum_register is
Begin
    Process(clk, reset, sum) is
    Begin
        if(reset = '1') then
            sum_sig <= "0000";
        elsif (clk'event and clk ='1') then
			if(enable = '1') then
            sum_sig <= sum;
			end if;
        end if;
    End Process;
End model;