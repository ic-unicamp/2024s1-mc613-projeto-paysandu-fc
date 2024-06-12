module ball_mov_counter (
    input clk, reset, 
    input [31:0] velocity,
    output reg movement_flag
);
    reg [31:0] max_count;
    reg [31:0] counter = 0;
	 
	always @(posedge clk) begin
        max_count = 32'd400000000 / velocity;

        if (!reset) begin
            counter <= 0;
            movement_flag <= 0;
        end else begin
            if (counter < max_count) begin
                counter <= counter + 32'd1;
                movement_flag <= 0;
            end else begin
                counter <= 0;
                movement_flag <= 1;
            end
        end
    end
endmodule