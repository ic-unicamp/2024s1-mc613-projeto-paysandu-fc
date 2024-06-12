module top(
    input CLOCK_50,
    input reset, keyRestart,
    input keyUp, KeyDown, keyLeft, keyRight, // keys para movimentação
    
    output wire VGA_HS, VGA_VS,
    output wire [7:0] VGA_R, VGA_G, VGA_B,
    output wire VGA_SYNC_N, VGA_BLANK_N, VGA_CLK,
    output wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);

gameController gameController(
    .CLOCK_50(CLOCK_50),
    .reset(reset),
    .keyRestart(keyRestart),
    .keyUp(keyUp),
    .KeyDown(KeyDown),
    .keyLeft(keyLeft),
    .keyRight(keyRight),
    .VGA_HS(VGA_HS),
    .VGA_VS(VGA_VS),
    .VGA_R(VGA_R),
    .VGA_G(VGA_G),
    .VGA_B(VGA_B),
    .VGA_SYNC_N(VGA_SYNC_N),
    .VGA_BLANK_N(VGA_BLANK_N),
    .VGA_CLK(VGA_CLK),
    .HEX0(HEX0),
    .HEX1(HEX1),
    .HEX2(HEX2),
    .HEX3(HEX3),
    .HEX4(HEX4),
    .HEX5(HEX5)
);





endmodule