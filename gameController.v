module gameController(
    input CLOCK_50,
    input reset, keyRestart,
    input keyUp, KeyDown, keyLeft, keyRight, // keys para movimentação
    
    output wire VGA_HS, VGA_VS,
    output wire [7:0] VGA_R, VGA_G, VGA_B,
    output wire VGA_SYNC_N, VGA_BLANK_N, VGA_CLK,
    output wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);

    //----GAME OBJECTS----
        //----ENEMY----
            // Parametros do inimigo
            wire [9:0] enemy_x, enemy_y;
            wire [9:0] enemy_size;
            wire [255:0] enemy_sprite;
            wire [7:0] enemy_color;
            wire enemy_write_enable;
            
            enemy enemy_module(
                .CLOCK_50(CLOCK_50),
                .reset(reset),
                .enemy_x(enemy_x),
                .enemy_y(enemy_y),
                .enemy_size(enemy_size),
                .enemy_sprite(enemy_sprite),
                .enemy_color(enemy_color),
                .enemy_write_enable(enemy_write_enable)
            );

    //----GAME LOGIC----


    //----VIDEO CONTROLLER----
    videoController videoController_module(
        .CLOCK_50(CLOCK_50),
        .reset(reset),
        .keyRestart(keyRestart),
        .enemy_x(enemy_x),
        .enemy_y(enemy_y),
        .enemy_size(enemy_size),
        .enemy_sprite(enemy_sprite),
        .enemy_color(enemy_color),
        .enemy_write_enable(enemy_write_enable),
        .VGA_HS(VGA_HS),
        .VGA_VS(VGA_VS),
        .VGA_R(VGA_R),
        .VGA_G(VGA_G),
        .VGA_B(VGA_B),
        .VGA_SYNC_N(VGA_SYNC_N),
        .VGA_BLANK_N(VGA_BLANK_N),
        .VGA_CLK(VGA_CLK)
    );
         
endmodule