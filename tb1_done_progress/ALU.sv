module ALU(
  input [3:0] Aluop,
  input [2:0] Imm,
  input [7:0] DatA,
              DatB,
  input clk, reset,
  output logic[7:0] Rslt,
  output logic      Zero,
                    Par,
  					Jen,
  					Brc_J);
  
  logic signed [2:0] signed_imm;
  logic SCo;
  logic carryIn;

  always_ff @(posedge clk) begin
    if(reset) carryIn <= 0;
    else
      carryIn <= SCo;
  end

always_comb begin
  Rslt = 8'b00000000;
  SCo  = 1'b0;
  Jen = 1'b0;
  Brc_J = 1'b0;
  signed_imm = 3'b000;
  
  case(Aluop)
    4'b0000: Rslt = DatA ^ DatB;   // xor
    4'b0001: {SCo, Rslt} = DatA + DatB + carryIn; // add
    4'b0010: {SCo, Rslt} = DatA - DatB - carryIn;    // sub
    4'b0011: 
      if (DatA > 0) begin
          Rslt = 8'b00000000;
        end else begin
          Rslt = 8'b00000001;
        end  
    // Sign function
    4'b0100:  Rslt = ~DatA;   // count bits
    4'b0101: begin                      
        Rslt = 0; 
      for (int i = 0; i < 9; i++) begin
          if (DatA[i] == 1) begin
            Rslt = Rslt + 1;
          end
        end
      end
    4'b0110: if(DatA < DatB) begin //blt
            Brc_J = 0;
    end else begin
            Brc_J = 1;
    end 
    4'b0111: if(DatA == DatB) begin  //beq
            Brc_J = 0;
    end else begin
            Brc_J = 1;
    end 
    
    4'b1000: Rslt = DatA;
    4'b1001: begin
        signed_imm = Imm;
        if (signed_imm >= 0) begin
            Rslt = DatA << signed_imm;  
        end else begin
            Rslt = DatA >> -signed_imm; 
        end
    end
    4'b1010:
    {SCo,Rslt} = DatA + Imm + carryIn;
    4'b1011:
    {SCo,Rslt} = DatA - Imm - carryIn;
	 4'b1100: begin
       Jen = 1;
       Brc_J = 0;
     end
    4'b1101: begin 
      Jen = 1; 
      Brc_J = 0;
	end
    4'b1010:
    {SCo, Rslt} = DatA + Imm + carryIn;
    4'b1011:
    {SCo, Rslt} = DatA - Imm - carryIn;
	 default: begin
	 SCo = 1'b0;
	 Rslt = 8'b0;
	 Jen = 1'b0;
     Brc_J = 0;

	 end
  endcase
end

  assign Zero = !Rslt;
  assign Par  = ^Rslt;

endmodule