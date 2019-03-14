
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity g14_MAC_tb is
end g14_MAC_tb;

architecture test of g14_MAC_tb is

component g14_lab2 is
	port(	x		: in std_logic_vector(9 downto 0);
		y		: in std_logic_vector(9 downto 0);
		N		: in std_logic_vector(9 downto 0);
		clk		: in std_logic;
		rst		: in std_logic;
		mac		: out std_logic_vector(21 downto 0);
		ready		: out std_logic;
		counter		: out integer range 0 to 1000);
end component g14_lab2;

--Testbench Internal Signals
file file_VECTORS_X : text;
file file_VECTORS_y : text;
file file_RESULTS : text;

constant clk_PERIOD : time := 100 ns;

signal x_in		: std_logic_vector(9 downto 0);	
signal y_in		: std_logic_vector(9 downto 0);
signal N_in		: std_logic_vector(9 downto 0);
signal clk_in		: std_logic;
signal rst_in		: std_logic;
signal mac_out		: std_logic_vector(21 downto 0);
signal ready_out	: std_logic;
signal counter_out	: integer range 0 to 1000;

begin
--Instantiate MAC
	g14_lab2_INST :  g14_lab2
		port map (
			x => x_in ,
			y => y_in ,
			N => N_in ,			
			clk => clk_in ,
			rst => rst_in ,
			mac => mac_out,
			ready => ready_out,
			counter => counter_out);

--Clock Generation
	clk_generation : process
	begin
		clk_in <= '1';
		wait for clk_PERIOD / 2;
		clk_in <= '0';
		wait for clk_PERIOD / 2;
	end process clk_generation;

--Feeding Inputs
	feeding_instr : process is
		variable v_Iline1 : line;
		variable v_Iline2 : line;
		variable v_Oline : line;
		variable v_x_in : std_logic_vector(9 downto 0);
		variable v_y_in : std_logic_vector(9 downto 0);
		begin
			-- reset the circuit
			N_in <= "1111101000";	--N=1000
			wait until rising_edge(clk_in);
			rst_in <= '1';
			wait until rising_edge(clk_in);
			wait until rising_edge(clk_in);
			rst_in <= '0';
			file_open(file_VECTORS_X, "lab2-x-fixed-point.txt" , read_mode);
			file_open(file_VECTORS_Y, "lab2-y-fixed-point.txt", read_mode);
			file_open(file_RESULTS, "lab2-out.txt", write_mode);
			
			while not endfile(file_VECTORS_X) loop
				readline (file_VECTORS_X, v_Iline1);
				read(v_Iline1, v_x_in);
				readline (file_VECTORS_Y, v_Iline2);
				read(v_Iline2, v_y_in);

				x_in <= v_x_in;
				y_in <= v_y_in;

				wait until rising_edge(clk_in);
				end loop;
				
				--wait until rising_edge(clk_in);

				if ready_out = '1' then
					wait until rising_edge(clk_in);
					wait until rising_edge(clk_in);
					write(v_Oline, mac_out);
					writeline(file_RESULTS, v_Oline);
					wait;
				end if;
				
			end process;			
		end test;

