module JLUT(
  input[4:0] Jptr,
  output logic[11:0] Jump);

  always_comb case(Jptr)
	0: Jump = 0;  // Outer loop
	2: Jump = 7; // inner looop
	3: Jump = 14; //compare_paris
	4: Jump = 35; //check_greater
	5: Jump = 45; //update_min
	6: Jump = 50; //inc_inner
	7: Jump = 54; //inc_outer_loop
	8: Jump = 60; //End_program
  endcase 

endmodule