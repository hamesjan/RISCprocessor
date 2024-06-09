module InstROM(
  input[11:0] PC,
  output logic[8:0] mach_code);

  logic[8:0] Core[4096]; // must not exceed 2^12 entries

  initial 
    $readmemb("generated_p2.txt",Core);

  always_comb mach_code = Core[PC];

endmodule