module control_unit
(
	input clk_b,rst,zf,cf,
	input [7:0] instruction,
	output reg hlt,mi,ri,ro,ii,io,ai,ao,so,su,bi,oi,ce,co,j,fi
);

/*========= INSTRUCTIONS =========*/
localparam lda_instruction=8'b00000001;
localparam add_instruction=8'b00000010;
localparam out_instruction=8'b00000011;
localparam hlt_instruction=8'b11111111;

/*============ STATES ============*/
//fetch state
localparam fetch0=10'b0000000000;
localparam fetch1=10'b0000000001;
//lda state
localparam lda0=10'b0000000100;
localparam lda1=10'b0000000101;
//add state
localparam add0=10'b0000001000;
localparam add1=10'b0000001001;
localparam add2=10'b0000001010;
//out state
localparam out0=10'b0000001100;
//hlt state
localparam hlt0=10'b1111111100;



reg [9:0] state,next_state;

always @(*)
begin
	case(state)
		fetch0: next_state=fetch1;
		fetch1: if(instruction==lda_instruction) next_state=lda0;
			else if(instruction==add_instruction) next_state=add0;
			else if(instruction==out_instruction) next_state=out0;
			else if(instruction==hlt_instruction) next_state=hlt0;
			else next_state=fetch0;
		lda0: next_state=lda1;
		lda1: next_state=fetch0;
		add0: next_state=add1;
		add1: next_state=add2;
		add2: next_state=fetch0;
		out0: next_state=fetch0;
		hlt0: next_state=fetch0;
	endcase
end

always @(posedge clk_b or posedge rst)
begin
	if(rst)
		state<=fetch0;
	else
		state<=next_state;
end

always @(*)
begin
	case(state)
		fetch0: {hlt,mi,ri,ro,ii,io,ai,ao,so,su,bi,oi,ce,co,j,fi}=16'b0100000000000100;
		fetch1: {hlt,mi,ri,ro,ii,io,ai,ao,so,su,bi,oi,ce,co,j,fi}=16'b0001100000001000;
		lda0: {hlt,mi,ri,ro,ii,io,ai,ao,so,su,bi,oi,ce,co,j,fi}=16'b0100010000000000;
		lda1: {hlt,mi,ri,ro,ii,io,ai,ao,so,su,bi,oi,ce,co,j,fi}=16'b0001001000000000;
		add0: {hlt,mi,ri,ro,ii,io,ai,ao,so,su,bi,oi,ce,co,j,fi}=16'b0100010000000000;
		add1: {hlt,mi,ri,ro,ii,io,ai,ao,so,su,bi,oi,ce,co,j,fi}=16'b0001000000100000;
		add2: {hlt,mi,ri,ro,ii,io,ai,ao,so,su,bi,oi,ce,co,j,fi}=16'b0000001010000000;
		out0: {hlt,mi,ri,ro,ii,io,ai,ao,so,su,bi,oi,ce,co,j,fi}=16'b0000000100010000;
		hlt0: {hlt,mi,ri,ro,ii,io,ai,ao,so,su,bi,oi,ce,co,j,fi}=16'b1000000000000000;
	endcase
end

endmodule