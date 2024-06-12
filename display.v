module display(
  input clk, reset,
  input [17:0] entrada,
  output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);

wire [22:0] bcd;


bin2bcd bin2bcd_1(entrada, bcd);


bcd7seg bcd7seg_0 (bcd[3:0], HEX0);
bcd7seg bcd7seg_1 (bcd[7:4], HEX1);
bcd7seg bcd7seg_2 (bcd[11:8], HEX2);
bcd7seg bcd7seg_3 (bcd[12:9], HEX3);
bcd7seg bcd7seg_4 (bcd[16:13], HEX4);
bcd7seg bcd7seg_5 (bcd[20:17], HEX5);

endmodule