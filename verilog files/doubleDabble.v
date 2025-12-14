module doubleDabble
  (
    input [7:0] a,
    output [3:0] bcd2,bcd1,bcd0
  );
  
  wire [3:0] b,c,d,e,f,g,h;
  
  dabble d_1
  (
    .c({1'b0,a[7],a[6],a[5]}),
    .s(b)
  );
  
  
  dabble d_2
  (
    .c({b[2],b[1],b[0],a[4]}),
    .s(c)
  );
  
  
  dabble d_3
  (
    .c({c[2],c[1],c[0],a[3]}),
    .s(d)
  );
  
  
  dabble d1_4
  (
    .c({1'b0,b[3],c[3],d[3]}),
    .s(e)
  );
  dabble d0_4
  (
    .c({d[2],d[1],d[0],a[2]}),
    .s(f)
  );
  
  
  dabble d1_5
  (
    .c({e[2],e[1],e[0],f[3]}),
    .s(g)
  );
  dabble d0_5
  (
    .c({f[2],f[1],f[0],a[1]}),
    .s(h)
  );
  
  
  assign bcd2[3]=1'b0;
  assign bcd2[2]=1'b0;
  assign bcd2[1]=e[3];
  assign bcd2[0]=g[3];
  
  assign bcd1[3]=g[2];
  assign bcd1[2]=g[1];
  assign bcd1[1]=g[0];
  assign bcd1[0]=h[3];
  
  assign bcd0[3]=h[2];
  assign bcd0[2]=h[1];
  assign bcd0[1]=h[0];
  assign bcd0[0]=a[0];
  
endmodule
    
  
  
  
  