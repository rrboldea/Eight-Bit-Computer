module ALU #(parameter size)
(
	input clk,rst,subtract,flagEnable,
	input [size-1:0] x,y,
	output carryFlag,zeroFlag,
	output [size-1:0] z
);

wire cout,zero;

assign zero=(z==0);

adder #(.size(size)) adder
(
	.subtract(subtract),
	.x(x),
	.y(y),
	.cout(cout),
	.z(z)
);

register #(.size(2)) flagReg
(
	.clk(clk),
	.rst(rst),
	.load(flagEnable),
	.d({cout,zero}),
	.q({carryFlag,zeroFlag})
);

endmodule