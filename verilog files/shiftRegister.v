module shiftRegister #(parameter size=24,parameter bitsShift=8)
(
	input clk,rst,load,
	input [bitsShift-1:0] data,
	output reg [size-1:0] q
);

wire [size-1:0] q_shift;

assign q_shift[bitsShift-1:0]=data;

genvar i;
generate
	for(i=1;i<size/bitsShift;i=i+1) begin: loop
		assign q_shift[(i+1)*bitsShift-1:i*bitsShift]=q[i*bitsShift-1:(i-1)*bitsShift];
	end
endgenerate

always @(posedge clk or posedge rst)
begin
	if(rst)
		q<=0;
	else if(load)
		q<=q_shift;
end

endmodule 