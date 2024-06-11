module counter (
    input wire clk,
    output reg [3:0] count
);

wire [25:0] counter = 0;

always @(posedge clk) begin
    counter <= counter + 1;
    if(!reset)begin
        counter <= 0;   
    end else begin
        if(counter == 26'd50000000) begin
            counter <= 0;
            if (count == 9)begin
                count <= 0;
            end
            else begin
                count <= count + 1;
            end
        end
    end
end

endmodule