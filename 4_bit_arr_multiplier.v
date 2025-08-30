module fulladder(
    input a,b,cin,
    output cout,s
);
    assign cout=(a&b)|(b&cin)|(cin&a);
    assign s=a^b^cin;
endmodule


module four_bitarrmul(
    input [3:0]a,b,
    output [7:0]s
);
wire [16:0]w;

assign s[0] = a[0]&b[0];

fulladder X0 (.a(a[1]&b[0]),.b(a[0]&b[1]),.cin(0),.cout(w[0]),.s(s[1]));

fulladder X1 (.a(a[2]&b[0]),.b(a[1]&b[1]),.cin(w[0]),.cout(w[2]),.s(w[1]));

fulladder X2 (.a(w[1]),.b(a[0]&b[2]),.cin(0),.cout(w[6]),.s(s[2]));

fulladder X3 (.a(a[3]&b[0]),.b(a[2]&b[1]),.cin(w[2]),.cout(w[3]),.s(w[4]));

fulladder X4 (.a(a[1]&b[2]),.b(w[4]),.cin(w[6]),.cout(w[7]),.s(w[5]));

fulladder X5 (.a(w[5]),.b(a[0]&b[3]),.cin(0),.cout(w[9]),.s(s[3]));

fulladder X6 (.a(w[3]),.b(w[7]),.cin(a[3]&b[1]),.cout(w[12]),.s(w[8]));

fulladder X7 (.a(w[8]),.b(w[9]),.cin(a[2]&b[2]),.cout(w[11]),.s(w[10]));

fulladder X8 (.a(w[10]),.b(a[1]&b[3]),.cin(0),.cout(w[14]),.s(s[4]));

fulladder X9 (.a(w[12]),.b(w[11]),.cin(a[3]&b[2]),.cout(w[15]),.s(w[13]));

fulladder X10 (.a(w[13]),.b(w[14]),.cin(a[2]&b[3]),.cout(w[16]),.s(s[5]));

fulladder X11 (.a(w[15]),.b(w[16]),.cin(a[3]&b[3]),.cout(s[7]),.s(s[6]));

endmodule

module four_bit_test_bench;

reg [3:0]a,b;
wire [7:0]s;

four_bitarrmul XX (.a(a),.b(b),.s(s));

initial
begin
    
    $monitor("Time=%t  a = %b  b = %b  Output = %b", $time, a, b, s);

  // Test cases
  a = 3'b100;
  b = 3'b101;
  #100;
  
  a = 4'b1111;
  b = 4'b1011;
  #100;
  
  a = 4'b0001;
  b = 4'b1010;
  #100;

  a = 4'b000;
  b = 4'b1110;
  #100;

  $finish;
end

endmodule



