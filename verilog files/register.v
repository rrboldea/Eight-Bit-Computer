module register #(parameter size=8)
(
	input clk,rst,load,
	input [size-1:0] d,
	output reg [size-1:0] q
);

always @(posedge clk or posedge rst)
begin
	if(rst)
		q<={size{1'b0}};
	else if(load)
		q<=d;
end

endmodule