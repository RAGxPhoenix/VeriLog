// Code your design here
module adder(
    input a,
    input b,
    output sum,
    output carry
);

assign sum = a^b;
assign carry = a*b;
endmodule

module subtractor(
    input a,
    input b,
    output sub,
    output borr
);

assign borr = ~(a) * b;
assign sub = a^b;

endmodule

module adder_sub(
    input [1:0] a,
    input [1:0] b,
    input c,
    output [1:0] sum,
    output carry,
    output [1:0] sub,
    output borrow
);

    wire [1:0] adder_sum;
    wire adder_carry;
    wire [1:0] subtractor_sub;
    wire subtractor_borrow;

    adder add_inst (
        .a(a), .b(b), .sum(adder_sum), .carry(adder_carry)
    );

    subtractor sub_inst (
        .a(a), .b(b), .sub(subtractor_sub), .borr(subtractor_borrow)
    );

    assign sum = (c == 0) ? adder_sum : subtractor_sub;
    assign carry = adder_carry;
    assign sub = (c == 1) ? subtractor_sub : adder_sum;
    assign borrow = subtractor_borrow;

endmodule


`timescale 1ns / 1ps

module tb_adder_subtractor();

    reg [1:0] a;
    reg [1:0] b;
    reg c;
    wire [1:0] sum;
    wire [1:0] sub;
    wire borr;
    wire car;

    adder_sub x (
        .a(a), .b(b), .c(c), .sum(sum), .carry(car), .sub(sub), .borrow(borr));

    initial begin
        a = 2'b01;
        b = 2'b11;
        c = 0;
        #10;  

        a = 2'b01;
        b = 2'b11;
        c = 0;
        #10; 
        $dumpfile("dump.vcd"); 
      	$dumpvars;


        $finish;
    end

endmodule