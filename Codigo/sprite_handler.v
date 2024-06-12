module sprite_handler(
    input CLOCK_50, reset, game_state,

    input [9:0] bar_bottomLimit, bar_leftLimit, bar_rightLimit, bar_topLimit,
    input [9:0] ball_bottomLimit, ball_leftLimit, ball_rightLimit, ball_topLimit,
    input [9:0] ball_2_bottomLimit, ball_2_leftLimit, ball_2_rightLimit, ball_2_topLimit,
    input [9:0] ball_3_bottomLimit, ball_3_leftLimit, ball_3_rightLimit, ball_3_topLimit,
    input [9:0] ball_4_bottomLimit, ball_4_leftLimit, ball_4_rightLimit, ball_4_topLimit,

    output wire VGA_HS, VGA_VS,
    output wire [7:0] VGA_R, VGA_G, VGA_B,
    output wire VGA_SYNC_N, VGA_BLANK_N, VGA_CLK
);
    //----VGA----
        wire [9:0] next_x, next_y;
        wire [7:0] red_out, green_out, blue_out;

        reg [7:0] red_out_aux = 0, green_out_aux = 0, blue_out_aux = 0;
        assign red_out = red_out_aux;
        assign green_out = green_out_aux;
        assign blue_out = blue_out_aux;

        vga vga_module(CLOCK_50, reset, red_out, green_out, blue_out, VGA_HS, VGA_VS, 
                        VGA_R, VGA_G, VGA_B, VGA_SYNC_N, VGA_BLANK_N, VGA_CLK, next_x, next_y);

    always @(posedge CLOCK_50) begin
        //Visualização das Sprites
        if (!reset) begin
            red_out_aux <= 0;
            green_out_aux <= 0;
            blue_out_aux <= 0;

        end else if (!game_state) begin
        // Sprite da barra
            if (next_x >= bar_leftLimit && next_x < bar_rightLimit && next_y >= bar_topLimit && next_y < bar_bottomLimit) begin
                red_out_aux <= 8'd0;
                green_out_aux <= 8'd255;
                blue_out_aux <= 8'd0;
        // Sprite da bola
            end else if ((next_x >= ball_leftLimit && next_x < ball_rightLimit && next_y >= ball_topLimit && next_y < ball_bottomLimit) ||
                        (next_x >= ball_2_leftLimit && next_x < ball_2_rightLimit && next_y >= ball_2_topLimit && next_y < ball_2_bottomLimit) ||
                        (next_x >= ball_3_leftLimit && next_x < ball_3_rightLimit && next_y >= ball_3_topLimit && next_y < ball_3_bottomLimit) ||
                        (next_x >= ball_4_leftLimit && next_x < ball_4_rightLimit && next_y >= ball_4_topLimit && next_y < ball_4_bottomLimit)) begin
                red_out_aux <= 8'd255;
                green_out_aux <= 8'd0;
                blue_out_aux <= 8'd0;
        // Fundo da Tela
            end else begin
                red_out_aux <= 8'b0;
                green_out_aux <= 8'b0;
                blue_out_aux <= 8'b0;
            end
        // Tela de Game Over
        end else begin
            red_out_aux <= 8'd255;
            green_out_aux <= 8'd0;
            blue_out_aux <= 8'd0;
        end
    end

endmodule