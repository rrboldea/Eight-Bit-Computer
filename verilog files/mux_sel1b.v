module mux_sel1b #(parameter size=8)
(
	input sel,
	input [size-1:0] value0,value1,
	output [size-1:0] o
);

genvar i;
generate
	for(i=0;i<size;i=i+1) begin: loop
		assign o[i]=(value0[i] & (~sel) ) | (value1[i] & sel);
	end
endgenerate

endmodule