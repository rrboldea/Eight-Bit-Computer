module decimalDisplay
  (
    input twoComplement,
    input [7:0] x,
    output sign,
    output [6:0] dec2,dec1,dec0 
  );
  
  wire [7:0] abs;
  wire [3:0] bcd2,bcd1,bcd0;
  wire ripple;
  
  assign sign=~(twoComplement & x[7]);
  
  absoluteValue absVal
  (
    .enableSign(twoComplement),
    .x(x),
    .abs(abs)
  );
  
  
  doubleDabble dd
  (
    .a(abs),
    .bcd2(bcd2),
    .bcd1(bcd1),
    .bcd0(bcd0)
  );
  
  segment7DecimalDecoder d2
  (
    .c(bcd2),
    .A(dec2[0]),
    .B(dec2[1]),
    .C(dec2[2]),
    .D(dec2[3]),
    .E(dec2[4]),
    .F(dec2[5]),
    .G(dec2[6]),
    .rippleOff_in(1'b1),
    .rippleOff_out(ripple)
  );
  
  segment7DecimalDecoder d1
  (
    .c(bcd1),
    .A(dec1[0]),
    .B(dec1[1]),
    .C(dec1[2]),
    .D(dec1[3]),
    .E(dec1[4]),
    .F(dec1[5]),
    .G(dec1[6]),
    .rippleOff_in(ripple),
    .rippleOff_out()
  );
  
  segment7DecimalDecoder d0
  (
    .c(bcd0),
    .A(dec0[0]),
    .B(dec0[1]),
    .C(dec0[2]),
    .D(dec0[3]),
    .E(dec0[4]),
    .F(dec0[5]),
    .G(dec0[6]),
    .rippleOff_in(1'b0),
    .rippleOff_out()
  );
  

endmodule
  