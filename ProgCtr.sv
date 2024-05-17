module ProgCtr(
  input             clk,
                    reset,
					Jen,
  input       [5:0] Jump,
  output logic[5:0] PC);

  always_ff @(posedge clk)
    if(reset) PC <= 'b0;
	else if(Jen) PC <= Jump;
	else      PC <= PC + 6'd1;

endmodule