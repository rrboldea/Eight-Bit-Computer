module counter #(parameter size=8)
(
	input clk,rst,countEnable,jump,
	input [size-1:0] d,
	output [size-1:0] q
);

wire [size-1:0] count_latch,next_count,count;

assign q=count;

mux_sel1b #(.size(size)) mux
(
	.sel(jump),
	.value0(next_count),
	.value1(d),
	.o(count_latch)
);

adder #(.size(size)) adder
(
	.subtract(1'b0),
	.x(count),
	.y({ {(size-1){1'b0}}, 1'b1}),
	.cout(),
	.z(next_count)
);

register #(.size(size)) register
(
	.clk(clk),
	.rst(rst),
	.load(countEnable),
	.d(count_latch),
	.q(count)
);


endmodule