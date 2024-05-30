module RegFile(
  input      clk,	 // clock
             Wen,    // write enable
  input[2:0] Ra,     // read address pointer A
             Rb,     //                      B
			 Wd,	 // write address pointer
  input[7:0] Wdat,   // write data in
  			Rdat,
  output[7:0]RdatA,	 // read data out A
             RdatB); // read data out B

  logic[7:0] Core[8]; // reg file itself (4*8 array)

  always_ff @(posedge clk)
    if(Wen) Core[Wd] <= Rdat;

  assign RdatA = Core[Ra];
  assign RdatB = Core[Rb];
  

endmodule