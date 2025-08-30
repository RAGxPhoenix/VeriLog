module adder_subtractor (output out,input a,input b,input c);
    wire [7:0] w;

    not (w2,b);
    and (w1,a,w2);
    not (w3,a);
    and (w4,w3,b);
    not (w7,c);
    and (w8,w7,w6);
    or (out,w1,w4,w8);
endmodule

module adder_subtractor_tb();
    reg a, b, c;
    wire out;
    integer i;
    adder_subtractor x(.out(out), .a(a), .b(b), .c(c)); 

    initial 
    begin
        $monitor("Time=%t c=%b a=%b b=%b output=%b", $time, c, a, b, out); 
        
        for (i = 0; i < 8; i++)
        begin
            {c,a,b} = i;
            #100;
        end

        $finish;
    end
endmodule
