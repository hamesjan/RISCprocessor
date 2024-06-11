module JLUT(
  input[4:0] Jptr,
  output logic[11:0] Jump);

  always_comb case(Jptr)
//   0: Jump = 58;  // end
 //   1: Jump = 51; // inc_outer_loop
//  2: Jump = 42; // update_min 

//  3: Jump = 47; // inc_inner_loop
 //   4: Jump = 32; // check_greater
//    5: Jump = 6; //inner
//    6: Jump = 0; //outer

		0: Jump = 0;  //outer_loop
		1: Jump = 9; //inner_loop 
		2: Jump = 39; //left_neg  
		3: Jump = 59; //same_sign 
		4: Jump = 80; // equal
		5: Jump = 86; //rll
		6: Jump = 92; //compare_left_greater_right
		7: Jump = 106; //comp_min_max
		8: Jump = 136; //msb_equal
		9: Jump = 155; //check_max
		10: Jump = 175; //msb_equal_max
		11: Jump = 194; //inner_end
		12: Jump = 196; //outer_loop_end
    
    default: Jump = 0;
  endcase 

endmodule