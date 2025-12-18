module segment7DecimalDecoder
  (
    input rippleOff_in,
    input [3:0] c,
    output A,B,C,D,E,F,G,
    output rippleOff_out
  );
  
  wire not3,not2,not1,not0;
  wire min0,min1,min2,min3,min4,min5,min6;
  wire [6:0] aux;
  wire offCondition,H;
  
  assign not3=~c[3];
  assign not2=~c[2];
  assign not1=~c[1];
  assign not0=~c[0];
  
  assign min0=not3 & not2;
  assign min1=min0 & not1;
  assign min2=c[0] & min1;
  assign min3=c[2] & not1 & not0;
  xor xor1(min4,c[1],c[0]);
  assign min5=not2 & c[1] & not0;
  assign min6=c[2] & c[1] & c[0];
  
  
  assign aux[0]=min2 | min3;
  assign aux[1]=c[2] & min4;
  assign aux[2]=min5;
  assign aux[3]=min2 | (c[2] & ~min4);
  assign aux[4]=min3 | c[0];
  assign aux[5]=(c[1] & c[0]) | (min0 & c[0]) | min5;
  assign aux[6]=min1 | min6;
  
  assign offCondition= ~aux[0] & ~aux[1] & ~aux[2] & ~aux[3] & ~aux[4] & ~aux[5] & aux[6] & rippleOff_in;

mux_sel1b #(.size(8)) mux
(
	.sel(offCondition),
	.value1(8'b11111111),
	.value0({1'b0,aux}),
	.o({H,G,F,E,D,C,B,A})
);
  
  assign rippleOff_out=offCondition;
  
  
endmodule