module character(
    input CLOCK_50, reset, game_state,
    input keyUp, keyDown, keyLeft, keyRight,  // keys para movimentação
    output [9:0] out_x, out_y,
    output [9:0] carac_bottomLimit, carac_leftLimit, carac_rightLimit, carac_topLimit// posição de character
);
   // Variaveis logicas da caracra
        reg [31:0] keyLeft_counter = 0, keyRight_counter = 0, keyConst = 4000000;
        reg [9:0] out_x_aux, out_y_aux;
        reg [31:0] keyDown_counter = 0, keyTop_counter = 0;
        
    always @(posedge CLOCK_50) begin
        if (!reset || game_state) begin
            out_x_aux = 328;
            out_y_aux = 232;
            carac_topLimit_out = 328;
            carac_bottomLimit_out = 312;
			carac_leftLimit_out = 232;
			carac_rightLimit_out = 248;
            
        end else begin
        // Logica de movimentação do character
            if (!keyLeft && carac_leftLimit > 10'd0) begin
                keyLeft_counter = keyLeft_counter + 10'd1;
                if (keyLeft_counter >= keyConst) begin
                    out_x_aux = out_x_aux - 10'd16;
                    carac_leftLimit_out = carac_leftLimit - 10'd16;
                    carac_rightLimit_out = carac_rightLimit - 10'd16;
                    keyLeft_counter = 0;
                end
            end else begin
                keyLeft_counter = 0;
            
            end if (!keyRight && carac_rightLimit < 10'd623) begin
                keyRight_counter = keyRight_counter + 10'd1;
                if (keyRight_counter >= keyConst) begin
                    out_x_aux = out_x_aux + 10'd16;
                    carac_leftLimit_out = carac_leftLimit + 10'd16;
                    carac_rightLimit_out = carac_rightLimit + 10'd16;
                    keyRight_counter = 0;
                end
            end else begin
                keyRight_counter = 0;
            
            /*-----------------------------------------------------*/
            end if (!keyUp && carac_topLimit < 10'd0) begin
                keyTop_counter = keyTop_counter + 10'd1;
                if (keyTop_counter >= keyConst) begin
                    out_y_aux = out_y_aux - 10'd16;
                    carac_topLimit_out = carac_topLimit - 10'd16;
                    carac_bottomLimit_out = carac_bottomLimit - 10'd16;
                    keyTop_counter = 0;
                end
            end else begin
                keyTop_counter = 0;
            
            end if (!keyDown && carac_bottomLimit < 10'd639) begin
                keyDown_counter = keyDown_counter + 10'd1;
                if (keyTop_counter >= keyConst) begin
                    out_y_aux = out_y_aux + 10'd16;
                    carac_topLimit_out = carac_topLimit + 10'd16;
                    carac_bottomLimit_out = carac_bottomLimit + 10'd16;
                    keyDown_counter = 0;
                end
            end else begin
                keyDown_counter = 0;
            
            end
        end
    end
    
    assign out_x = out_x_aux;
    assign out_y = out_y_aux;
    assign carac_bottomLimit = carac_bottomLimit_out;
    assign carac_leftLimit = carac_leftLimit_out;
    assign carac_rightLimit = carac_rightLimit_out;
    assign carac_topLimit = carac_topLimit_out;

endmodule