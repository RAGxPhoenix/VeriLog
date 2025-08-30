module full_adder(
    input a,
    input b,
    input cin,
    output cout ,carry
);

assign cout = a^b^cin;
assign carry = (a&b)|(b&cin)|(a&cin);

endmodule

module three_mul(
    input [2:0] a,b,
    output [5:0]s
);

wire [6:0]w;

assign s[0] = a[0] & b[0];

full_adder a1 (.a(a[1]&b[0]),.b(a[0]&b[1]),.cin(1'b0),.cout(s[1]),.carry(w[0]));

full_adder a2 (.a(a[2]&b[0]),.b(a[1]&b[1]),.cin(w[0]),.cout(w[3]),.carry(w[1]));

full_adder a3 (.a(a[0]&b[2]),.b(w[3]),.cin(1'b0),.cout(s[2]),.carry(w[2]));

full_adder a4 (.a(w[1]),.b(a[2]&b[1]),.cin(w[2]),.cout(w[4]),.carry(w[5]));

full_adder a5 (.a(a[1]&b[2]),.b(w[4]),.cin(1'b0),.cout(s[3]),.carry(w[6]));

full_adder a6 (.a(a[2]&b[2]),.b(w[5]),.cin(w[6]),.cout(s[4]),.carry(s[5]));

endmodule

module three_alu(
    input [2:0]a,b,
    input [1:0]select,
    output [3:0] sum,invert_sum,
    output [2:0] sub,
    output [5:0] mul
);

wire [3:0]t_sum;
wire [3:0]t_invert_sum;
wire [2:0]t_sub;
wire [5:0]t_mul;

assign t_sum = a+b;
assign t_invert_sum = ~(a) + ~(b);
assign t_sub = a-b;
three_mul XX (.a(a),.b(b),.s(t_mul));

assign sum = (select == 2'b00) ? t_sum : 0;
assign invert_sum = (select == 2'b01) ? t_invert_sum : 0;
assign sub = (select == 2'b10) ? t_sub : 0;
assign mul = (select == 2'b11) ? t_mul : 0;

endmodule


module tb_is;

reg [2:0]a,b;
reg [1:0]select;
wire [3:0] sum,invert_sum;
wire [2:0] sub;
wire [5:0] mul;

three_alu rr (.a(a),.b(b),.select(select),.sum(sum),.invert_sum(invert_sum),.sub(sub),.mul(mul));

initial begin
    $monitor("Time = %t a = %b b = %b select = %b sum = %b invert = %b sub = %b mul = %b",$time,a,b,select,sum,invert_sum,sub,mul);

    a = 3'b011;
    b = 3'b111;
    select = 2'b00;
    #10
    a = 3'b011;
    b = 3'b111;
    select = 2'b01;
    #10
    a = 3'b011;
    b = 3'b111;
    select = 2'b10;
    #10
    a = 3'b011;
    b = 3'b111;
    select = 2'b11;

end

endmodule