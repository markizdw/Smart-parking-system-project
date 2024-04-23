library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Pacote recomendado para operaç?es aritméticas

entity counter is
    generic (
        nbit : integer := 16  -- Define a largura do contador
    );
    Port ( 
        clk : in  std_logic;   -- Clock input
        rst : in  std_logic;   -- Reset input (active high)
        s1  : in  std_logic;   -- Sensor 1 input (increment on rising edge)
        s2  : in  std_logic;   -- Sensor 2 input (decrement on falling edge)
        count : out std_logic_vector(nbit - 1 downto 0)  -- Counter output
    );
end counter;

architecture Behavioral of counter is
    signal sig_count : unsigned(nbit - 1 downto 0) := (others => '0');

begin

    process(clk, rst)
    begin
        if rst = '1' then
            sig_count <= (others => '0');  -- Asynchronous reset to zero
        elsif rising_edge(clk) then
            -- Edge detection for s1 (increment on rising edge)
            if  s1 = '1' then
                if sig_count /= (2**nbit - 1) then -- Evita overflow
                    sig_count <= sig_count + 1;
                end if;
            end if;

            -- Edge detection for s2 (decrement on falling edge)
            if  s2 = '0' then
                if sig_count /= 0 then -- Evita underflow
                    sig_count <= sig_count - 1;
                end if;
            end if;

        end if;
    end process;

    -- Output the current count, convertendo para std_logic_vector
    count <= std_logic_vector(sig_count);

end Behavioral;
