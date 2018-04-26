LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.ALL;

ENTITY DE2_70_D5M IS
	PORT (
			CLOCK_50                                        		     : IN    STD_LOGIC;  						             		   -- clk
			KEY			                                    		     : IN    STD_LOGIC_VECTOR(3 DOWNTO 0);		               -- reset
			GPIO_1																	  : INOUT STD_LOGIC_VECTOR(35 DOWNTO 0);						   -- GPIO_1	
			--GPIO_CLKIN_N1														  	  : IN    STD_LOGIC; -- VERIFICAR NECESSIDADE DISSO
			DE2_70_PIXEL_BUFFER_EXTERNAL_INTERFACE_DQ                  : INOUT STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => 'X'); -- DQ
			DE2_70_PIXEL_BUFFER_EXTERNAL_INTERFACE_DPA                 : INOUT STD_LOGIC_VECTOR(3 DOWNTO 0)  := (OTHERS => 'X'); -- DPA
			DE2_70_PIXEL_BUFFER_EXTERNAL_INTERFACE_ADDR                : OUT   STD_LOGIC_VECTOR(18 DOWNTO 0);                    -- ADDR
			DE2_70_PIXEL_BUFFER_EXTERNAL_INTERFACE_ADSC_N              : OUT   STD_LOGIC;                                        -- ADSC_N
			DE2_70_PIXEL_BUFFER_EXTERNAL_INTERFACE_ADSP_N              : OUT   STD_LOGIC;                                        -- ADSP_N
			DE2_70_PIXEL_BUFFER_EXTERNAL_INTERFACE_ADV_N               : OUT   STD_LOGIC;                                        -- ADV_N
			DE2_70_PIXEL_BUFFER_EXTERNAL_INTERFACE_BE_N                : OUT   STD_LOGIC_VECTOR(3 DOWNTO 0);                     -- BE_N
			DE2_70_PIXEL_BUFFER_EXTERNAL_INTERFACE_CE1_N               : OUT   STD_LOGIC;                                        -- CE1_N
			DE2_70_PIXEL_BUFFER_EXTERNAL_INTERFACE_CE2                 : OUT   STD_LOGIC;                                        -- CE2
			DE2_70_PIXEL_BUFFER_EXTERNAL_INTERFACE_CE3_N               : OUT   STD_LOGIC;                                        -- CE3_N
			DE2_70_PIXEL_BUFFER_EXTERNAL_INTERFACE_GW_N                : OUT   STD_LOGIC;                                        -- GW_N
			DE2_70_PIXEL_BUFFER_EXTERNAL_INTERFACE_OE_N                : OUT   STD_LOGIC;                                        -- OE_N
			DE2_70_PIXEL_BUFFER_EXTERNAL_INTERFACE_WE_N                : OUT   STD_LOGIC;                                        -- WE_N
			DE2_70_PIXEL_BUFFER_EXTERNAL_INTERFACE_CLK                 : OUT   STD_LOGIC;                                        -- CLK
			DE2_70_VGA_CONTROLLER_EXTERNAL_INTERFACE_CLK               : OUT   STD_LOGIC;                                        -- CLK
			DE2_70_VGA_CONTROLLER_EXTERNAL_INTERFACE_HS                : OUT   STD_LOGIC;                                        -- HS
			DE2_70_VGA_CONTROLLER_EXTERNAL_INTERFACE_VS                : OUT   STD_LOGIC;                                        -- VS
			DE2_70_VGA_CONTROLLER_EXTERNAL_INTERFACE_BLANK             : OUT   STD_LOGIC;                                        -- BLANK
			DE2_70_VGA_CONTROLLER_EXTERNAL_INTERFACE_SYNC              : OUT   STD_LOGIC;                                        -- SYNC
			DE2_70_VGA_CONTROLLER_EXTERNAL_INTERFACE_R                 : OUT   STD_LOGIC_VECTOR(9 DOWNTO 0);                     -- R
			DE2_70_VGA_CONTROLLER_EXTERNAL_INTERFACE_G                 : OUT   STD_LOGIC_VECTOR(9 DOWNTO 0);                     -- G
			DE2_70_VGA_CONTROLLER_EXTERNAL_INTERFACE_B                 : OUT   STD_LOGIC_VECTOR(9 DOWNTO 0);                     -- B
			DE2_70_SDRAM_CLK                                           : OUT   STD_LOGIC;                                        -- CLK
			DE2_70_SDRAM_WIRE_ADDR                                     : OUT   STD_LOGIC_VECTOR(12 DOWNTO 0);                    -- ADDR
         DE2_70_SDRAM_WIRE_BA                                       : OUT   STD_LOGIC_VECTOR(1 DOWNTO 0);                     -- BA
         DE2_70_SDRAM_WIRE_CAS_N                                    : OUT   STD_LOGIC;                                        -- CAS_N
         DE2_70_SDRAM_WIRE_CKE                                      : OUT   STD_LOGIC;                                        -- CKE
         DE2_70_SDRAM_WIRE_CS_N                                     : OUT   STD_LOGIC;                                        -- CS_N
         DE2_70_SDRAM_WIRE_DQ                                       : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => 'X'); -- DQ
         DE2_70_SDRAM_WIRE_DQM                                      : OUT   STD_LOGIC_VECTOR(1 DOWNTO 0);                     -- DQM
         DE2_70_SDRAM_WIRE_RAS_N                                    : OUT   STD_LOGIC;                                        -- RAS_N
         DE2_70_SDRAM_WIRE_WE_N                                     : OUT   STD_LOGIC                                         -- WE_N
			

	);
END DE2_70_D5M;

ARCHITECTURE Structure OF DE2_70_D5M IS
	
    component de2_70 is
        port (
            clk_clk                                             : in    STD_LOGIC                     := 'X';             -- clk
            reset_reset_n                                       : in    STD_LOGIC                     := 'X';             -- reset_n
				sdram_clk                                           : out   std_logic;                                        -- clk
            av_config_external_interface_SDAT                   : inout STD_LOGIC                     := 'X';             -- SDAT
            av_config_external_interface_SCLK                   : out   STD_LOGIC;                                        -- SCLK
            video_in_decoder_external_interface_PIXEL_CLK       : in    STD_LOGIC                     := 'X';             -- PIXEL_CLK
            video_in_decoder_external_interface_LINE_VALID      : in    STD_LOGIC                     := 'X';             -- LINE_VALID
            video_in_decoder_external_interface_FRAME_VALID     : in    STD_LOGIC                     := 'X';             -- FRAME_VALID
            video_in_decoder_external_interface_pixel_clk_reset : in    STD_LOGIC                     := 'X';             -- pixel_clk_reset
            video_in_decoder_external_interface_PIXEL_DATA      : in    STD_LOGIC_VECTOR(11 downto 0) := (others => 'X'); -- PIXEL_DATA
            pixel_buffer_external_interface_DQ                  : inout STD_LOGIC_VECTOR(31 downto 0) := (others => 'X'); -- DQ
            pixel_buffer_external_interface_DPA                 : inout STD_LOGIC_VECTOR(3 downto 0)  := (others => 'X'); -- DPA
            pixel_buffer_external_interface_ADDR                : out   STD_LOGIC_VECTOR(18 downto 0);                    -- ADDR
            pixel_buffer_external_interface_ADSC_N              : out   STD_LOGIC;                                        -- ADSC_N
            pixel_buffer_external_interface_ADSP_N              : out   STD_LOGIC;                                        -- ADSP_N
            pixel_buffer_external_interface_ADV_N               : out   STD_LOGIC;                                        -- ADV_N
            pixel_buffer_external_interface_BE_N                : out   STD_LOGIC_VECTOR(3 downto 0);                     -- BE_N
            pixel_buffer_external_interface_CE1_N               : out   STD_LOGIC;                                        -- CE1_N
            pixel_buffer_external_interface_CE2                 : out   STD_LOGIC;                                        -- CE2
            pixel_buffer_external_interface_CE3_N               : out   STD_LOGIC;                                        -- CE3_N
            pixel_buffer_external_interface_GW_N                : out   STD_LOGIC;                                        -- GW_N
            pixel_buffer_external_interface_OE_N                : out   STD_LOGIC;                                        -- OE_N
            pixel_buffer_external_interface_WE_N                : out   STD_LOGIC;                                        -- WE_N
            pixel_buffer_external_interface_CLK                 : out   STD_LOGIC;                                        -- CLK
            vga_controller_external_interface_CLK               : out   STD_LOGIC;                                        -- CLK
            vga_controller_external_interface_HS                : out   STD_LOGIC;                                        -- HS
            vga_controller_external_interface_VS                : out   STD_LOGIC;                                        -- VS
            vga_controller_external_interface_BLANK             : out   STD_LOGIC;                                        -- BLANK
            vga_controller_external_interface_SYNC              : out   STD_LOGIC;                                        -- SYNC
            vga_controller_external_interface_R                 : out   STD_LOGIC_VECTOR(9 downto 0);                     -- R
            vga_controller_external_interface_G                 : out   STD_LOGIC_VECTOR(9 downto 0);                     -- G
            vga_controller_external_interface_B                 : out   STD_LOGIC_VECTOR(9 downto 0);                     -- B
				sdram_wire_addr                                     : out   std_logic_vector(12 downto 0);                    -- addr
            sdram_wire_ba                                       : out   std_logic_vector(1 downto 0);                     -- ba
            sdram_wire_cas_n                                    : out   std_logic;                                        -- cas_n
            sdram_wire_cke                                      : out   std_logic;                                        -- cke
            sdram_wire_cs_n                                     : out   std_logic;                                        -- cs_n
            sdram_wire_dq                                       : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
            sdram_wire_dqm                                      : out   std_logic_vector(1 downto 0);                     -- dqm
            sdram_wire_ras_n                                    : out   std_logic;                                        -- ras_n
            sdram_wire_we_n                                     : out   std_logic                                         -- we_n
        );
    end component;
	 
		  BEGIN
		  
		  NiosII : de2_70
        port map (
            clk_clk                                             => CLOCK_50,                                          				    --                               	clk.clk
            reset_reset_n                                       => KEY(0),							                                        --                               reset.reset_n
				sdram_clk                                           => DE2_70_SDRAM_CLK,                                           		 --                               sdram.clk
				
            av_config_external_interface_SDAT                   => GPIO_1(25),      --VERIFICAR SE ESTÁ CORRETO							 --        av_config_external_interface.SDAT
            av_config_external_interface_SCLK                   => GPIO_1(26),		--VERIFICAR SE ESTÁ CORRETO				   		 --                                    .SCLK
            video_in_decoder_external_interface_PIXEL_CLK       => GPIO_1(0),    	--VERIFICAR SE ESTÁ CORRETO				     		 -- video_in_decoder_external_interface.PIXEL_CLK
            video_in_decoder_external_interface_LINE_VALID      => GPIO_1(23),   	--VERIFICAR SE ESTÁ CORRETO	    					 --                                    .LINE_VALID
            video_in_decoder_external_interface_FRAME_VALID     => GPIO_1(24),		--VERIFICAR SE ESTÁ CORRETO				  		    --                                    .FRAME_VALID
            video_in_decoder_external_interface_pixel_clk_reset => '1', 		 																		 --                                    .pixel_clk_reset
				           
				video_in_decoder_external_interface_PIXEL_DATA(0)      => GPIO_1(15),   --ESTÁ CORRETO   						 					 --                                    .PIXEL_DATA
				video_in_decoder_external_interface_PIXEL_DATA(1)      => GPIO_1(14),	--ESTÁ CORRETO							 					 --                                    .PIXEL_DATA
				video_in_decoder_external_interface_PIXEL_DATA(2)      => GPIO_1(13),	--ESTÁ CORRETO 							 				 --                                    .PIXEL_DATA
				video_in_decoder_external_interface_PIXEL_DATA(3)      => GPIO_1(12),	--ESTÁ CORRETO							 					 --                                    .PIXEL_DATA
				video_in_decoder_external_interface_PIXEL_DATA(4)      => GPIO_1(9),		--ESTÁ CORRETO											    --                                    .PIXEL_DATA
				video_in_decoder_external_interface_PIXEL_DATA(5)      => GPIO_1(8),		--ESTÁ CORRETO												 --                                    .PIXEL_DATA
				video_in_decoder_external_interface_PIXEL_DATA(6)      => GPIO_1(7),		--ESTÁ CORRETO												 --                                    .PIXEL_DATA
				video_in_decoder_external_interface_PIXEL_DATA(7)      => GPIO_1(6),		--ESTÁ CORRETO												 --                                    .PIXEL_DATA
				video_in_decoder_external_interface_PIXEL_DATA(8)      => GPIO_1(5),		--ESTÁ CORRETO												 --                                    .PIXEL_DATA
				video_in_decoder_external_interface_PIXEL_DATA(9)      => GPIO_1(4),		--ESTÁ CORRETO												 --                                    .PIXEL_DATA
				video_in_decoder_external_interface_PIXEL_DATA(10)     => GPIO_1(3),		--ESTÁ CORRETO												 --                                    .PIXEL_DATA
				video_in_decoder_external_interface_PIXEL_DATA(11)     => GPIO_1(1),		--ESTÁ CORRETO												 --                                    .PIXEL_DATA
				
            pixel_buffer_external_interface_DQ                  => DE2_70_PIXEL_BUFFER_EXTERNAL_INTERFACE_DQ, 		                   --     pixel_buffer_external_interface.DQ
            pixel_buffer_external_interface_DPA                 => DE2_70_PIXEL_BUFFER_EXTERNAL_INTERFACE_DPA,        		          --                                    .DPA
            pixel_buffer_external_interface_ADDR                => DE2_70_PIXEL_BUFFER_EXTERNAL_INTERFACE_ADDR,                		 --                                    .ADDR
            pixel_buffer_external_interface_ADSC_N              => DE2_70_PIXEL_BUFFER_EXTERNAL_INTERFACE_ADSC_N,              		 --                                    .ADSC_N
            pixel_buffer_external_interface_ADSP_N              => DE2_70_PIXEL_BUFFER_EXTERNAL_INTERFACE_ADSP_N,              		 --                                    .ADSP_N
            pixel_buffer_external_interface_ADV_N               => DE2_70_PIXEL_BUFFER_EXTERNAL_INTERFACE_ADV_N,               		 --                                    .ADV_N
            pixel_buffer_external_interface_BE_N                => DE2_70_PIXEL_BUFFER_EXTERNAL_INTERFACE_BE_N,      		          --                                    .BE_N
            pixel_buffer_external_interface_CE1_N               => DE2_70_PIXEL_BUFFER_EXTERNAL_INTERFACE_CE1_N,               		 --                                    .CE1_N
            pixel_buffer_external_interface_CE2                 => DE2_70_PIXEL_BUFFER_EXTERNAL_INTERFACE_CE2,          		       --                                    .CE2
            pixel_buffer_external_interface_CE3_N               => DE2_70_PIXEL_BUFFER_EXTERNAL_INTERFACE_CE3_N,              		 --                                    .CE3_N
            pixel_buffer_external_interface_GW_N                => DE2_70_PIXEL_BUFFER_EXTERNAL_INTERFACE_GW_N,               		 --                                    .GW_N
            pixel_buffer_external_interface_OE_N                => DE2_70_PIXEL_BUFFER_EXTERNAL_INTERFACE_OE_N,                		 --                                    .OE_N
            pixel_buffer_external_interface_WE_N                => DE2_70_PIXEL_BUFFER_EXTERNAL_INTERFACE_WE_N,                		 --                                    .WE_N
            pixel_buffer_external_interface_CLK                 => DE2_70_PIXEL_BUFFER_EXTERNAL_INTERFACE_CLK,                 		 --                                    .CLK
            vga_controller_external_interface_CLK               => DE2_70_VGA_CONTROLLER_EXTERNAL_INTERFACE_CLK,              		 --   vga_controller_external_interface.CLK
            vga_controller_external_interface_HS                => DE2_70_VGA_CONTROLLER_EXTERNAL_INTERFACE_HS,               		 --                                    .HS
            vga_controller_external_interface_VS                => DE2_70_VGA_CONTROLLER_EXTERNAL_INTERFACE_VS,       		          --                                    .VS
            vga_controller_external_interface_BLANK             => DE2_70_VGA_CONTROLLER_EXTERNAL_INTERFACE_BLANK,	 	             --                                    .BLANK
            vga_controller_external_interface_SYNC              => DE2_70_VGA_CONTROLLER_EXTERNAL_INTERFACE_SYNC,		                --                                    .SYNC
            vga_controller_external_interface_R                 => DE2_70_VGA_CONTROLLER_EXTERNAL_INTERFACE_R,     		             --                                    .R
            vga_controller_external_interface_G                 => DE2_70_VGA_CONTROLLER_EXTERNAL_INTERFACE_G,      		             --                                    .G
            vga_controller_external_interface_B                 => DE2_70_VGA_CONTROLLER_EXTERNAL_INTERFACE_B,             		    --                                    .B
				sdram_wire_addr                                     => DE2_70_SDRAM_WIRE_ADDR,                                     		 --                          sdram_wire.addr
            sdram_wire_ba                                       => DE2_70_SDRAM_WIRE_BA,                                      		 --                                    .ba
            sdram_wire_cas_n                                    => DE2_70_SDRAM_WIRE_CAS_N,                                    		 --                                    .cas_n
            sdram_wire_cke                                      => DE2_70_SDRAM_WIRE_CKE,                                      		 --                                    .cke
            sdram_wire_cs_n                                     => DE2_70_SDRAM_WIRE_CS_N,                                     		 --                                    .cs_n
            sdram_wire_dq                                       => DE2_70_SDRAM_WIRE_DQ,                                       		 --                                    .dq
            sdram_wire_dqm                                      => DE2_70_SDRAM_WIRE_DQM,                                      		 --                                    .dqm
            sdram_wire_ras_n                                    => DE2_70_SDRAM_WIRE_RAS_N,                                    		 --                                    .ras_n
            sdram_wire_we_n                                     => DE2_70_SDRAM_WIRE_WE_N                                      		 --                                    .we_n
        );
END Structure;