module memory (
    input wire clk_read, clk_write,
    input wire write_enable_ch1, write_enable_ch2,
    input wire [9:0] r_x_address, r_y_address,
    input wire [9:0] w1_x_address, w1_y_address,
    input wire [9:0] w2_x_address, w2_y_address,
    
    input wire [7:0] data_in_ch1, data_in_ch2,
    output reg [7:0] data_out
);

    reg [7:0] memory [639:0][479:0];

    always @(posedge clk_write) begin
        if (write_enable_ch1) begin
            memory[w1_x_address][w1_y_address] <= data_in_ch1;
        
		  end if (write_enable_ch2) begin
            memory[w2_x_address][w2_y_address] <= data_in_ch2;
		  end
    end

    always @(posedge clk_read) begin
        data_out <= memory[r_x_address][r_y_address];
    end 
    
endmodule
