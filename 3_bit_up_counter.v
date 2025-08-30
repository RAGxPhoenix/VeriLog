module up_3bit_counter (
  input clk,
  input rst,
  output reg [2:0] q
);

  always @(posedge clk , negedge rst) begin
    if (!rst)
      q = 3'b000;
    else
      q = q + 001;
  end

endmodule

 
module testbench;
  reg rst, clk;
  wire [2:0] q;

  up_3bit_counter upclk (.rst(rst), .clk(clk), .q(q));

  initial begin
    $monitor("rst=%b, clk=%b, q=%b", rst, clk, q);

    rst = 1'b1;
    clk = 1'b0;

    #10 rst = 1'b0;
    #10 rst = 1'b1;

    repeat (15) begin
      #5 clk = ~clk;
    end

    #10 $finish;
  end
endmodule

