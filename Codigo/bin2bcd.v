module bin2bcd
 #( parameter                W = 18)  // input width
  ( input      [W-1      :0] bin   ,  // binary
    output reg [W+(W-4)/3:0] bcd   ); // bcd {...,thousands,hundreds,tens,ones}

  integer i,j;

  always @(bin) begin
    for(i = 0; i <= W+(W-4)/3; i = i+1) begin
      bcd[i] = 0;     // initialize with zeros
    end

    bcd[W-1:0] = bin;                                   // initialize with input vector
    for(i = 0; i <= W-4; i = i+1) begin                       // iterate on structure depth
      for(j = 0; j <= i/3; j = j+1) begin                     // iterate on structure width
        if (bcd[W-i+4*j -: 4] > 4) begin                      // if > 4
          bcd[W-i+4*j -: 4] = bcd[W-i+4*j -: 4] + 4'd3; // add 3
        end
      end
    end
    
  // these if statmens hides redundant zeros in the most significant digits
  // this is possible because bcd outputs higher than 9(1001) are ignored
    if (bcd[11:8] == 4'b0000) begin
        bcd[11:8] = 4'b1111;
        if (bcd[7:4] == 4'b0000)
            bcd[7:4] = 4'b1111;
    end

  end
endmodule