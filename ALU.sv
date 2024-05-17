module ALU(
  input [3:0] Aluop,
  input [2:0] Imm,
  input [7:0] DatA,
              DatB,
  output logic[7:0] Rslt,
  output logic      Zero,
                    Par,
  					Jen,
  SCo);
  
  logic signed [2:0] signed_imm;

always_comb begin
  Rslt = 8'b0;
  SCo  = 8'b0;
  case(Aluop)
    4'b0000: {SCo,Rslt} = DatA ^ DatB;   // xor
    4'b0001: {SCo,Rslt} = DatA + DatB; // add
    4'b0010: {SCo,Rslt} = DatA - DatB;    // sub
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
        for (int i = 0; i < 8; i++) begin
          if (DatA[i]) begin
            Rslt++;
          end
        end
      end
    4'b0110: if(DatA < DatB) begin 
            Jen = 1;
    end else begin
            Jen = 0;
    end 
    4'b0111: if(DatA < DatB) begin 
            Jen = 1;
    end else begin
            Jen = 0;
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
    {SCo,Rslt} = DatA + Imm;
    4'b1011:
    {SCo,Rslt} = DatA - Imm;
  endcase
end

  assign Zero = !Rslt;
  assign Par  = ^Rslt;

endmodule