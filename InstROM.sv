module InstROM(
  input[5:0] PC,
  output logic[8:0] mach_code);

  logic[8:0] Core[4096]; // must not exceed 2^12 entries

  initial 
    $readmemb("mach_code_prog_1.txt",Core);

  always_comb mach_code = Core[PC];

endmodule