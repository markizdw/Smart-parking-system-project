library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_level_tb is
end top_level_tb;

architecture behavior of top_level_tb is

    -- Component Declaration for the top_level
    component top_level
        Port (
            CLK100MHZ : in  std_logic;                   
            BTNC      : in  std_logic;                    
            echo1     : in  std_logic;                    
            echo2     : in  std_logic;                    
            trig1     : out std_logic;                   
            trig2     : out std_logic;                  
            CA        : out std_logic;                   
            CB        : out std_logic;                    
            CC        : out std_logic;                   
            CD        : out std_logic;                   
            CE        : out std_logic;                    
            CF        : out std_logic;                  
            CG        : out std_logic;                
            DP        : out std_logic;                  
            AN        : out std_logic_vector(7 downto 0);
            LED16_G   : out std_logic;
            LED16_R   : out std_logic;
            LED17_G   : out std_logic;
            LED17_R   : out std_logic;
            display_select : in std_logic
        );
    end component;

    signal CLK100MHZ, BTNC, echo1, echo2, display_select : std_logic := '0';
    signal trig1, trig2, CA, CB, CC, CD, CE, CF, CG, DP : std_logic;
    signal AN : std_logic_vector(7 downto 0);
    signal LED16_G, LED16_R, LED17_G, LED17_R : std_logic;

    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: top_level
        port map (
            CLK100MHZ => CLK100MHZ,
            BTNC => BTNC,
            echo1 => echo1,
            echo2 => echo2,
            trig1 => trig1,
            trig2 => trig2,
            CA => CA,
            CB => CB,
            CC => CC,
            CD => CD,
            CE => CE,
            CF => CF,
            CG => CG,
            DP => DP,
            AN => AN,
            LED16_G => LED16_G,
            LED16_R => LED16_R,
            LED17_G => LED17_G,
            LED17_R => LED17_R,
            display_select => display_select
        );

    -- Clock process definitions
    clock_process: process
    begin
        while True loop
            CLK100MHZ <= '0';
            wait for clk_period / 2;
            CLK100MHZ <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus process
    stim_proc: process
    begin

        BTNC <= '1';
        wait for 100 ns;
        BTNC <= '0';
        wait for 100 ns;

        trig1 <= '1';
        wait for 10 ns;
        trig1 <= '0';
        wait for 10 ns;
        echo1 <= '1';
        wait for 30 ns; 
        echo1 <= '0';

   
        trig2 <= '1';
        wait for 10 ns;
        trig2 <= '0';
        wait for 15 ns; 
        echo2 <= '1';
        wait for 40 ns;
        echo2 <= '0';

   
        display_select <= '1'; 
        wait for 100 ns;
        display_select <= '0';
        wait for 100 ns;

        wait;
    end process;

end behavior;
