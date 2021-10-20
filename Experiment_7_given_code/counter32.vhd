----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:54:01 05/15/2010 
-- Design Name: 
-- Module Name:    counter32 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter32 is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end counter32;

architecture Behavioral of counter32 is
	signal val: std_logic_vector(31 downto 0);
begin
	process (clk, reset)
	begin
		if reset = '1' then
			val <= x"00000000";
		elsif clk'event and clk = '1' then
			val <= val + "1";
		end if;	
	end process;
	output <= val;
end Behavioral;

