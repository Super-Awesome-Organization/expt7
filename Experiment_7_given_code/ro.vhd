----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:05:14 05/15/2010 
-- Design Name: 
-- Module Name:    ro - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ro is
    Port ( en : in  STD_LOGIC;
           roout : out  STD_LOGIC);
end ro;

architecture Behavioral of ro is

	component counter32
		Port ( a : in  STD_LOGIC;
			b : out  STD_LOGIC);
	end component;
	
	component notgate
	    Port ( a : in  STD_LOGIC;
           b : out  STD_LOGIC);
	end component;
	
	component nandgate
	    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           c : out  STD_LOGIC);
	end component;
	
	signal tmp : std_logic_vector(16 downto 0);
	
	attribute keep : boolean;
	attribute keep of tmp : signal is TRUE;
	
begin

	not_1: notgate port map(tmp(0), tmp(1));
	nand_2: nandgate port map(tmp(1), en, tmp(2));
	not_3: notgate port map(tmp(2), tmp(3));
   not_4: notgate port map(tmp(3), tmp(4));
   not_5: notgate port map(tmp(4), tmp(0));
	--not_6: notgate port map(tmp(5), tmp(6));
   --not_7: notgate port map(tmp(6), tmp(7));
	--not_8: notgate port map(tmp(7), tmp(8));
	--not_9: notgate port map(tmp(8), tmp(9));
	--not_10: notgate port map(tmp(9), tmp(10));
	--not_11: notgate port map(tmp(10), tmp(11));
	--not_12: notgate port map(tmp(11), tmp(12));
	--not_13: notgate port map(tmp(12), tmp(13));
	--not_14: notgate port map(tmp(13), tmp(14));	
	--not_15: notgate port map(tmp(14), tmp(15));
	--not_16: notgate port map(tmp(15), tmp(16));
	--not_17: notgate port map(tmp(16), tmp(0));

	roout <= tmp(0);    
  
end Behavioral;

