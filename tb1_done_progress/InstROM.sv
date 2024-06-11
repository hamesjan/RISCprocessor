module InstROM(
  input[11:0] PC,
  output logic[8:0] mach_code);

  logic[8:0] Core[4096]; // must not exceed 2^12 entries

  initial 
    $readmemb("C:/Users/jal042/Desktop/RISCprocessor/tb1_done_progress/m_p2.txt",Core);
   // $readmemb("ld_str.txt", Core);
  always_comb mach_code = Core[PC];

endmodule