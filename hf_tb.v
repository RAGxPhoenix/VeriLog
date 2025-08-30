// Half Adder module
module half_adder(input wire a, input wire b, output wire sum, output wire carry);
    assign sum = a ^ b;
    assign carry = a & b;
endmodule

// Testbench module
module testbench;
    reg a, b;
    wire sum, carry;

    // Instantiate the half adder
    half_adder ha_inst(.a(a), .b(b), .sum(sum), .carry(carry));

    // Stimulus generation
    initial begin
        $monitor("Time=%t a=%b b=%b sum=%b carry=%b", $time, a, b, sum, carry);

        a = 0; b = 0;
        #10;
        
        a = 0; b = 1;
        #10;
        
        a = 1; b = 0;
        #10;
        
        a = 1; b = 1;
        #10;

        $finish;
    end
endmodule

