library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity counter is
    generic (
        nbit : integer := 16  
    );
    Port ( 
        clk : in  std_logic;  
        rst : in  std_logic;   
        s1  : in  std_logic;   
        s2  : in  std_logic;   
        count : out std_logic_vector(nbit - 1 downto 0) 
    );
end counter;

architecture Behavioral of counter is
    signal sig_count : unsigned(15 downto 0) := (others => '0');
    signal s1_prev : std_logic := '0';
    signal s2_prev : std_logic := '0';
begin

    process(clk, rst)
    begin
        if rst = '1' then
            s1_prev <= '0';
            s2_prev <= '0';  
        elsif rising_edge(clk) then
            s1_prev <= s1;  
            s2_prev <= s2; 
            if s1 = '1' and s1_prev = '0' then  
                if sig_count < 15 then
                    sig_count <= sig_count + 1; 
                else
                    sig_count <= (others => '0');
                end if;
            elsif s2 = '1' and s2_prev = '0' then 
                if sig_count > 0 then
                    sig_count <= sig_count - 1;
                 else
                    sig_count <= to_unsigned (15, 16);
                 end if;
            end if;
        end if;
    end process;

    
    count <= std_logic_vector(sig_count);

end Behavioral;
