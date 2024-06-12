module counter (
    input wire CLOCK_50 ,
    output reg [17:0] seconds
);

reg [31:0] count;

always @(posedge clk) begin
    if (count == 50000000) begin
        count <= 0;
        seconds <= seconds + 1;
    end else begin
        count <= count + 1;
    end
end

endmodule