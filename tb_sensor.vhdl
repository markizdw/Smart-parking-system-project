
-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 23.4.2024 20:30:34 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_sensor is
end tb_sensor;

architecture tb of tb_sensor is

    component sensor
        port (clk        : in std_logic;
              trig       : out std_logic;
              echo       : in std_logic;
              sensor_out : out std_logic;
              led_green  : out std_logic;
              led_red    : out std_logic;
              distance   : out std_logic_vector (15 downto 0));
    end component;

    signal clk        : std_logic;
    signal trig       : std_logic;
    signal echo       : std_logic;
    signal sensor_out : std_logic;
    signal led_green  : std_logic;
    signal led_red    : std_logic;
    signal distance   : std_logic_vector (15 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : sensor
    port map (clk        => clk,
              trig       => trig,
              echo       => echo,
              sensor_out => sensor_out,
              led_green  => led_green,
              led_red    => led_red,
              distance   => distance);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        echo <= '0'; wait for 100ns;
        echo <= '1'; wait for 50ns;
  
        echo <= '0'; wait for 50ns;
        echo <= '1'; wait for 100ns;
        
        echo <= '0'; wait for 50ns;
        echo <= '1'; wait for 30ns;

        echo <= '0'; wait for 50ns;
        echo <= '1'; wait for 200ns;
        
        echo <= '0'; wait for 50ns;
        echo <= '1'; wait for 130ns;
        echo <= '0';
   
      
        

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_sensor of tb_sensor is
    for tb
    end for;
end cfg_tb_sensor;
