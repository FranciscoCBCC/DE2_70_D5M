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
		 
		 DE2_70_VGA_CLK_OUT_CLK_CLK                                 : out   std_logic;             -- clk
       DE2_70_AV_CONFIG_EXTERNAL_INTERFACE_SDAT                   : inout std_logic;             -- SDAT
       DE2_70_AV_CONFIG_EXTERNAL_INTERFACE_SCLK                   : out   std_logic;             -- SCLK
       DE2_70_VIDEO_IN_DECODER_EXTERNAL_INTERFACE_PIXEL_CLK       : in    std_logic;             -- PIXEL_CLK
       DE2_70_VIDEO_IN_DECODER_EXTERNAL_INTERFACE_LINE_VALID      : in    std_logic;             -- LINE_VALID
       DE2_70_VIDEO_IN_DECODER_EXTERNAL_INTERFACE_FRAME_VALID     : in    std_logic;             -- FRAME_VALID
       DE2_70_VIDEO_IN_DECODER_EXTERNAL_INTERFACE_PIXEL_CLK_RESET : in    std_logic;             -- pixel_clk_reset
       DE2_70_VIDEO_IN_DECODER_EXTERNAL_INTERFACE_PIXEL_DATA      : in    std_logic_vector(11 downto 0) := (others => 'X')  -- PIXEL_DATA
		
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
            sram_CLK      : out   std_logic;                                         -- CLK
				
				vga_clk_out_clk_clk                                 : out   std_logic;             -- clk
            av_config_external_interface_SDAT                   : inout std_logic;             -- SDAT
            av_config_external_interface_SCLK                   : out   std_logic;             -- SCLK
            video_in_decoder_external_interface_PIXEL_CLK       : in    std_logic;             -- PIXEL_CLK
            video_in_decoder_external_interface_LINE_VALID      : in    std_logic;             -- LINE_VALID
            video_in_decoder_external_interface_FRAME_VALID     : in    std_logic;             -- FRAME_VALID
            video_in_decoder_external_interface_pixel_clk_reset : in    std_logic;             -- pixel_clk_reset
            video_in_decoder_external_interface_PIXEL_DATA      : in    std_logic_vector(11 downto 0) := (others => 'X')  -- PIXEL_DATA
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
					sram_CLK      => DE2_70_SRAM_CLK,      --     .CLK
					
					vga_clk_out_clk_clk                                 => DE2_70_VGA_CLK_OUT_CLK_CLK,                                 --  vga_clk_out_clk.clk
					av_config_external_interface_SDAT                   => DE2_70_AV_CONFIG_EXTERNAL_INTERFACE_SDAT,                   --  av_config_external_interface.SDAT
					av_config_external_interface_SCLK                   => DE2_70_AV_CONFIG_EXTERNAL_INTERFACE_SCLK,                   --  .SCLK
					video_in_decoder_external_interface_PIXEL_CLK       => DE2_70_VIDEO_IN_DECODER_EXTERNAL_INTERFACE_PIXEL_CLK,       --  video_in_decoder_external_interface.PIXEL_CLK
					video_in_decoder_external_interface_LINE_VALID      => DE2_70_VIDEO_IN_DECODER_EXTERNAL_INTERFACE_LINE_VALID,      --  .LINE_VALID
					video_in_decoder_external_interface_FRAME_VALID     => DE2_70_VIDEO_IN_DECODER_EXTERNAL_INTERFACE_FRAME_VALID,     --  .FRAME_VALID
					video_in_decoder_external_interface_pixel_clk_reset => DE2_70_VIDEO_IN_DECODER_EXTERNAL_INTERFACE_PIXEL_CLK_RESET, --  .pixel_clk_reset
					video_in_decoder_external_interface_PIXEL_DATA      => DE2_70_VIDEO_IN_DECODER_EXTERNAL_INTERFACE_PIXEL_DATA       --  .PIXEL_DATA
			  );
END Structure;