module bcd7seg(
    input [3:0] bcd,
    output reg [6:0] digito
);  

always @(*) begin
    case(bcd)
        4'b0000: digito = 7'b1000000; // 0
        4'b0001: digito = 7'b1111001; // 1
        4'b0010: digito = 7'b0100100; // 2
        4'b0011: digito = 7'b0110000; // 3
        4'b0100: digito = 7'b0011001; // 4
        4'b0101: digito = 7'b0010010; // 5
        4'b0110: digito = 7'b0000010; // 6
        4'b0111: digito = 7'b1111000; // 7
        4'b1000: digito = 7'b0000000; // 8
        4'b1001: digito = 7'b0010000; // 9
        default: digito = 7'b1111111; // Entrada inválida
    endcase
end

endmodule