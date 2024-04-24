library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity display_tb is

end display_tb;

architecture sim of display_tb is

    
    component display
        Port (
            clk     : in  std_logic;
            rst     : in  std_logic;
            bin     : in  std_logic_vector(15 downto 0);
            seg     : out std_logic_vector(6 downto 0);
            dp      : out std_logic;
            an      : out std_logic_vector(3 downto 0)
        );
    end component;

   
    signal clk   : std_logic := '0';
    signal rst   : std_logic;
    signal bin   : std_logic_vector(15 downto 0);
    signal seg   : std_logic_vector(6 downto 0);
    signal dp    : std_logic;
    signal an    : std_logic_vector(3 downto 0);

    
    constant clk_period : time := 10 ns;
begin

    
    uut: display
        port map (
            clk   => clk,
            rst   => rst,
            bin   => bin,
            seg   => seg,
            dp    => dp,
            an    => an
        );

    
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;


    stim_proc: process
    begin
      
        rst <= '1';
        bin <= (others => '0');
        wait for 100 ns;  
        rst <= '0';

        
        bin <= x"0001"; 
        wait for 40 ns;
        bin <= x"0002";  
        wait for 40 ns;
        bin <= x"0003";  
        wait for 40 ns;
        bin <= x"0004"; 
        wait for 40 ns;
        bin <= x"FFFF"; 
        wait for 40 ns;

        
        wait;
    end process;

end sim;
