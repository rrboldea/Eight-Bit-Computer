module dabble
  (
    input [3:0] c,
    output [3:0] s
  );
  
  wire [3:0] c_b;
  wire min0,min1,min2,min3;
  
  assign c_b[0]=~c[0];
  assign c_b[1]=~c[1];
  assign c_b[2]=~c[2];
  assign c_b[3]=~c[3];
  
  assign min0=c[3] & c_b[2];
  assign min1=c[2] & c[1];
  assign min2=c_b[1] & c_b[0];
  assign min3=c[3] & min2;
  
  assign s[3]=min0 | (c[2] & c[0]) | min1;
  assign s[2]=(c[2] & min2) | (min0 & c[0]);
  assign s[1]=min3 | (c_b[2] & c[1] & c_b[0]) | (c[1] & c[0]);
  assign s[0]=min3 | (c_b[3] & c_b[2] & c[0]) | (min1 & c_b[0]);
  
endmodule
  
  
  