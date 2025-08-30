// Comments:
// ////////////////////////////////////////////////////////////////////////////////// 
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


module new ( 
    input [3:0] a, b, 
    input [2:0] select, 
    output [4:0] add_result, sub_result, 
    output [7:0] mul_result, 
    output [3:0] xor_result, and_result, or_result, invt_result 
);

    wire [4:0] add_out, sub_out; 
    wire [7:0] mul_out; 
    wire [3:0] xor_out, and_out, or_out, invt_out; 

    assign add_out = a + b; 
    assign sub_out = a - b; 
    assign xor_out = a ^ b; 
    assign and_out = a & b; 
    assign or_out = a | b; 
    assign invt_out = ~a; 
    assign mul_out = a * b; 

    assign add_result = (select == 3'b000) ? add_out : 5'b0; 
    assign sub_result = (select == 3'b001) ? sub_out : 5'b0; 
    assign xor_result = (select == 3'b010) ? {2'b00, xor_out} : 4'b0; // Pad 2 high bits
    assign and_result = (select == 3'b011) ? {2'b00, and_out} : 4'b0; // Pad 2 high bits
    assign or_result = (select == 3'b100) ? {2'b00, or_out} : 4'b0;   // Pad 2 high bits
    assign invt_result = (select == 3'b101) ? {2'b00, invt_out} : 4'b0; // Pad 2 high bits
    assign mul_result = (select == 3'b110) ? mul_out : 8'b0; 

endmodule
///////////////////////////////////////////////////////////////////////////////// 

// Testbench 
module new_tb; 
    reg [3:0] a, b; 
    reg [2:0] select; // Outputs 
    wire [4:0] add_result, sub_result, xor_result, and_result, or_result, invt_result; 
    wire [7:0] mul_result; 
    
    // Instantiate the ALU 
    new dut( .a(a), .b(b), .select(select), .add_result(add_result), .sub_result(sub_result), 
             .xor_result(xor_result), .and_result(and_result), .or_result(or_result), 
             .invt_result(invt_result), .mul_result(mul_result) ); 

    initial begin 
        $monitor ("Time = %t a = %b b = %b select = %b Add = %b Subtract = %b XOR = %b And = %b OR = %b inverse = %b Mul = %b",
                  $time, a, b, select, add_result, sub_result, xor_result, and_result, or_result, invt_result, mul_result);
        a = 4'b1000; 
        b = 4'b0100; 
        select = 3'b000; 
        #10 a = 4'b1100; b = 4'b0110; select = 3'b001; 
        #10 a = 4'b1010; b = 4'b0101; select = 3'b010; 
        #10 a = 4'b1100; b = 4'b1010; select = 3'b011; 
        #10 a = 4'b1010; b = 4'b0101; select = 3'b100; 
        #10 a = 4'b1100; b = 4'b0000; select = 3'b101; 
        #10 a = 4'b1100; b = 4'b0010; select = 3'b110; 
    end 
endmodule
