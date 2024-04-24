library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

entity sensor is
    Port (
        clk : in STD_LOGIC; 
        trig : out STD_LOGIC; 
        echo : in STD_LOGIC; 
        sensor_out : out STD_LOGIC;
        led_green : out std_logic;
        led_red : out std_logic;
        distance : out std_logic_vector(15 downto 0)
    );
end sensor;

architecture Behavioral of sensor is
    signal echo_start : boolean := false;
    signal timer : integer := 0;
    signal sig_distance : integer := 0;
    signal sensor_sig : std_logic := '0';
    
    constant trigger_pulse_duration : integer := 10; 
    constant trigger_interval_duration : integer := 20;
    signal trig_timer : integer := 0;
    signal sig_led_green : std_logic := '0'; 
    signal sig_led_red : std_logic := '1';
    type states is (otevreno, zavreno);
    signal state : states;

begin

    ultrasonic_process: process(clk)
    begin
        if rising_edge(clk) then
            if echo = '1' and not echo_start then
                echo_start <= true;
                timer <= 0;
           elsif echo = '0' and echo_start then
                echo_start <= false;
                sig_distance <= (timer * 17) / 10;  
                if sig_distance <= 10 then
                    state <= otevreno;
                    sensor_sig <= '0'; 
                    if sig_distance = 6 then
                        state <= zavreno;
                        sensor_sig <= '1';
                    end if;
                else
                    state <= zavreno; 
                    sensor_sig <= '0';
                end if;
        end if;

            if echo_start then
                timer <= timer + 1;
            end if;
        end if;
        distance <= std_logic_vector(to_unsigned(sig_distance, 16));
    end process;

    sensor_out <= sensor_sig;

    trig_process: process(clk)
    begin
        if rising_edge(clk) then
            if trig_timer < trigger_pulse_duration then
                trig <= '1';
            else
                trig <= '0';
            end if;

            if trig_timer >= trigger_interval_duration then
                trig_timer <= 0;
            else
                trig_timer <= trig_timer + 1;
            end if;
        end if;
    end process;

    state_process : process(clk)
    begin
        if rising_edge(clk) then
            case state is
                when zavreno =>
                    sig_led_green <= '0';
                    sig_led_red <= '1';
                when otevreno =>
                    sig_led_green <= '1';
                    sig_led_red <= '0';
            end case;
        end if;
    end process;

    led_green <= sig_led_green;
    led_red <= sig_led_red;

end Behavioral;
