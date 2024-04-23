library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_level is
    Port (
        CLK100MHZ : in  std_logic;                    -- Clock principal
        BTNC      : in  std_logic;                    -- Reset geral
        echo1     : in  std_logic;                    -- Echo sensor 1
        echo2     : in  std_logic;                    -- Echo sensor 2
        trig1     : out std_logic;                    -- Trigger sensor 1
        trig2     : out std_logic;                    -- Trigger sensor 2
        CA        : out   std_logic;                    --! Cathode of segment A
        CB        : out   std_logic;                    --! Cathode of segment B
        CC        : out   std_logic;                    --! Cathode of segment C
        CD        : out   std_logic;                    --! Cathode of segment D
        CE        : out   std_logic;                    --! Cathode of segment E
        CF        : out   std_logic;                    --! Cathode of segment F
        CG        : out   std_logic;                    --! Cathode of segment G
        DP        : out   std_logic;                    --! Decimal point
        AN        : out std_logic_vector(7 downto 0);
        LED16_G   : out std_logic;
        LED16_R   : out std_logic;
        LED17_G   : out std_logic;
        LED17_R   : out std_logic;
        display_select : in std_logic
    );
end top_level;

architecture Behavioral of top_level is
    
    -- Component Declarations
    component sensor is
      Port (
            clk : in STD_LOGIC;  -- Clock
            trig : out STD_LOGIC;  -- Pino Trigger do HC-SR04
            echo : in STD_LOGIC;  -- Pino Echo do HC-SR04
            sensor_out : out STD_LOGIC;  -- Sinal processado do sensor
            led_green : out STD_LOGIC;
            led_red : out STD_LOGIC;
            distance : out std_logic_vector(15 downto 0)
        );
    end component;
    
    component counter is
      generic(
        nbit : integer := 16  -- Número de bits do contador aumentado para suportar 4 dígitos BCD
      );
      Port ( 
        clk : in std_logic;
        rst : in std_logic;
        s1 : in std_logic;
        s2 : in std_logic;
        count : out std_logic_vector(nbit - 1 downto 0)
      );
    end component;
    
    component display is
            port (
                clk   : in  std_logic;
                rst   : in  std_logic;
                bin   : in  std_logic_vector(15 downto 0);  -- Entrada binária ajustada para 4 dígitos
                seg   : out std_logic_vector(6 downto 0);
                dp    : out std_logic;
                an    : out std_logic_vector(3 downto 0)
            );
   end component;

    -- Internal Signals
    signal sig_s1, sig_s2 : std_logic;
    signal sig_tmp : std_logic_vector(15 downto 0); -- Ajustado para 4 dígitos
    signal sig_distance1, sig_distance2 : std_logic_vector(15 downto 0); -- Separate distance signals
    signal CA1, CB1, CC1, CD1, CE1, CF1, CG1, DP1, CA2, CB2, CC2, CD2, CE2, CF2, CG2, DP2 : std_logic;

begin
    -- Sensor Instances
    sensor1 : sensor
        port map (
            clk => CLK100MHZ,
            trig => trig1,
            echo => echo1,
            sensor_out => sig_s1,
            led_green => LED16_G,
            led_red => LED16_R,
            distance => sig_distance1
            
        );
        
    sensor2 : sensor
        port map (
            clk => CLK100MHZ,
            trig => trig2,
            echo => echo2,
            led_green => LED17_G,
            led_red => LED17_R,
            sensor_out => sig_s2,
            distance => sig_distance2
        );
    -- Counter Instances
    count : counter
        generic map (
            nbit => 16  -- Define a largura do contador
        )
        Port map( 
            clk => CLK100MHZ,  
            rst => BTNC,   
            s1  => sig_s1,   
            s2  => sig_s2,  
            count => sig_tmp
        );
        
    -- Display Instances
    display1 : display
        port map (
            clk   => CLK100MHZ,
            rst   => BTNC,
            bin   => sig_tmp,
            seg(6)   => CA1,
            seg(5)   => CB1,
            seg(4)   => CC1,
            seg(3)   => CD1,
            seg(2)   => CE1,
            seg(1)   => CF1,
            seg(0)   => CG1,
            dp    => DP1,
            an    => AN(3 downto 0)
        );
    
    display2 : display
        port map (
            clk   => CLK100MHZ,
            rst   => BTNC,
            bin   => sig_distance1,
            seg(6)   => CA2,
            seg(5)   => CB2,
            seg(4)   => CC2,
            seg(3)   => CD2,
            seg(2)   => CE2,
            seg(1)   => CF2,
            seg(0)   => CG2,
            dp    => DP2,
            an    => AN(7 downto 4)
        );
        
        CA <= CA1 when display_select = '0' else CA2;
        CB <= CB1 when display_select = '0' else CB2;
        CC <= CC1 when display_select = '0' else CC2;
        CD <= CD1 when display_select = '0' else CD2;
        CE <= CE1 when display_select = '0' else CE2;
        CF <= CF1 when display_select = '0' else CF2;
        CG <= CG1 when display_select = '0' else CG2;
        DP <= DP1 when display_select = '0' else DP2;
        
end Behavioral;
