module vga(
    input CLOCK_50, reset,
    input [7:0] red_in, green_in, blue_in,

    output wire VGA_HS, VGA_VS, 
    output wire [7:0] VGA_R, VGA_G, VGA_B,
    output wire VGA_SYNC_N, VGA_BLANK_N, VGA_CLK,

    output wire [9:0] next_x, next_y
);  
// Divisor de frequencia 50MHz -> 25MHz
    reg vga_clock_aux = 0;
    assign VGA_CLK = vga_clock_aux;
    always @(posedge CLOCK_50) begin
        vga_clock_aux <= ~vga_clock_aux;
    end

// Contador de pixels e linhas
    reg [9:0] pixel_count = 10'd0;
    reg [9:0] line_count = 10'd0;
    always @(posedge VGA_CLK) begin
        if (!reset) begin
            //pixel_count <= 0;
            //line_count <= 0;

        end else begin
            if (pixel_count < 799)
                pixel_count <= pixel_count + 10'd1;
            else begin
                pixel_count <= 0;
                if (line_count < 524)
                    line_count <= line_count + 10'd1;
                else 
                    line_count <= 0;
            end
        end
    end

// Sinais de sincronismo
    assign next_x = pixel_count - 10'd143;
    assign next_y = line_count - 10'd35;

    `define SCREEN_RANGE(pixel_count, line_count) ((pixel_count >= 144) && (pixel_count < 784) && (line_count >= 35) && (line_count < 515))
    assign VGA_R = (`SCREEN_RANGE(pixel_count, line_count)) ? red_in : 8'd0;
    assign VGA_G = (`SCREEN_RANGE(pixel_count, line_count)) ? green_in : 8'd0;
    assign VGA_B = (`SCREEN_RANGE(pixel_count, line_count)) ? blue_in : 8'd0;

    assign VGA_HS = (pixel_count < 96) ? 1'b0 : 1'b1; 
	assign VGA_VS = (line_count < 2) ? 1'b0 : 1'b1;
    assign VGA_SYNC_N = 1'b0;
    assign VGA_BLANK_N = 1'b1;
endmodule