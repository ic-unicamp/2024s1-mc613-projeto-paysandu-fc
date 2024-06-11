/*Aqui colocar o contador pra ficar passando PAYSANDU*/
module top(
    input CLOCK50, reset,

    output [6:0] HEX5,HEX4,HEX3,HEX2,HEX1,HEX0
);

wire [3:0] count;


counter counter(
    .clk(CLOCK50),
    .count(count)
);

bcd7seg bcd7seg(count, HEX0);
bcd7seg bcd7seg(count+1, HEX1);
bcd7seg bcd7seg(count+2, HEX2);
bcd7seg bcd7seg(count+3, HEX3);
bcd7seg bcd7seg(count+4, HEX4);
bcd7seg bcd7seg(count+5, HEX5);

endmodule