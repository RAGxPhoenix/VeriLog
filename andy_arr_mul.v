module fulladder(
    input a,b,cin,
    output cout,s
);
    assign cout=(a&b)|(b&cin)|(cin&a);
    assign s=a^b^cin;
endmodule

module array_mul(
    input [2:0]a,b,
    output [5:0]s
    );
    wire [6:0]w;
    assign s[0]=a[0]&b[0];
    fulladder f1(.a(a[1]&b[0]),.b(a[0]&b[1]),.cin(0),.cout(w[0]),.s(s[1]));
    fulladder f2(.a(a[2]&b[0]),.b(a[1]&b[1]),.cin(w[0]),.cout(w[1]),.s(w[2]));
    fulladder f3(.a(w[2]),.b(a[0]&b[2]),.cin(0),.cout(w[3]),.s(s[2]));
    fulladder f4(.a(w[1]),.b(w[3]),.cin(a[2]*b[1]),.cout(w[5]),.s(w[4]));
    fulladder f5(.a(w[4]),.b(a[1]&b[2]),.cin(0),.cout(w[6]),.s(s[3]));
    fulladder f6(.a(w[5]),.b(w[6]),.cin(a[2]&b[2]),.cout(s[5]),.s(s[4]));
endmodule

module array_multiplier_tb;

reg [2:0] a, b;
wire [5:0] s;

array_mul X90 (.a(a), .b(b), .s(s));

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

  a = 3'b000;
  b = 3'111;
  #100;

  $finish;
end

endmodule
