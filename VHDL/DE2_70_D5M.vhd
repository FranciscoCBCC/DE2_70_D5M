LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.ALL;

ENTITY DE2_70_D5M IS 																					  --É a parte principal do projeto, é a interface do Sistema que descreve as entradas e saídas. Composta de duas partes: parameters e connections. Parameters refere-se aos parâmetros, exemplo largura de barramento, são declarados como generics. Connections por sua vez, refere-se como ocorre a transferência de informações, são declarados como ports.
	PORT (
		 CLOCK_50 				 : IN STD_LOGIC; 									  					  -- clk
		 KEY						 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);         				     --reset	
		 DE2_70_VGA_CLK       : out   std_logic;                                        -- CLK
		 DE2_70_VGA_HS        : out   std_logic;                                        -- HS
		 DE2_70_VGA_VS        : out   std_logic;                                        -- VS
		 DE2_70_VGA_BLANK     : out   std_logic;                                        -- BLANK
		 DE2_70_VGA_SYNC      : out   std_logic;                                        -- SYNC
		 DE2_70_VGA_R         : out   std_logic_vector(9 downto 0);                     -- R
		 DE2_70_VGA_G         : out   std_logic_vector(9 downto 0);                     -- G
		 DE2_70_VGA_B         : out   std_logic_vector(9 downto 0);                     -- B
		 DE2_70_SRAM_DQ       : inout std_logic_vector(31 downto 0) := (others => 'X'); -- DQ
		 DE2_70_SRAM_DPA      : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- DPA
		 DE2_70_SRAM_ADDR     : out   std_logic_vector(18 downto 0);                    -- ADDR
		 DE2_70_SRAM_ADSC_N   : out   std_logic;                                        -- ADSC_N
		 DE2_70_SRAM_ADSP_N   : out   std_logic;                                        -- ADSP_N
		 DE2_70_SRAM_ADV_N    : out   std_logic;                                        -- ADV_N
		 DE2_70_SRAM_BE_N     : out   std_logic_vector(3 downto 0);                     -- BE_N
		 DE2_70_SRAM_CE1_N    : out   std_logic;                                        -- CE1_N
		 DE2_70_SRAM_CE2      : out   std_logic;                                        -- CE2
		 DE2_70_SRAM_CE3_N    : out   std_logic;                                        -- CE3_N
		 DE2_70_SRAM_GW_N     : out   std_logic;                                        -- GW_N
		 DE2_70_SRAM_OE_N     : out   std_logic;                                        -- OE_N
		 DE2_70_SRAM_WE_N     : out   std_logic;                                        -- WE_N
		 DE2_70_SRAM_CLK      : out   std_logic;                                        -- CLK
		
		 DE2_70_GPIO_1		  	 : inout std_logic_vector(29 downto 0);	
		 
		 --DE2_70_VGA_CLK_OUT_CLK_CLK                                 : out   std_logic;             -- clk
       --DE2_70_AV_CONFIG_EXTERNAL_INTERFACE_SDAT                   : inout std_logic;             -- SDAT
       --DE2_70_AV_CONFIG_EXTERNAL_INTERFACE_SCLK                   : out   std_logic;             -- SCLK
       --DE2_70_VIDEO_IN_DECODER_EXTERNAL_INTERFACE_PIXEL_CLK       : in    std_logic;             -- PIXEL_CLK
       --DE2_70_VIDEO_IN_DECODER_EXTERNAL_INTERFACE_LINE_VALID      : in    std_logic;             -- LINE_VALID
       --DE2_70_VIDEO_IN_DECODER_EXTERNAL_INTERFACE_FRAME_VALID     : in    std_logic;             -- FRAME_VALID
       --DE2_70_VIDEO_IN_DECODER_EXTERNAL_INTERFACE_PIXEL_CLK_RESET : in    std_logic;             -- pixel_clk_reset
       --DE2_70_VIDEO_IN_DECODER_EXTERNAL_INTERFACE_PIXEL_DATA      : in    std_logic_vector(11 downto 0) := (others => 'X')  -- PIXEL_DATA
		 
		 DE2_70_sdram_wire_addr                                     : out   std_logic_vector(12 downto 0);                    -- addr
		 DE2_70_sdram_wire_ba                                       : out   std_logic_vector(1 downto 0);                     -- ba
		 DE2_70_sdram_wire_cas_n                                    : out   std_logic;                                        -- cas_n
		 DE2_70_sdram_wire_cke                                      : out   std_logic;                                        -- cke
		 DE2_70_sdram_wire_cs_n                                     : out   std_logic;                                        -- cs_n
		 DE2_70_sdram_wire_dq                                       : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
		 DE2_70_sdram_wire_dqm                                      : out   std_logic_vector(1 downto 0);                     -- dqm
		 DE2_70_sdram_wire_ras_n                                    : out   std_logic;                                        -- ras_n
		 DE2_70_sdram_wire_we_n                                     : out   std_logic;                                        -- we_n
		 DE2_70_sdram_clk_clk                                       : out   std_logic                                         -- clk
	
);
	END DE2_70_D5M;

ARCHITECTURE Structure OF DE2_70_D5M IS 															--"Structure" pode ser um nome qualquer, a architecture é o corpo do sistema, onde são feitas as atribuições, operações, comparações, etc…
    component de2_70
        port (
            clk_clk       : in    std_logic;									               -- clk
            reset_reset_n : in    std_logic;									               -- reset_n
            vga_CLK       : out   std_logic;                                        -- CLK
            vga_HS        : out   std_logic;                                        -- HS
            vga_VS        : out   std_logic;                                        -- VS
            vga_BLANK     : out   std_logic;                                        -- BLANK
            vga_SYNC      : out   std_logic;                                        -- SYNC
            vga_R         : out   std_logic_vector(9 downto 0);                     -- R
            vga_G         : out   std_logic_vector(9 downto 0);                     -- G
            vga_B         : out   std_logic_vector(9 downto 0);                     -- B
            sram_DQ       : inout std_logic_vector(31 downto 0) := (others => 'X'); -- DQ
            sram_DPA      : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- DPA
            sram_ADDR     : out   std_logic_vector(18 downto 0);                    -- ADDR
            sram_ADSC_N   : out   std_logic;                                        -- ADSC_N
            sram_ADSP_N   : out   std_logic;                                        -- ADSP_N
            sram_ADV_N    : out   std_logic;                                        -- ADV_N
            sram_BE_N     : out   std_logic_vector(3 downto 0);                     -- BE_N
            sram_CE1_N    : out   std_logic;                                        -- CE1_N
            sram_CE2      : out   std_logic;                                        -- CE2
            sram_CE3_N    : out   std_logic;                                        -- CE3_N
            sram_GW_N     : out   std_logic;                                        -- GW_N
            sram_OE_N     : out   std_logic;                                        -- OE_N
            sram_WE_N     : out   std_logic;                                        -- WE_N
            sram_CLK      : out   std_logic;                                        -- CLK
				
				--vga_clk_out_clk_clk                                 : out   std_logic;            								  -- clk
				
            
				sdram_wire_addr                                     : out   std_logic_vector(12 downto 0);                    -- addr
            sdram_wire_ba                                       : out   std_logic_vector(1 downto 0);                     -- ba
            sdram_wire_cas_n                                    : out   std_logic;                                        -- cas_n
            sdram_wire_cke                                      : out   std_logic;                                        -- cke
            sdram_wire_cs_n                                     : out   std_logic;                                        -- cs_n
            sdram_wire_dq                                       : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
            sdram_wire_dqm                                      : out   std_logic_vector(1 downto 0);                     -- dqm
            sdram_wire_ras_n                                    : out   std_logic;                                        -- ras_n
            sdram_wire_we_n                                     : out   std_logic;                                        -- we_n
				sdram_clk_clk													 : out 	std_logic 													  -- clk
        );
    end component;
	 
	 BEGIN
			NiosII : de2_70 										--Instanciação do componente do qsys
				port map (
					clk_clk       => CLOCK_50, 		      --      clk.clk
					reset_reset_n => KEY(0), 					--      reset.reset_n
					vga_CLK       => DE2_70_VGA_CLK,       --      vga.CLK
					vga_HS        => DE2_70_VGA_HS,        --      .HS
					vga_VS        => DE2_70_VGA_VS,        --      .VS
					vga_BLANK     => DE2_70_VGA_BLANK,     --      .BLANK
					vga_SYNC      => DE2_70_VGA_SYNC,      --      .SYNC
					vga_R         => DE2_70_VGA_R,         --      .R
					vga_G         => DE2_70_VGA_G,         --      .G
					vga_B         => DE2_70_VGA_B,         --      .B
					sram_DQ       => DE2_70_SRAM_DQ,       --      sram.DQ
					sram_DPA      => DE2_70_SRAM_DPA,      --      .DPA
					sram_ADDR     => DE2_70_SRAM_ADDR,     --      .ADDR
					sram_ADSC_N   => DE2_70_SRAM_ADSC_N,   --      .ADSC_N
					sram_ADSP_N   => DE2_70_SRAM_ADSP_N,   --      .ADSP_N
					sram_ADV_N    => DE2_70_SRAM_ADV_N,    --      .ADV_N
					sram_BE_N     => DE2_70_SRAM_BE_N,     --      .BE_N
					sram_CE1_N    => DE2_70_SRAM_CE1_N,    --      .CE1_N
					sram_CE2      => DE2_70_SRAM_CE2,      --      .CE2
					sram_CE3_N    => DE2_70_SRAM_CE3_N,    --      .CE3_N
					sram_GW_N     => DE2_70_SRAM_GW_N,     --      .GW_N
					sram_OE_N     => DE2_70_SRAM_OE_N,     --      .OE_N
					sram_WE_N     => DE2_70_SRAM_WE_N,     --      .WE_N
					sram_CLK      => DE2_70_SRAM_CLK,      --      .CLK
					
					--vga_clk_out_clk_clk                               => ,                   		--  vga_clk_out_clk.clk
					
					av_config_external_interface_SDAT                   => DE2_70_GPIO_1(25),        --  av_config_external_interface.SDAT
					av_config_external_interface_SCLK                   => DE2_70_GPIO_1(26),        --  .SCLK
					video_in_decoder_external_interface_PIXEL_CLK       => DE2_70_GPIO_1(0),       	--  video_in_decoder_external_interface.PIXEL_CLK
					video_in_decoder_external_interface_LINE_VALID      => DE2_70_GPIO_1(23),      	--  .LINE_VALID
					video_in_decoder_external_interface_FRAME_VALID     => DE2_70_GPIO_1(24),    		--  .FRAME_VALID
					video_in_decoder_external_interface_pixel_clk_reset => DE2_70_GPIO_1(19), 			--  .pixel_clk_reset
					video_in_decoder_external_interface_PIXEL_DATA(0)   => DE2_70_GPIO_1(15),       	--  .PIXEL_DATA
					video_in_decoder_external_interface_PIXEL_DATA(1)   => DE2_70_GPIO_1(14),	      --  .PIXEL_DATA
					video_in_decoder_external_interface_PIXEL_DATA(2)   => DE2_70_GPIO_1(13),			--  .PIXEL_DATA
					video_in_decoder_external_interface_PIXEL_DATA(3)   => DE2_70_GPIO_1(12),			--  .PIXEL_DATA
					video_in_decoder_external_interface_PIXEL_DATA(4)   => DE2_70_GPIO_1(9),			--  .PIXEL_DATA
					video_in_decoder_external_interface_PIXEL_DATA(5)   => DE2_70_GPIO_1(8),			--  .PIXEL_DATA
					video_in_decoder_external_interface_PIXEL_DATA(6)   => DE2_70_GPIO_1(7),			--  .PIXEL_DATA
					video_in_decoder_external_interface_PIXEL_DATA(7)   => DE2_70_GPIO_1(6),			--  .PIXEL_DATA
					video_in_decoder_external_interface_PIXEL_DATA(8)   => DE2_70_GPIO_1(5),			--  .PIXEL_DATA
					video_in_decoder_external_interface_PIXEL_DATA(9)   => DE2_70_GPIO_1(4),			--  .PIXEL_DATA
					video_in_decoder_external_interface_PIXEL_DATA(10)  => DE2_70_GPIO_1(3),			--  .PIXEL_DATA
					video_in_decoder_external_interface_PIXEL_DATA(11)  => DE2_70_GPIO_1(1),			--  .PIXEL_DATA
					
					sdram_wire_addr 		=> DE2_70_sdram_wire_addr,                                  --  sdram_wire.addr
					sdram_wire_ba  		=> DE2_70_sdram_wire_ba,                                    --  .ba
					sdram_wire_cas_n 		=> DE2_70_sdram_wire_cas_n,                                 --  .cas_n
					sdram_wire_cke       => DE2_70_sdram_wire_cke,                                   --  .cke
					sdram_wire_cs_n      => DE2_70_sdram_wire_cs_n,                                  --  .cs_n
					sdram_wire_dq        => DE2_70_sdram_wire_dq,                                    --  .dq
					sdram_wire_dqm       => DE2_70_sdram_wire_dqm,                                   --  .dqm
					sdram_wire_ras_n     => DE2_70_sdram_wire_ras_n,                                 --  .ras_n
					sdram_wire_we_n      => DE2_70_sdram_wire_we_n,                                  --  .we_n
					sdram_clk_clk			=> DE2_70_sdram_clk_clk                                     --  .clk
			  );
END Structure;