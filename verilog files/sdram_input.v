module sdram_input #(parameter dataWriteChunk=8)
(
	input clk,load,rst,
	input [dataWriteChunk-1:0] write_data,
	output write,read,
	output [dataWriteChunk-1:0] sdram_write_address,
	output [2*dataWriteChunk-1:0] sdram_write_data
);

wire load_sync,shift_reg_clk;
synchronizer sync
(
	.clk(clk),
	.signal_in(load),
	.signal_out(load_sync)
);

pos_edge pos
(
	.clk(clk),
	.signal_in(load_sync),
	.signal_out(shift_reg_clk)
);

wire [3*dataWriteChunk-1:0] q;

assign sdram_write_address=q[3*dataWriteChunk-1:2*dataWriteChunk];
assign sdram_write_data=q[2*dataWriteChunk-1:0];

shiftRegister #(.size(3*dataWriteChunk),.bitsShift(dataWriteChunk)) shift_reg
(
	.clk(shift_reg_clk),
	.rst(rst),
	.load(1'b1),
	.data(write_data),
	.q(q)
);

wire [2:0] count;

assign write=count[1]&count[0];
assign read=(~count[1])&(~count[0]);

counter #(.size(2)) counter
(
	.clk(shift_reg_clk),
	.rst(rst),
	.countEnable(1'b1),
	.jump(write),
	.d(2'b01),
	.q(count)
);

endmodule