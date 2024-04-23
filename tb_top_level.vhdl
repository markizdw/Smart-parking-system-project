library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_level_tb is
-- This test bench entity does not have ports.
end top_level_tb;

architecture behavior of top_level_tb is 
    -- Component Declaration for the Unit Under Test (UUT)
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
            display_select : in std_logic;
            sig_out : out std_logic_vector(15 downto 0)
        );
    end component;

    -- Input signals
    signal CLK100MHZ : std_logic := '0';
    signal BTNC : std_logic := '0';
    signal echo1 : std_logic := '0';
    signal echo2 : std_logic := '0';
    signal display_select : std_logic := '0';

    -- Output signals
    signal trig1, trig2 : std_logic;
    signal CA, CB, CC, CD, CE, CF, CG, DP : std_logic;
    signal AN : std_logic_vector(7 downto 0);
    signal LED16_G, LED16_R, LED17_G, LED17_R : std_logic;
    signal sig_out : std_logic_vector(15 downto 0);

    -- Clock period definitions
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
            display_select => display_select,
            sig_out => sig_out
        );

    -- Clock process definitions
    clk_process : process
    begin
        CLK100MHZ <= '0';
        wait for clk_period/2;
        CLK100MHZ <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc : process
    begin  
        -- Initialize Inputs
        BTNC <= '1';
        wait for clk_period*10;  -- Wait for the reset to take effect
        BTNC <= '0';

        wait for clk_period*10;
        echo1 <= '1';
        wait for clk_period*5;
        echo1 <= '0';

        wait for clk_period*10;
        echo2 <= '1';
        wait for clk_period*5;
        echo2 <= '0';

        wait for clk_period*10;
        display_select <= '1'; -- Change display output

        wait for clk_period*10;
        display_select <= '0'; -- Change display output back

        wait;
    end process;
end behavior;
