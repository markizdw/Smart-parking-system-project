----------------------------------------------------------------------------------
-- Company: Brno University of Technology
-- Engineer: Dominik Eis, Cristóvão Cristóvão, Sudakov Maxim, Filip Dráb
-- 
-- Create Date: 04/03/2024 11:14:46 AM
-- Design Name: 
-- Module Name: sensor - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

entity sensor is
    Port ( trig : out STD_LOGIC;
           echo : in STD_LOGIC;
           bin : std_logic_vector(3 downto 0);
           clk : in STD_LOGIC);
end sensor;

architecture Behavioral of sensor is

begin

sensor : process (clk) is
    begin

        if (rising_edge(clk)) then
            trig <= '1';
            
            

end Behavioral;
