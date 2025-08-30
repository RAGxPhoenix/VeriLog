module up_counter(
    input clk,
    input rst,
    output reg [2:0] q
);

always @(posedge clk) begin
    if (rst == 1)
        q = 3'b0;
    else
        q = q + 3'b1;
end
endmodule

module up_3bit_counter_tb;

reg clk,rst;
wire [2:0] q;

up_counter css (.clk(clk),.rst(rst),.q(q));

initial
begin
    $monitor ("time = %t rst = %b clk = %b q = %b",time,rst,clk,q);
    rst = 1'b0;

    clk = 1'b0;

    repeat(10)begin
        #10 clk = ~clk;
    end
end
endmodule
