library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Test bench entity declaration
entity top_level_tb is
-- No ports are required for a test bench entity
end top_level_tb;

architecture tb of top_level_tb is
    
    -- Component Declaration of the Unit Under Test (UUT)
    component top_level
        Port (
            clk       : in  std_logic;
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
            an1       : out std_logic_vector(3 downto 0);
            an2       : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Internal Signals to simulate inputs and observe outputs
    signal clk       : std_logic := '0';
    signal BTNC      : std_logic := '1';
    signal echo1     : std_logic := '0';
    signal echo2     : std_logic := '0';
    signal trig1     : std_logic;
    signal trig2     : std_logic;
    signal CA, CB, CC, CD, CE, CF, CG, DP : std_logic;
    signal an1, an2 : std_logic_vector(3 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: top_level
        port map (
            clk => clk,
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
            an1 => an1,
            an2 => an2
        );

    -- Clock generation
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;  -- 100 MHz Clock
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

    -- Reset Pulse Generation
    reset_process : process
    begin
        BTNC <= '1';
        wait for 20 ns;  -- Assert reset for 20 ns
        BTNC <= '0';
        wait for 10 ns;  -- Deassert to allow operation
        BTNC <= '1';
        wait;
    end process;

    -- Stimulus Process for Echo Signals
    stimulus_process : process
    begin
        -- Wait for reset to complete
        wait for 30 ns;

        -- Simulate echo signal from sensor 1
        echo1 <= '1';
        wait for 60 ns;  -- Echo pulse width
        echo1 <= '0';

        wait for 500 ns;  -- Wait some time before next signal

        -- Simulate echo signal from sensor 2
        echo2 <= '1';
        wait for 70 ns;  -- Different echo pulse width for sensor 2
        echo2 <= '0';

        wait;  -- Hold simulation
    end process;

end tb;
