module eightbitcomp
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

	//sdram clock
	input clk,
	
	input rst_b,

	//Sdram programing inputs
	input prog,sdram_load_b,
	input [7:0] write_data,

	//Display outputs
	output sign,
	output [6:0] dec2,dec1,dec0,

	//Debugging
	input show_addr_bus,
	output [7:0] led
);

wire rst,sdram_load;
assign rst= ~rst_b;
assign sdram_load= ~sdram_load_b;

wire [7:0] data_bus,addr_bus;

//assign led=show_addr_bus?addr_bus:data_bus;
mux_sel1b #(.size(8)) MUX_SHOW_DATA_ADDR_BUS(.o(led),.sel(show_addr_bus),.value1(addr_bus),.value0(data_bus));

//Semnal de tact si semnal invers de tact pt unitatea de control
wire comp_clk,comp_clk_b;

//Semnale de comanda date de control unit
wire hlt,mi,ri,ro,ii,io,ai,ao,so,su,bi,oi,ce,co,j,fi;

//Intrari control unit
wire cf,zf;

//Conexiuni la data_bus
wire [7:0] a_register_output,alu_output;

//Conexiuni la addr_bus
wire [7:0] prog_counter_output;

//Conexiuni la data_bus( [15:8] ) si addr_bus( [7:0] )
wire [15:0] sdram_output,instr_register_output;

clock #(.size(7)) CLOCK
(
	.clk_in(clk),
	.rst(rst),
	.hlt(hlt | prog),
	.clk_out(comp_clk),
	.clk_b_out(comp_clk_b)
);

counter #(.size(8)) PROG_COUNTER
(
	.clk(comp_clk),
	.rst(rst),
	.countEnable(ce),
	.jump(j),
	.d(addr_bus),
	.q(prog_counter_output)
);

register #(.size(8)) A_REGISTER
(
	.clk(comp_clk),
	.rst(rst),
	.load(ai),
	.d(data_bus),
	.q(a_register_output)
);

wire [7:0] b_register_output;
register #(.size(8)) B_REGISTER
(
	.clk(comp_clk),
	.rst(rst),
	.load(bi),
	.d(data_bus),
	.q(b_register_output)
);

ALU #(.size(8)) ALU
(
	.clk(comp_clk),
	.rst(rst),
	.subtract(su),
	.flagEnable(fi),
	.x(a_register_output),
	.y(b_register_output),
	.carryFlag(cf),
	.zeroFlag(zf),
	.z(alu_output)
);

wire [7:0] mem_addr_register_output;
register #(.size(8)) MEM_ADDR_REGISTER
(
	.clk(comp_clk),
	.rst(rst),
	.load(mi),
	.d(addr_bus),
	.q(mem_addr_register_output)
);

wire sdram_input_write_signal,sdram_input_read_signal;
wire [7:0] sdram_input_write_address;
wire [15:0] sdram_input_write_data;
sdram_input #(.dataWriteChunk(8)) SDRAM_INPUT
(
	.clk(clk),
	.rst(rst),
	.load(sdram_load),
	.write_data(write_data),
	.write(sdram_input_write_signal),
	.read(sdram_input_read_signal),
	.sdram_write_address(sdram_input_write_address),
	.sdram_write_data(sdram_input_write_data)
);

wire sdram_write,sdram_read;
wire [7:0] sdram_write_address,sdram_read_address;
wire [15:0] sdram_data_write;

//assign sdram_write_address= prog?sdram_input_write_address:mem_addr_register_output;
mux_sel1b #(.size(8)) MUX_WRITE_ADDR(.o(sdram_write_address),.sel(prog),.value1(sdram_input_write_address),.value0(mem_addr_register_output));

//assign sdram_read_address= prog?write_data:mem_addr_register_output;
mux_sel1b #(.size(8)) MUX_READ_ADDR(.o(sdram_read_address),.sel(prog),.value1(write_data),.value0(mem_addr_register_output));

//assign sdram_data_write= prog?sdram_input_write_data:{data_bus,addr_bus};
mux_sel1b #(.size(16)) MUX_DATA_WRITE(.o(sdram_data_write),.sel(prog),.value1(sdram_input_write_data),.value0({data_bus,addr_bus}));

//assign sdram_write= prog?sdram_input_write_signal:ri;
mux_sel1b #(.size(1)) MUX_WRITE(.o(sdram_write),.sel(prog),.value1(sdram_input_write_signal),.value0(ri));

//assign sdram_read= prog?sdram_input_read_signal:ro;
mux_sel1b #(.size(1)) MUX_READ(.o(sdram_read),.sel(prog),.value1(sdram_input_read_signal),.value0(ro));

sdram SDRAM
(
	.clk(clk),	
	.address_write({14'b0,sdram_write_address}),
	.address_read({14'b0,sdram_read_address}),
	.data_write(sdram_data_write),
	.write(sdram_write),
	.read(sdram_read),
	.reset(),
	.data_out(sdram_output),

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

register #(.size(16)) INSTR_REGISTER
(
	.clk(comp_clk),
	.rst(rst),
	.load(ii),
	.d({data_bus,addr_bus}),
	.q(instr_register_output)
);

control_unit CONTROL_UNIT
(
	.clk_b(comp_clk_b),
	.rst(rst),
	.zf(zf),
	.cf(cf),
	.instruction(instr_register_output[15:8]),
	.hlt(hlt),.mi(mi),.ri(ri),.ro(ro),.ii(ii),.io(io),.ai(ai),.ao(ao),.so(so),.su(su),.bi(bi),.oi(oi),.ce(ce),.co(co),.j(j),.fi(fi)
);

wire [7:0] out_register_output;
register #(.size(8)) OUT_REGISTER
(
	.clk(comp_clk),
	.rst(rst),
	.load(oi),
	.d(data_bus),
	.q(out_register_output)
);

decimalDisplay DISPLAY
(
	.twoComplement(1'b0),
	.x(out_register_output),
	.sign(sign),
	.dec2(dec2),
	.dec1(dec1),
	.dec0(dec0)
);

//Data Bus multiplexor
/*always @(*)
begin
	if(prog)
		data_bus=sdram_output[15:8];
	else if(ro)
		data_bus=sdram_output[15:8];
	else if(io)
		data_bus=instr_register_output[15:8];
	else if(ao)
		data_bus=a_register_output;
	else if(so)
		data_bus=alu_output;
	else 
		data_bus=8'b00000000;
end
*/
conditional_mux #(.conditions(5),.size(8)) DATA_BUS_MULTIPLEXOR
(
	.cond({prog,ro,io,ao,so}),
	.then
	(
	{sdram_output[15:8],sdram_output[15:8],instr_register_output[15:8],a_register_output,alu_output,8'b00000000}
	),
	.o(data_bus)
);


//Address Bus multiplexor
/*always @(*)
begin
	if(prog)
		addr_bus=sdram_output[7:0];
	else if(ro)
		addr_bus=sdram_output[7:0];
	else if(io)
		addr_bus=instr_register_output[7:0];
	else if(co)
		addr_bus=prog_counter_output;
	else 
		addr_bus=8'b00000000;
end
*/
conditional_mux #(.conditions(4),.size(8)) ADDR_BUS_MULTIPLEXOR
(
	.cond({prog,ro,io,co}),
	.then
	(
	{sdram_output[7:0],sdram_output[7:0],instr_register_output[7:0],prog_counter_output,8'b00000000}
	),
	.o(addr_bus)
);

endmodule