module top_module;
  // Input signals
  wire A, B;
  
  // Output signals
  wire SUM, CARRY;

  // Instantiate the half adder module
  half_adder half_adder_instance(
    .A(A),
    .B(B),
    .SUM(SUM),
    .CARRY(CARRY)
  );
endmodule
