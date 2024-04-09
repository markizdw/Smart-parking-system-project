library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sensor is
    Port ( trig : out STD_LOGIC;
           echo : out STD_LOGIC;
           transit : out STD_LOGIC;
           clk : in STD_LOGIC);
end sensor;

architecture Behavioral of sensor is
signal sig_trig : std_logic := '0';
constant sig_pulse_width : integer := 2;
signal counter : integer range 0 to sig_pulse_width - 1 := 0;
begin
        process (clk) is 
         begin
             if (rising_edge(clk))then
               if counter < sig_pulse_width - 1 then
                    counter <= counter + 1;
                        trig <= '1';
                    else
                        trig <= '0';
                        counter <= 0;
              
               end if;
            end if;
       end process;    
end Behavioral;
