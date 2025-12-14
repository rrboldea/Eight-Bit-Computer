module adder #(parameter size=8)
(
	input subtract,
	input [size-1:0] x,y,
	output cout,
	output [size-1:0] z
);

wire [size-1:0] add_subtract;
wire [size:0] carry;

assign carry[0]=subtract;
assign cout=carry[size];

genvar i;
generate
	for(i=0;i<size;i=i+1) begin: loop1
		assign add_subtract[i]= y[i] ^ subtract;
	end

	for(i=0;i<size;i=i+1) begin: loop2
		FAC faci
		(
			.x(x[i]),
			.y(add_subtract[i]),
			.cin(carry[i]),
			.z(z[i]),
			.cout(carry[i+1])
		);
	end
endgenerate

endmodule