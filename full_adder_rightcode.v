//Main_Code

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

module four_bit_adder (
    input [3:0] A,
    input [3:0] B,
    output [3:0] Sum,
    output Cout
);

    wire c0,c1, c2,c3;
    assign c0 = 0;
    full_adder FA0 (
        .A(A[0]), .B(B[0]), .Cin(c0), .Sum(Sum[0]), .Cout(c1)
    );

    full_adder FA1 (
        .A(A[1]), .B(B[1]), .Cin(c1), .Sum(Sum[1]), .Cout(c2)
    );

    full_adder FA2 (
        .A(A[2]), .B(B[2]), .Cin(c2), .Sum(Sum[2]), .Cout(c3)
    );

    full_adder FA3 (
        .A(A[3]), .B(B[3]), .Cin(c3), .Sum(Sum[3]), .Cout(Cout)
    );

endmodule

//Test_Bench

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.08.2023 15:08:51
// Design Name: 
// Module Name: tb_four_bit_adder_with_half_adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_four_bit_adder_with_half_adder();

    reg [3:0] A, B;
    wire [3:0] S;
    wire Cout;

    four_bit_adder U1 (.A(A), .B(B), .Sum(S), .Cout(Cout));

    initial 
    begin
        $monitor("Time=%t A=%b B=%b carry = %b output=%b", $time, A, B, Cout,S); 
    
    A = 4'b1001;
    B = 4'b1100;
    #100;
    A = 4'b0000;
    B = 4'b1100;
    #100;
    A = 4'b1011;
    B = 4'b1100;
    #100;
    A = 4'b1001;
    B = 4'b1100;
    #100;
    A = 4'b1000;
    B = 4'b1100;
    #100;
   
    $finish;
    end

endmodule