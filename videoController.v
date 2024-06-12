module videoController(
    input CLOCK_50,
    input reset, keyRestart,
    
    input [9:0] enemy_x, enemy_y, enemy_size,
    input [255:0] enemy_sprite, 
    input [7:0] enemy_color, 
    input enemy_write_enable,

    output wire VGA_HS, VGA_VS,
    output wire [7:0] VGA_R, VGA_G, VGA_B,
    output wire VGA_SYNC_N, VGA_BLANK_N, VGA_CLK
);


wire [7:0] data_ch1;
wire [9:0] x_address_ch1;
wire [9:0] y_address_ch1;
wire write_enable_ch1;

wire [7:0] data_ch2;
wire [9:0] x_address_ch2;
wire [9:0] y_address_ch2;
wire write_enable_ch2;

wire [7:0] data_ch3;
wire [9:0] x_address_ch3;
wire [9:0] y_address_ch3;
wire write_enable_ch3;

wire [7:0] data_ch4;
wire [9:0] x_address_ch4;
wire [9:0] y_address_ch4;
wire write_enable_ch4;


sprite2Serial playerSprite(
    .clock(CLOCK_50),
    .reset(reset),
    .x(10'd0),              //////////////////////////////
    .y(10'd0),              //////////////////////////////
    .color(8'd255),
    .sprite(256'd0),        //////////////////////////////
    .read_enable(1'b0),     //////////////////////////////
    .data_out(data_ch1),
    .x_out(x_address_ch1),
    .y_out(y_address_ch1),
    .write_enable(write_enable_ch1)
);

sprite2Serial enemySprite(
    .clock(CLOCK_50),
    .reset(reset),
    .x(enemy_x),              //////////////////////////////
    .y(enemy_y),              //////////////////////////////
    .color(enemy_color),
    .sprite(enemy_sprite),   //////////////////////////////
    .read_enable(enemy_write_enable),     //////////////////////////////
    .data_out(data_ch2),
    .x_out(x_address_ch2),
    .y_out(y_address_ch2),
    .write_enable(write_enable_ch2)
);

cleanLastSprite playerClean(
    .clock(CLOCK_50),
    .reset(reset),
    .x(10'd0),              //////////////////////////////
    .y(10'd0),              //////////////////////////////
    .erase_enable(1'b0),     //////////////////////////////
    .data_out(data_ch3),
    .x_out(x_address_ch3),
    .y_out(y_address_ch3),
    .write_enable(write_enable_ch3)
);

cleanLastSprite enemyClean(
    .clock(CLOCK_50),
    .reset(reset),
    .x(10'd0),              //////////////////////////////
    .y(10'd0),              //////////////////////////////
    .erase_enable(1'b0),     //////////////////////////////
    .data_out(data_ch4),
    .x_out(x_address_ch4),
    .y_out(y_address_ch4),
    .write_enable(write_enable_ch4)
);

wire [9:0] x_read_address;
wire [9:0] y_read_address;
wire [7:0] data_read;

memory memory_module(
    .clk_read(VGA_CLK),
    .clk_write(CLOCK_50),
    .write_enable_ch1(write_enable_ch1),
    .write_enable_ch2(write_enable_ch2),
    .write_enable_ch3(write_enable_ch3),
    .write_enable_ch4(write_enable_ch4),
    .r_x_address(x_read_address),
    .r_y_address(y_read_address),
    .w1_x_address(x_address_ch1),
    .w1_y_address(y_address_ch1),
    .w2_x_address(x_address_ch2),
    .w2_y_address(y_address_ch2),
    .w3_x_address(x_address_ch3),
    .w3_y_address(y_address_ch3),
    .w4_x_address(x_address_ch4),
    .w4_y_address(y_address_ch4),
    .data_in_ch1(data_ch1),
    .data_in_ch2(data_ch2),
    .data_in_ch3(data_ch3),
    .data_in_ch4(data_ch4),
    .data_out(data_read)
);

vga vga_module(
    .CLOCK_50(CLOCK_50),
    .reset(reset),
    .red_in(data_read),
    .green_in(data_read),
    .blue_in(data_read),
    .VGA_HS(VGA_HS),
    .VGA_VS(VGA_VS),
    .VGA_R(VGA_R),
    .VGA_G(VGA_G),
    .VGA_B(VGA_B),
    .VGA_SYNC_N(VGA_SYNC_N),
    .VGA_BLANK_N(VGA_BLANK_N),
    .VGA_CLK(VGA_CLK),
    .next_x(x_read_address),
    .next_y(y_read_address)
);


endmodule