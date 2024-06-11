module DMem(
  input clk,
        Wen,
  input[7:0] WDat,
             Addr,
  output logic[7:0] Rdat);

  logic[7:0] core[256];

  always_ff @(posedge clk)
    if(Wen) begin
      core[Addr] <= WDat;
      $display("writing %d to addr: %d",WDat,Addr);
    end

  assign Rdat = core[Addr];

endmodule





