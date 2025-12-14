module sdram_input_test
(
	//////////// SDRAM //////////
	output		    [12:0]		DRAM_ADDR,
	output		     [1:0]		DRAM_BA,
	output		          		DRAM_CAS_N,
	output		          		DRAM_CKE,
	output		          		DRAM_CLK,
	output		          		DRAM_CS_N,
	inout 		    [15:0]		DRAM_DQ,
	output		          		DRAM_LDQM,
	output		          		DRAM_RAS_N,
	output		          		DRAM_UDQM,
	output		          		DRAM_WE_N,

	input clk,button,rst_b,
	input [3:0] write_data,sdram_read_address,
	output [7:0] sdram_read_data
);

wire rst;
assign rst=~rst_b;

wire write,read;
wire [3:0] sdram_write_address;
wire [7:0] sdram_write_data;

/*wire [15:0] data_out;
assign read_data=data_out[7:0];

wire button_sync,shift_reg_clk;
synchronizer sync
(
	.clk(clk),
	.signal_in(button),
	.signal_out(button_sync)
);

pos_edge pos
(
	.clk(clk),
	.signal_in(button_sync),
	.signal_out(shift_reg_clk)
);

wire [12:0] q;

shiftRegister #(.size(12),.bitsShift(4)) shift_reg
(
	.clk(shift_reg_clk),
	.rst(rst),
	.load(1'b1),
	.data(write_data),
	.q(q)
);

wire write,read;
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
);*/


sdram_input #(.dataWriteChunk(4)) sdram_input
(
	.clk(clk),
	.load(button),
	.rst(rst),
	.write_data(write_data),
	.write(write),
	.read(read),
	.sdram_write_address(sdram_write_address),
	.sdram_write_data(sdram_write_data)
);

sdram sdram(
    .clk(clk),
    .reset(1'b0),
    .address_write( {18'b0,sdram_write_address} ),  
    .address_read( {18'b0,sdram_read_address} ),  

    .write(write),
    .data_write( {8'b0,sdram_write_data} ),
    
    .read(read),
    .data_out(sdram_read_data),
    
	//////////// SDRAM //////////
    .DRAM_ADDR(DRAM_ADDR),
    .DRAM_BA(DRAM_BA),
    .DRAM_CAS_N(DRAM_CAS_N),
    .DRAM_CKE(DRAM_CKE),
    .DRAM_CLK(DRAM_CLK),
    .DRAM_CS_N(DRAM_CS_N),
    .DRAM_DQ(DRAM_DQ),
    .DRAM_LDQM(DRAM_LDQM),
    .DRAM_RAS_N(DRAM_RAS_N),
    .DRAM_UDQM(DRAM_UDQM),
    .DRAM_WE_N(DRAM_WE_N)
);


endmodule