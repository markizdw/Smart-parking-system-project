library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sensor is
    Port (
        clk : in STD_LOGIC;  -- Clock de 100MHz
        trig : out STD_LOGIC;  -- Pino Trigger do HC-SR04
        echo : in STD_LOGIC;  -- Pino Echo do HC-SR04
        sensor_out : out STD_LOGIC;
        led_green : out std_logic;
        led_red : out std_logic;
        distance : out std_logic_vector(15 downto 0)
    );
end sensor;

architecture Behavioral of sensor is

    signal last_echo : STD_LOGIC := '0';  -- Sinal para armazenar o último estado de 'echo'
    signal echo_start : boolean := false;
    signal timer : unsigned(15 downto 0) := (others => '0');
    signal sig_distance : unsigned(15 downto 0) := (others => '0');
    signal sensor_sig : std_logic := '0';
    
    constant trigger_pulse_duration : natural := 10;  -- 10 us pulse duration (1000 cycles at 100 MHz)
    constant trigger_interval_duration : natural := 20;  -- 60 ms interval duration (6000000 cycles at 100 MHz)
    signal trig_timer : natural := 0;  -- Counter for triggering the pulse
    signal pulse_active : std_logic := '0';  -- To control pulse generation

    signal sig_led_green, sig_led_red : std_logic;
    
    type states is (otevreno, zavreno);
    signal state : states;
begin
    -- Ultrasonic measurement process
    ultrasonic_process: process(clk)
  begin
    if rising_edge(clk) then
        -- Atualiza o estado anterior de 'echo'
        last_echo <= echo;

        if echo = '1' and not echo_start then
            -- Início do pulso de 'echo'
            echo_start <= true;
            state <= zavreno;
            timer <= (others => '0');
            state <= zavreno;
        elsif last_echo = '1' and echo = '0' then
            -- Fim do pulso de 'echo', borda de descida detectada
            echo_start <= false;
            sig_distance <= timer / 58;  -- Convers?o de tempo para distância
            if sig_distance <= 15 then
                state <= otevreno;
            elsif sig_distance = 5 then
                sensor_sig <= '1';
                state <= zavreno;
            end if;
        else
            sensor_sig <= '0';  -- Reseta 'sensor_sig' se n?o houver borda de descida
        end if;
        
        if echo_start then
            -- Contagem do tempo enquanto 'echo' está alto
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
                trig <= '1';  -- Trigger is high for 10 us
                pulse_active <= '1';
            elsif trig_timer >= trigger_pulse_duration and trig_timer < trigger_interval_duration then
                trig <= '0';  -- Trigger is low for the rest of the interval
            end if;

            if trig_timer = trigger_interval_duration then
                trig_timer <= 0;  -- Reset the timer after 60 ms
                pulse_active <= '0';
            else
                trig_timer <= trig_timer + 1;  -- Increment the timer
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
