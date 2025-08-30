module testbench;

    // Inputs
    reg a;
    reg b;

    // Outputs
    wire sum;
    wire carry;

    // Instantiate the half adder module
    half_adder half_adder_inst (
        .a(a),
        .b(b),
        .sum(sum),
        .carry(carry)
    );

    // Stimulus
    initial begin
        $display("a b | sum carry");
        $display("---------|---------");
        for (a = 0; a <= 1; a = a + 1) begin
            for (b = 0; b <= 1; b = b + 1) begin
                #10; // Delay for one time unit
                $display("%b %b |   %b     %b", a, b, sum, carry);
            end
        end
        $finish; // End simulation
    end

endmodule
