module bar(
    input CLOCK_50, reset, game_state,
    input keyLeft, keyRight, keyUp, keyDown, // keys para movimentação
    output [9:0] bar_bottomLimit, bar_leftLimit, bar_rightLimit, bar_topLimit
);
   // Variaveis logicas da barra
        reg [31:0] keyLeft_counter = 0, keyRight_counter = 0, keyup_counter = 0, keydown_counter = 0, keyConst = 4000000;
        reg [9:0] bar_topLimit_out = 264;
        reg [9:0] bar_bottomLimit_out = 279;
        reg [9:0] bar_leftLimit_out = 256;
        reg [9:0] bar_rightLimit_out = 271;
        
    always @(posedge CLOCK_50) begin
        if (!reset || game_state) begin
		    bar_topLimit_out = 264;
		    bar_bottomLimit_out = 279;
		    bar_leftLimit_out = 256;
			bar_rightLimit_out = 271;
        end else begin
        // Logica de movimentação da barra
            if (!keyLeft && bar_leftLimit >= 10'd16) begin
                keyLeft_counter = keyLeft_counter + 10'd1;
                if (keyLeft_counter >= keyConst) begin
                    bar_leftLimit_out = bar_leftLimit - 10'd16;
                    bar_rightLimit_out = bar_rightLimit - 10'd16;
                    keyLeft_counter = 0;
                end
            end else begin
                keyLeft_counter = 0;
            
            end if (!keyRight && bar_rightLimit <= 10'd623) begin
                keyRight_counter = keyRight_counter + 10'd1;
                if (keyRight_counter >= keyConst) begin
                    bar_leftLimit_out = bar_leftLimit + 10'd16;
                    bar_rightLimit_out = bar_rightLimit + 10'd16;
                    keyRight_counter = 0;
                end
            end else begin
                keyRight_counter = 0;
            end if (!keyUp && bar_topLimit >= 10'd16) begin
                keyup_counter = keyup_counter + 10'd1;
                if (keyup_counter >= keyConst) begin
                    bar_topLimit_out = bar_topLimit - 10'd16;
                    bar_bottomLimit_out = bar_bottomLimit - 10'd16;
                    keyup_counter = 0;
                end
            end else begin
                keyup_counter = 0;
            end if (!keyDown && bar_bottomLimit <= 10'd463) begin
                keydown_counter = keydown_counter + 10'd1;
                if (keydown_counter >= keyConst) begin
                    bar_topLimit_out = bar_topLimit + 10'd16;
                    bar_bottomLimit_out = bar_bottomLimit + 10'd16;
                    keydown_counter = 0;
                end
            end else begin
                keydown_counter = 0;
            end
        end
    end

    assign bar_bottomLimit = bar_bottomLimit_out;
    assign bar_leftLimit = bar_leftLimit_out;
    assign bar_rightLimit = bar_rightLimit_out;
    assign bar_topLimit = bar_topLimit_out;

endmodule