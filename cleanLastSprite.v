module cleanLastSprite (  
    input clock,
    input reset,
    input [9:0] x, y,
    input erase_enable,

    output wire [7:0] data_out,
    output wire [9:0] x_out, // coluna de escrita (varia de 0 a 639)
    output wire [9:0] y_out, // linha da escrita (varia de 0 a 479)
    output wire write_enable
);

    reg [7:0] data_aux;
    reg [9:0] x_out_aux;
    reg [9:0] y_out_aux;
    reg [5:0] counter_aux = 5'd0;

	always @(posedge clock) begin
        if (!reset || !erase_enable) begin
            x_out_aux = x;
            y_out_aux = y;
            counter_aux = 5'd0;
            
        end else begin
            data_aux  = 0;
            counter_aux = counter_aux + 5'd1;
            x_out_aux = x + counter_aux % 5'd16;
            y_out_aux = y + counter_aux / 5'd16;
            if (counter_aux >= 256) counter_aux = 5'd0;
        end
    end

assign data_out = data_aux;
assign x_out = x_out_aux;
assign y_out = y_out_aux;
assign write_enable = erase_enable;

endmodule