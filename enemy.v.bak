module enemy (
    input wire CLOCK_50, reset,
    output wire [9:0] enemy_x,
    output wire [9:0] enemy_y,
    output wire [9:0] enemy_size,
    output wire [255:0] enemy_sprite,
    output wire [7:0] enemy_color,
    output wire enemy_write_enable
);
    // Enemy logic variables
    reg [9:0] enemy_x_aux = 0;
    reg [9:0] enemy_y_aux = 0;
    reg [9:0] future_x, future_y;

    reg [9:0] enemy_x_speed_aux = 4;
    reg [9:0] enemy_y_speed_aux = 4;
    reg [0:0] enemy_x_dir_aux = 1; // 1 indicates the enemy moves to the right, 0 to the left
    reg [0:0] enemy_y_dir_aux = 1; // 1 indicates the enemy moves down, 0 up

    wire movement_flag;
    reg [31:0] enemy_time_const = 32'd400;
    enemy_mov_counter enemy_mov_counter_module(CLOCK_50, reset, enemy_time_const, movement_flag);

    always @(posedge CLOCK_50) begin
        if (!reset) begin
            enemy_x_aux = enemy_x;
            enemy_y_aux = enemy_y;
            enemy_x_dir_aux = 1;
            enemy_y_dir_aux = 1;
        end else begin
            // Enemy movement logic
            if (movement_flag) begin
                // Calculate future positions
                future_x = enemy_x_aux + (enemy_x_speed_aux*enemy_x_dir_aux) - ((10'd1 - enemy_x_dir_aux) * enemy_x_speed_aux);
                future_y = enemy_y_aux + (enemy_y_speed_aux*enemy_y_dir_aux) - ((10'd1 - enemy_y_dir_aux) * enemy_y_speed_aux);

                // Check for overflow caused by the operations above
                if (future_x > 10'd900) begin
                    future_x = 10'd0;
                end if (future_y > 10'd900) begin
                    future_y = 10'd0;
                end

                // Collision with walls
                if (future_x <= 10'd0 || future_x + enemy_size >= 10'd639) begin
                    enemy_x_dir_aux = ~enemy_x_dir_aux;
                end if (future_y <= 10'd0 || future_y + enemy_size >= 10'd479) begin
                    enemy_y_dir_aux = ~enemy_y_dir_aux;
                end

                // Update positions
                enemy_x_aux = future_x;
                enemy_y_aux = future_y;
            end
        end
    end

    assign enemy_x = enemy_x_aux;
    assign enemy_y = enemy_y_aux;
    assign enemy_size = 10'd16;
    assign enemy_sprite = 256'd255;
    assign enemy_color = 8'd127;
    assign enemy_write_enable = 1'b1;

endmodule