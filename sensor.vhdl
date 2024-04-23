library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

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

    signal last_echo : STD_LOGIC := '0'; 
    signal echo_start : boolean := false;
    signal timer : unsigned(15 downto 0) := (others => '0');
    signal sig_distance : unsigned(15 downto 0) := (others => '0');
    signal sensor_sig : std_logic := '0';
    
    constant trigger_pulse_duration : natural := 10;  
    constant trigger_interval_duration : natural := 20;  
    signal trig_timer : natural := 0; 
    signal pulse_active : std_logic := '0'; 

    signal sig_led_green, sig_led_red : std_logic;
    
    type states is (otevreno, zavreno);
    signal state : states;
begin
  
    ultrasonic_process: process(clk)
  begin
    if rising_edge(clk) then
       
        last_echo <= echo;

        if echo = '1' and not echo_start then
       
            echo_start <= true;
            state <= zavreno;
            timer <= (others => '0');
            state <= zavreno;
        elsif last_echo = '1' and echo = '0' then
       
            echo_start <= false;
            sig_distance <= timer / 58;  
            if sig_distance <= 15 then
                state <= otevreno;
            elsif sig_distance = 5 then
                sensor_sig <= '1';
                state <= zavreno;
            end if;
        else
            sensor_sig <= '0'; 
        end if;
        
        if echo_start then
           
            timer <= timer + 1;
        end if;
    end if;
    distance <= std_logic_vector(sig_distance); 
end process;
  
    sensor_out <= sensor_sig;
    
    trig_process: process(clk)
    begin
        if rising_edge(clk) then
            if trig_timer < trigger_pulse_duration then
                trig <= '1';  
                pulse_active <= '1';
            elsif trig_timer >= trigger_pulse_duration and trig_timer < trigger_interval_duration then
                trig <= '0';  
            end if;

            if trig_timer = trigger_interval_duration then
                trig_timer <= 0; 
                pulse_active <= '0';
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
