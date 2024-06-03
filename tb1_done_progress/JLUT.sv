module JLUT(
  input[4:0] Jptr,
  output logic[5:0] Jump);

  always_comb case(Jptr)
    0: Jump = 58;  // end
	1: Jump = 51; // inc_outer_loop
	2: Jump = 42; // update_min 
  //  3: Jump = 58;
	3: Jump = 47; // inc_inner_loop
    4: Jump = 32; // check_greater
    5: Jump = 6; //inner
    6: Jump = 0; //outer
    
    default: Jump = 0;
  endcase 

endmodule