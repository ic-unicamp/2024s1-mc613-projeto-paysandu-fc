module display(
  input [17:0] entrada1, entrada2,
  output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);

wire [22:0] bcd1;
wire [22:0] bcd2;

bin2bcd bin2bcd_1(entrada1, bcd2);
bin2bcd bin2bcd_2(entrada2, bcd1);

bcd7seg bcd7seg_0 (bcd1[3:0], HEX0);
bcd7seg bcd7seg_1 (bcd1[7:4], HEX1);
bcd7seg bcd7seg_2 (bcd1[11:8], HEX2);

bcd7seg bcd7seg_3 (bcd2[3:0], HEX3);
bcd7seg bcd7seg_4 (bcd2[7:4], HEX4);
bcd7seg bcd7seg_5 (bcd2[11:8], HEX5);

endmodule