module Top(
  input        clk,
		       reset, 
  output logic done);

  wire[11:0] Jump,
	        PC;
  wire[2:0] Ra,
			Rb,
			Wd;
  wire[3:0] Aluop;
  wire[2:0] Imm;    //
  wire[4:0] Jptr; // 32 possible jump entries
  wire[8:0] mach_code;
  wire[7:0] DatA,	     // ALU data in
            DatB,
			Rslt,		 // ALU data out
			RdatA,		 // RF data out
			RdatB,
			WdatR,		 // RF data in
			WdatD,		 // DM data in
			Rdat,		 // DM data out
			Addr;		 // DM address
  wire      Jen,		 // PC jump enable
            Par,         // ALU parity flag
			SCo,         // ALU shift/carry out
            Zero,        // ALU zero flag
			WenR,		 // RF write enable
			WenD,		 // DM write enable
			Ldr,		 // LOAD
			Str;		 // STORE

assign  DatA = RdatA;
assign  DatB = RdatB; 
assign  WdatR = Rslt;
  
assign done = PC == 58 ? 1 : 0;
 

JLUT JL1(
  .Jptr,
  .Jump);

ProgCtr PC1(
  .clk,
  .reset,
  .Jen,
  .Jump,
  .PC);

InstROM IR1(
  .PC,
  .mach_code);

Ctrl C1(
  .mach_code,
  .Aluop,
  .Jptr,
  .Ra,
  .Rb,
  .Wd,
  .WenR,
  .WenD,
  .Ldr,
  .Str,
  .Jen,
  .Imm
);

RegFile RF1(
  .clk,
  .Wen(WenR),
  .Ra,
  .Rb,
  .Wd,
  .Wdat(WdatR),
  .RdatA,
  .RdatB
);

ALU A1(
  .Aluop,
  .DatA,
  .DatB,
  .Rslt,
  .Zero,
  .Par,
  .SCo,
  .Imm,
  .Jen
);

DMem dm(
  .clk,
  .Wen (WenD),
  .WDat(WdatD),
  .Addr,
  .Rdat);


endmodule