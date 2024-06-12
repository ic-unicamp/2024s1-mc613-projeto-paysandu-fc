module game_controller (
    input CLOCK_50, reset,
    input keyLeft, keyRight, keyUp, keyDown, keyRestart, // keys para movimentação
    output [3:0] game_state,
    output [9:0] bar_bottomLimit, bar_leftLimit, bar_rightLimit, bar_topLimit,
    output [9:0] ball_bottomLimit, ball_leftLimit, ball_rightLimit, ball_topLimit,
    output [9:0] ball_x_speed, ball_y_speed,
    output [0:0] ball_x_dir, ball_y_dir,
    output [9:0] ball_2_bottomLimit, ball_2_leftLimit, ball_2_rightLimit, ball_2_topLimit,
    output [9:0] ball_2_x_speed, ball_2_y_speed,
    output [0:0] ball_2_x_dir, ball_2_y_dir,
    output [9:0] ball_3_bottomLimit, ball_3_leftLimit, ball_3_rightLimit, ball_3_topLimit,
    output [9:0] ball_3_x_speed, ball_3_y_speed,
    output [0:0] ball_3_x_dir, ball_3_y_dir,
    output [9:0] ball_4_bottomLimit, ball_4_leftLimit, ball_4_rightLimit, ball_4_topLimit,
    output [9:0] ball_4_x_speed, ball_4_y_speed,
    output [0:0] ball_4_x_dir, ball_4_y_dir,
    output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);
    // Variaveis auxiliares do jogo
    reg [3:0] game_state_aux = 4'd0;
    wire [0:0] gameover_flag, gameover_flag_2, gameover_flag_3, gameover_flag_4;

    // Placar jogo
    wire [17:0] highScore, currentScore;
    display display_module(highScore, currentScore,
                            HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

    //----BARRA----
    bar bar_module(CLOCK_50, reset, game_state, keyLeft, keyRight, keyUp, keyDown, bar_bottomLimit, bar_leftLimit, bar_rightLimit, bar_topLimit);

    //----BOLA----
    ball ball_module(CLOCK_50, reset, game_state,
            ball_bottomLimit, ball_leftLimit, ball_rightLimit, ball_topLimit,
            bar_bottomLimit, bar_leftLimit, bar_rightLimit, bar_topLimit,
            ball_x_speed, ball_y_speed, ball_x_dir, ball_y_dir, gameover_flag, highScore, currentScore);

    //----BOLA_2----
    ball2 ball_2_module(CLOCK_50, reset, game_state,
            ball_2_bottomLimit, ball_2_leftLimit, ball_2_rightLimit, ball_2_topLimit,
            bar_bottomLimit, bar_leftLimit, bar_rightLimit, bar_topLimit,
            ball_2_x_speed, ball_2_y_speed, ball_2_x_dir, ball_2_y_dir, gameover_flag_2);

    //----BOLA_3----
    ball3 ball_3_module(CLOCK_50, reset, game_state,
            ball_3_bottomLimit, ball_3_leftLimit, ball_3_rightLimit, ball_3_topLimit,
            bar_bottomLimit, bar_leftLimit, bar_rightLimit, bar_topLimit,
            ball_3_x_speed, ball_3_y_speed, ball_3_x_dir, ball_3_y_dir, gameover_flag_3);

    //----BOLA_4----
    ball4 ball_4_module(CLOCK_50, reset, game_state,
            ball_4_bottomLimit, ball_4_leftLimit, ball_4_rightLimit, ball_4_topLimit,
            bar_bottomLimit, bar_leftLimit, bar_rightLimit, bar_topLimit,
            ball_4_x_speed, ball_4_y_speed, ball_4_x_dir, ball_4_y_dir, gameover_flag_4);

    always @(posedge CLOCK_50) begin
        if (!reset) begin
            game_state_aux = 4'd0;

        end else begin
            case(game_state_aux)
                0: begin // estado de jogo
                    if (gameover_flag || gameover_flag_2 || gameover_flag_3 || gameover_flag_4) begin
                        game_state_aux = 4'd1;
                    end
                end
                1: begin // game over
                    if (!keyRestart) begin
                        
                        game_state_aux = 4'd0;
                    end
                end
                default: game_state_aux = 4'd0;
            endcase
        end
    end
    assign game_state = game_state_aux;
endmodule