module JLUT(
  input[4:0] Jptr,
  output logic[5:0] Jump);

  always_comb case(Jptr)
	0: Jump = 0;  // Outer loop
	1: Jump = 7; // inner looop
	2: Jump = 42; // update_min
	3: Jump = 33; // check greater
    4: Jump = 49; //end
  endcase 

endmodule