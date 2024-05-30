module Ctrl(
  input        [8:0] mach_code,
  input		   		 Jen, // jump flag
  output logic [3:0] Aluop,
  output logic [4:0] Jptr,
  output logic [2:0] Ra,
			         Rb,
			         Wd,
  					 Imm,
  output logic       WenR,
					 WenD,
					 Ldr,
					 Str

);

  // 876_543_210
  // 000_000_000
  
  always_comb begin
	Aluop = 4'b0000;
	Jptr = 5'b00000;
	Ra = 3'b000;
	Rb = 3'b000;
	Wd = 3'b000;
	Imm = 3'b000;
	WenR = 1'b0;
	WenD = 1'b0;
	Ldr = 1'b0;
	Str = 1'b0;
case(mach_code[8:6]) 
    3'b000: begin // Load/Store
      Ldr = !mach_code[5]; 
      Str = mach_code[5]; 
      
      if (Ldr) begin
        // load address in Ra into Wd register
        Wd = mach_code[4:2]; 
        Ra = mach_code[1:0]; 
      end else begin
		// store value in Ra into address in Rb register
        Ra = mach_code[4:3]; 
      	Rb = mach_code[2:0];
      end
      WenR = Ldr;         
      WenD = Str;       
    end
    3'b010: begin // ALU
      Aluop = {2'b00, mach_code[5:4]}; // Function code determines ALU operation
      Ra = mach_code[3:2];    // Source register 1
      Rb = mach_code[1:0];    // Source register 2
      Wd = mach_code[3:2];    // Destination register
      
      WenR = 1'b1; 
      
      if (mach_code[5:4] == 2'b11) begin
          Ra = mach_code[1:0];
          Wd = mach_code[1:0];
        if (mach_code[3:2] == 2'b00) begin
           Aluop = 4'b0011;
        end else if (mach_code[3:2] == 2'b10) begin
          Aluop = 4'b0100;
        end else if (mach_code[3:2] == 2'b01) begin
           Aluop = 4'b0101;
        end
      end
       
    end
  3'b100: begin //  Jump (brc_jump, jump)
            Jptr = mach_code[4:0];  // regular jump
			Aluop = 4'b1101;
    /* if (mach_code[5] == 1'b1) begin
        Jptr = mach_code[4:0];  // regular jump
      end else begin
        if (Jen)begin
          Jptr = mach_code[4:0]; // brc_jmp
        end
        end
          
      end */
      
    //   Jptr = mach_code[4:0]; // brc_jmp

  end
  	3'b101: begin // blt
      Ra = mach_code[5:3];   
      Rb = mach_code[2:0];
    
      Aluop = 4'b0110;
      end 
    3'b110: begin // beq
      Ra = mach_code[5:3];   
      Rb = mach_code[2:0];  
      Aluop = 4'b0111;
     end 
  	3'b001: begin // mov
      Ra = mach_code[5:3];
      Rb = mach_code[2:0];
      Wd = mach_code[2:0]; 
      WenR = 1'b1;          
      Aluop = 4'b1000;
    end
  	3'b011: begin // shift
      Ra = mach_code[5:3]; 
      Imm = mach_code[2:0];
      Wd = mach_code[5:3];
      Aluop = 4'b1001;
      WenR = 1'b1; 
    end
  
    3'b111: begin // Immediate arithmetic (Addi, Subi)
      Aluop = {3'b101, mach_code[5]}; // 0 for Addi, 1 for Subi
      Ra = mach_code[4:3];    // Operand register
      Wd = mach_code[4:3];    // Destination register
      Imm = mach_code[2:0];
      WenR = 1'b1;            // Enable register write
    end
	 
	 
endcase
  end
endmodule