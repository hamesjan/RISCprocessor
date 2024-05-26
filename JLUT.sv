module JLUT(
  input[4:0] Jptr,
  output logic[11:0] Jump);

  parameter int p_flag = 1;



if(p_flag == 0) begin  : program1_block
  always_comb case(Jptr)
    0: Jump = 58;  // end
	1: Jump = 51; // inc_outer_loop
	2: Jump = 42; // update_min 
	3: Jump = 47; // inc_inner_loop
    4: Jump = 32; // check_greater
    5: Jump = 6; //inner
    6: Jump = 0; //outer
    
    default: Jump = 0;
  endcase 
end

if(p_flag == 1) begin  : program2_block
	always_comb case(Jptr)
		0: Jump = 0;  //
		1: Jump = 5; // 
		2: Jump = 35; //  
		3: Jump = 55; // 
		4: Jump = 76; // 
		5: Jump = 82; //
		6: Jump = 88; //
		7: Jump = 102;
		8: Jump = 115;
		9: Jump = 124;
		10: Jump = 136;
		11: Jump = 145;
		12: Jump = 147; 
		
		default: Jump = 0;
  endcase 
end

endmodule