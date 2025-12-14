module clock #(parameter size=3)
(
	input clk_in,rst,hlt,
	output clk_out,clk_b_out
);

wire enable;
assign enable=~hlt;

wire [size-1:0] count;

counter #(.size(size)) divider
(
	.clk(clk_in),
	.rst(rst),
	.countEnable(enable),
	.jump(1'b0),
	.d({size{1'b0}}),
	.q(count)
);

assign clk_out=count[size-1];
assign clk_b_out=~count[size-1];

endmodule