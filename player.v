module player (
    input CLOCK_50, reset, game_state,
    input keyUp, keyDown, keyLeft, keyRight,  // keys para movimentação

    output wire [9:0] player_x,
    output wire [9:0] player_y,
    output wire [9:0] player_size,
    output wire [255:0] player_sprite,
    output wire [7:0] player_color,
    output wire player_write_enable
);

   // Variaveis logicas do teclado
        reg [31:0] keyLeft_counter = 0, keyRight_counter = 0, keyConst = 4000000;
        reg [9:0] player_x_aux, player_y_aux;
        reg [31:0] keyDown_counter = 0, keyTop_counter = 0;
        
    always @(posedge CLOCK_50) begin
        if (!reset || game_state) begin
            player_x_aux = 328;
            player_y_aux = 232;
            
        end else begin
        // Logica de movimentação do character
            if (!keyLeft && carac_leftLimit > 10'd0) begin
                keyLeft_counter = keyLeft_counter + 10'd1;
                if (keyLeft_counter >= keyConst) begin
                    player_x_aux = player_x_aux - 10'd16;
                    keyLeft_counter = 0;
                end
            end else begin
                keyLeft_counter = 0;
            
            end if (!keyRight && carac_rightLimit < 10'd623) begin
                keyRight_counter = keyRight_counter + 10'd1;
                if (keyRight_counter >= keyConst) begin
                    player_x_aux = player_x_aux + 10'd16;
                    keyRight_counter = 0;
                end
            end else begin
                keyRight_counter = 0;

            end if (!keyUp && carac_topLimit < 10'd0) begin
                keyTop_counter = keyTop_counter + 10'd1;
                if (keyTop_counter >= keyConst) begin
                    player_y_aux = player_y_aux - 10'd16;
                    keyTop_counter = 0;
                end
            end else begin
                keyTop_counter = 0;
            
            end if (!keyDown && carac_bottomLimit < 10'd639) begin
                keyDown_counter = keyDown_counter + 10'd1;
                if (keyTop_counter >= keyConst) begin
                    player_y_aux = player_y_aux + 10'd16;
                    keyDown_counter = 0;
                end
            end else begin
                keyDown_counter = 0;
            
            end
        end
    end
    
    assign out_x = player_x_aux;
    assign out_y = player_y_aux;
    assign player_sprite = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
    assign player_color = 8'd65;
    assign player_write_enable = 1'b1;


endmodule