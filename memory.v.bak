module memory (
    input wire clk_read, clk_write,
    input wire write_enable_ch1, write_enable_ch2, write_enable_ch3, write_enable_ch4,
    input wire [9:0] r_x_address, r_y_address,
    input wire [9:0] w1_x_address, w1_y_address,
    input wire [9:0] w2_x_address, w2_y_address,
    input wire [9:0] w3_x_address, w3_y_address,
    input wire [9:0] w4_x_address, w4_y_address,
    
    input wire [7:0] data_in_ch1, data_in_ch2, data_in_ch3, data_in_ch4,
    output reg [7:0] data_out
);

    reg [7:0] memory [479:0][639:0];

    always @(posedge clk_write) begin
        if (write_enable_ch1) begin
            memory[w1_y_address][w1_x_address] <= data_in_ch1;
        end
        if (write_enable_ch2) begin
            memory[w2_y_address][w2_x_address] <= data_in_ch2;
        end
        if (write_enable_ch3) begin
            memory[w3_y_address][w3_x_address] <= data_in_ch3;
        end
        if (write_enable_ch4) begin
            memory[w4_y_address][w4_x_address] <= data_in_ch4;
        end
    end

    always @(posedge clk_read) begin
        data_out <= memory[r_x_address][r_y_address];
    end 
    
endmodule
