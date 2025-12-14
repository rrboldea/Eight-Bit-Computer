module conditional_mux #(parameter conditions=1,parameter size=1)
(
	input [conditions-1:0] cond,
	input [size*(conditions+1)-1:0] then,
	output [size-1:0] o
);

wire [size*conditions-1:0] aux;

mux_sel1b #(.size(size)) mux_0
(
	.sel(cond[0]),
	.value1(then[size*2-1:size]),
	.value0(then[size-1:0]),
	.o(aux[size-1:0])
);

genvar i;
generate
	for(i=1;i<conditions;i=i+1) begin: loop
		mux_sel1b #(.size(size)) mux_i
		(
			.sel(cond[i]),
			.value1(then[size*(i+2)-1:size*(i+1)]),
			.value0(aux[size*i-1:size*(i-1)]),
			.o(aux[size*(i+1)-1:size*i])
		);
	end		
endgenerate

assign o=aux[size*conditions-1:size*(conditions-1)];

endmodule