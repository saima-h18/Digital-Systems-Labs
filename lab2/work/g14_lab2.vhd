library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity g14_lab2 is
port(	x			: in std_logic_vector (9 downto 0);	
		y			: in std_logic_vector (9 downto 0);
		N			: in std_logic_vector (9 downto 0);
		clk		: in std_logic;
		rst		: in std_logic;
		mac		: out std_logic_vector (21 downto 0);
		ready		: out std_logic);
end g14_lab2;

architecture archlab2 of g14_lab2 is

signal maccounter: signed(21 downto 0);	
--signal Ncounter: integer range 0 to 1000;

	begin
		process(clk,rst)
		begin
		if rising_edge(clk) then
			if rst = '1' then 
				maccounter <= (to_signed(0, 22));
				ready <= '0';
			else
				--Ncounter <= to_integer(to_unsigned(N, 10));
				for_loop: for i in 1 to 1000 loop
					maccounter <= maccounter + (signed(x) * signed(y));
				end loop for_loop;
				
				ready <= '1';
--				if (N < std_logic_vector(to_unsigned(1000,10))) then
--					ready <= '0';
--					maccounter <= maccounter + (signed(x) * signed(y));
--				else
--					ready <= '1';
--					maccounter <= to_signed(0,22);
--				end if;				
			end if;
			mac <= std_logic_vector(maccounter);		
		end if;		
	end process;
end archlab2;
