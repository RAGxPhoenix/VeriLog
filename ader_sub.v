module full_adder (
    input A,
    input B,
    input Cin,
    output Sum,
    output Cout
);

    assign Sum = A ^ B ^ Cin;

    assign Cout = (A & B) | (B & Cin) | (A & Cin);

endmodule

module adder_sub(
    input [1:0]A,
    input [1:0]B,
    input Cin,
    output [1:0]S,
    output Cout
);
wire w1;

full_adder X0 (.A(A[0]), .B(B[0]^Cin), .Cin(Cin), .Sum(S[0]), .Cout(w1));
full_adder X1 (.A(A[1]), .B(B[1]^Cin), .Cin(w1), .Sum(S[1]), .Cout(Cout));

endmodule

module tb_adder_sub();
   reg [1:0] A, B;
   reg Cin;
   wire [1:0]S;
   wire  Cout;

   adder_sub dut (.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));
      
   initial begin
        $monitor("Time=%t  A = %b  B = %b  Cin = %b  Output = %b Carry = %b", $time, A,B,Cin,S,Cout); 
     

      A = 2'b00;
      B = 2'b11; 
      Cin = 1'b0;
      #10; 
      
      A = 2'b10; 
      B = 2'b10; 
      Cin = 1'b1;
      #10; 
      A = 2'b11; 
      B = 2'b01; 
      Cin = 1'b0;
      #10; 
      A = 2'b10; 
      B = 2'b01; 
      Cin = 1'b1;
      #10; 
  $finish;
   end
endmodule

