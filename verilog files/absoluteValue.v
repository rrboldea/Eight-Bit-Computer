module absoluteValue
  (
    input enableSign,
    input [7:0] x,
    output [7:0] abs
  );
  
  wire [7:0] aux,twoComplement;
  
mux_sel1b #(.size(8)) mux1
(
	.sel(x[7]),
	.value1(twoComplement),
	.value0(x),
	.o(aux)
);

adder #(.size(8)) add
(
	.subtract(1'b0),
	.x(~x),
	.y(8'b00000001),
	.cout(),
	.z(twoComplement)
);

mux_sel1b #(.size(8)) mux2
(
	.sel(enableSign),
	.value1(aux),
	.value0(x),
	.o(abs)
);  
  
endmodule