library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity g14_lab1 is
	Port( clk				: in std_logic;
			direction		: in std_logic;
			rst				: in std_logic;
			enable			: in std_logic;
			output			: out std_logic_vector(7 downto 0));
			
	end g14_lab1;
	
architecture archlab1 of g14_lab1 is
signal counter: unsigned(7 downto 0);
	begin
		process(clk,rst)
		begin
		
		if rising_edge(clk) then
			if rst = '1' then 
				counter <= (to_unsigned(0, 8));
			elsif enable = '1' then
				if direction = '1'then
					counter <= counter + 1;
				else counter <= counter -1;
				end if;
			end if;
		end if;
		
	end process;
	output <= std_logic_vector(counter);

end archlab1;