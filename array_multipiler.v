module full_adder(
    input a, b, c,
    output Cout, sum
);

assign Cout = a ^ b ^ c;
assign sum = (a & b) | (b & c) | (c & a);

endmodule

module array_multiplier(
    input [2:0] a, b,
    output [5:0] s
);
wire [5:0] w;

assign s[0] = a[0] & b[0];
//wrong logic lol
full_adder a0 (.a(a[1] & b[0]), .b(a[0] & b[1]), .c(1'b0), .Cout(w[0]), .sum(s[1]));
full_adder a1 (.a(a[2] & b[0]), .b(a[1] & b[1]), .c(w[0]), .Cout(w[1]), .sum(w[2]));
full_adder a2 (.a(a[0] & b[2]), .b(w[1]), .c(1'b0), .Cout(w[3]), .sum(s[2]));
full_adder a3 (.a(a[2] & b[1]), .b(w[2]), .c(w[3]), .Cout(w[5]), .sum(w[4]));
full_adder a4 (.a(a[1] & b[2]), .b(w[4]), .c(1'b0), .Cout(w[5]), .sum(s[3]));
full_adder a5 (.a(a[2] & b[2]), .b(w[4]), .c(w[5]), .Cout(s[5]), .sum(s[4]));

endmodule

module array_multiplier_tb;

reg [2:0] a, b;
wire [5:0] s;

array_multiplier X90 (.a(a), .b(b), .s(s));

initial 
begin
  $monitor("Time=%t  a = %b  b = %b  Output = %b", $time, a, b, s);

  // Test cases
  a = 3'b100;
  b = 3'b101;
  #100;
  
  a = 3'b111;
  b = 3'b101;
  #100;
  
  a = 3'b001;
  b = 3'b101;
  #100;

  $finish;
end

endmodule
