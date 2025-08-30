module mux(
    input a,b,s,
    output c
);

assign c = (s==0) ? (a+b) : (a-b);

endmodule

module mux_tb;

reg a,b,s;
wire c;

mux aa (.a(a),.b(b),.s(s),.c(c));

initial 
begin
    $monitor("Time=%t  a = %b  b = %b s = %b  Output = %b", $time, a, b, s,c);

    a = 0;
    b = 0;
    s = 1;
    #100
    a = 0;
    b = 1;
    s = 0;
    #200
    a = 1;
    b = 1;
    s = 1;
    #100
    a = 1;
    b = 0;
    s = 1;
    #200;
    
end
endmodule
