library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Para manipulaç?o de números

entity display is
    Port (
        clk     : in  std_logic;             -- Clock principal
        rst     : in  std_logic;             -- Reset
        bin     : in  std_logic_vector(15 downto 0); -- Entrada binária (4 dígitos BCD)
        seg     : out std_logic_vector(6 downto 0);  -- Saídas para os segmentos (A-G)
        dp      : out std_logic;             -- Saída para o ponto decimal (DP)
        an      : out std_logic_vector(3 downto 0)  -- Ânodos para cada dígito (multiplexaç?o)
    );
end display;

architecture Behavioral of display is
    signal digit_index : integer range 0 to 3 := 0;  -- Controla qual dígito está ativo
    signal current_digit : std_logic_vector(3 downto 0);  -- Dígito atual sendo exibido

-- Funç?o para decodificar dígito BCD para 7 segmentos
function decode_digit(digit : std_logic_vector(3 downto 0)) return std_logic_vector is
    variable seg : std_logic_vector(6 downto 0); -- 7 segmentos A-G
begin
    case digit is
        when "0000" => seg := "0000001"; -- 0
        when "0001" => seg := "1001111"; -- 1
        when "0010" => seg := "0010010"; -- 2
        when "0011" => seg := "0000110"; -- 3
        when "0100" => seg := "1001100"; -- 4
        when "0101" => seg := "0100100"; -- 5
        when "0110" => seg := "0100000"; -- 6
        when "0111" => seg := "0001111"; -- 7
        when "1000" => seg := "0000000"; -- 8
        when "1001" => seg := "0000100"; -- 9
        when others => seg := "1111111"; -- Apaga o display ou define para 'E' para erro
    end case;
    return seg;
end decode_digit;

begin
    -- Processo de multiplexaç?o dos dígitos
    digit_control: process(clk, rst)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                digit_index <= 0;
            else
                digit_index <= (digit_index + 1) mod 4;
            end if;
        end if;
    end process;

    -- Atualiza o ânodo e o segmento baseado no dígito ativo
    anode_segment_control: process(clk)
    begin
        if rising_edge(clk) then
            case digit_index is
                when 0 => 
                    an <= "1110";
                    current_digit <= bin(3 downto 0);
                when 1 => 
                    an <= "1101";
                    current_digit <= bin(7 downto 4);
                when 2 => 
                    an <= "1011";
                    current_digit <= bin(11 downto 8);
                when 3 => 
                    an <= "0111";
                    current_digit <= bin(15 downto 12);
                when others =>
                    an <= "1111";  -- Todos os dígitos desligados
            end case;
            seg <= decode_digit(current_digit);  -- Chama a funç?o para decodificar o dígito
            dp <= '1';  -- Ponto decimal desativado
        end if;
    end process;


end Behavioral;
