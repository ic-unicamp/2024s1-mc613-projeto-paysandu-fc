module top(
    input CLOCK_50, reset,
    input keyLeft, keyRight, keyUp, keyDown, keyRestart, // keys para movimentação

    output wire VGA_HS, VGA_VS,
    output wire [7:0] VGA_R, VGA_G, VGA_B,
    output wire VGA_SYNC_N, VGA_BLANK_N, VGA_CLK,
    output wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);
    // Variaveis logicas do jogo
        wire [3:0] game_state; // 0 = jogo, 1 = game over

    //----BARRA----
        // Limites de arestas da barra
        wire [9:0] bar_topLimit, bar_bottomLimit, bar_leftLimit, bar_rightLimit;
        // - - - - _ - - - -    (são 4 hit box na esquerda/direita e 1 hit box no centro)
    
    //----BOLA----
        // Limites de arestas da bola
        wire [9:0] ball_topLimit, ball_bottomLimit, ball_leftLimit, ball_rightLimit;
        wire [9:0] ball_x_speed, ball_y_speed;
        wire [0:0] ball_x_dir, ball_y_dir;

    //----BOLA2----
        // Limites de arestas da bola
        wire [9:0] ball_topLimit_2, ball_bottomLimit_2, ball_leftLimit_2, ball_rightLimit_2;
        wire [9:0] ball_x_speed_2, ball_y_speed_2;
        wire [0:0] ball_x_dir_2, ball_y_dir_2;

    //----BOLA3----
        // Limites de arestas da bola
        wire [9:0] ball_topLimit_3, ball_bottomLimit_3, ball_leftLimit_3, ball_rightLimit_3;
        wire [9:0] ball_x_speed_3, ball_y_speed_3;
        wire [0:0] ball_x_dir_3, ball_y_dir_3;
        
    //----BOLA4----
        // Limites de arestas da bola
        wire [9:0] ball_topLimit_4, ball_bottomLimit_4, ball_leftLimit_4, ball_rightLimit_4;
        wire [9:0] ball_x_speed_4, ball_y_speed_4;
        wire [0:0] ball_x_dir_4, ball_y_dir_4;


    // Sprite handler
    sprite_handler sprite_handler_module(CLOCK_50, reset, game_state, bar_bottomLimit, bar_leftLimit, bar_rightLimit, bar_topLimit, 
                                            ball_bottomLimit, ball_leftLimit, ball_rightLimit, ball_topLimit,
                                            ball_bottomLimit_2, ball_leftLimit_2, ball_rightLimit_2, ball_topLimit_2,
                                            ball_bottomLimit_3, ball_leftLimit_3, ball_rightLimit_3, ball_topLimit_3,
                                            ball_bottomLimit_4, ball_leftLimit_4, ball_rightLimit_4, ball_topLimit_4,
                                            VGA_HS, VGA_VS, VGA_R, VGA_G, VGA_B, VGA_SYNC_N, VGA_BLANK_N, VGA_CLK);

    // game controller
    game_controller game_controller_module(CLOCK_50, reset, keyLeft, keyRight, keyUp, keyDown, keyRestart, game_state,
                                            bar_bottomLimit, bar_leftLimit, bar_rightLimit, bar_topLimit, 
                                            ball_bottomLimit, ball_leftLimit, ball_rightLimit, ball_topLimit, 
                                            ball_x_speed, ball_y_speed, ball_x_dir, ball_y_dir,
                                            ball_bottomLimit_2, ball_leftLimit_2, ball_rightLimit_2, ball_topLimit_2,
                                            ball_x_speed_2, ball_y_speed_2, ball_x_dir_2, ball_y_dir_2,
                                            ball_bottomLimit_3, ball_leftLimit_3, ball_rightLimit_3, ball_topLimit_3,
                                            ball_x_speed_3, ball_y_speed_3, ball_x_dir_3, ball_y_dir_3,
                                            ball_bottomLimit_4, ball_leftLimit_4, ball_rightLimit_4, ball_topLimit_4,
                                            ball_x_speed_4, ball_y_speed_4, ball_x_dir_4, ball_y_dir_4,
                                            HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
endmodule
