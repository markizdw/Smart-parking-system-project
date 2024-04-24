library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_counter is
-- Testbench has no ports
end tb_counter;

architecture test of tb_counter is
    -- Component Declaration of the Counter
    component counter
        Port (
            clk   : in std_logic;
            rst   : in std_logic;
            s1   : in std_logic;
            s2   : in std_logic;
            count : out std_logic_vector(15 downto 0)
        );
    end component;

    -- Signals for interfacing with the component
    signal clk   : std_logic := '0';
    signal rst   : std_logic;
    signal s1   : std_logic;
    signal s2   : std_logic;
    signal count : std_logic_vector(15 downto 0);

    -- Clock generation
    constant clk_period : time := 10 ns;
begin
    -- Clock process
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Instantiate the counter
    uut: counter
        port map (
            clk   => clk,
            rst   => rst,
            s1   => s1,
            s2   => s2,
            count => count
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset
        rst <= '1';
        s1 <= '0';
        s2 <= '0';
        wait for 2 * clk_period;
        rst <= '0';
        
        -- Incrementing the counter
        s1 <= '1';
        wait for 16 * clk_period;
        s1 <= '0';

        wait for 50ns;
        s1 <= '1';
        wait for 50ns;
        s1 <= '0';

        wait for 50ns;
        s1 <= '1';
        wait for 50ns;
        s1 <= '0';
        
        wait for 50ns;
        s1 <= '1';
        wait for 50ns;
        s1 <= '0';
        
        wait for 50ns;
        s2 <= '1';
        wait for 50ns;
        s2 <= '0';
        
        wait for 50ns;
        s2 <= '1';
        wait for 50ns;
        s2 <= '0';
        
        wait for 10 * clk_period;  -- Observe final outputs
        wait;  -- Wait indefinitely (stops simulation)
    end process;
end test;
