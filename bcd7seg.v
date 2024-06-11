module bcd7seg(
    input [3:0] caracter,
    output reg [6:0] digito
);  

always @(*) begin
    case(caracter)
        4'b0000: digito = 7'b0011000; // P
        4'b0001: digito = 7'b0001000; // A
        4'b0010: digito = 7'b1000100; // Y
        4'b0011: digito = 7'b0100100; // S
        4'b0100: digito = 7'b0001000; // A
        4'b0101: digito = 7'b0001001; // N
        4'b0110: digito = 7'b1000010; // D
        4'b0111: digito = 7'b1000001; // U
        4'b1000: digito = 7'b1111111; // vazio
        default: digito = 7'b1111111; // Entrada inválida
    endcase
end

endmodule