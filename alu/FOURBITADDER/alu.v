/*
module testbench;
 reg [3:0] A,B;
 reg [2:0] C;
 wire [3:0] F;

ALU al1(A,B,C,F);

initial 
    begin 
	A=4'b0110;
    B=4'b0010;
	C = 3'b000;

 #1 $display("A = %b -->  A's 2S Complement =%b \n",A,F);
 C=3'b001;
 #1 $display("B = %b -->  B's 2S Complement =%b \n",B,F);
 C=3'b010;
 #1 $display("A = %d , B =%d -->  A+B =%d \n",A,B,F);
C=3'b011;
  #1 $display("A = %d , B =%d -->  A-B =%d \n",A,B,F);
	C=3'b100;
	 #1 $display("A = %b , B =%b -->  A & B =%b \n",A,B,F);
	C=3'b101;
	 #1 $display("A = %b , B =%b -->  A | B =%b \n",A,B,F);
	 C=3'b110;
	 #1 $display("A = %d , B =%d -->  A * B =%d \n",A,B,F);
	 C =3'b111;
	#1 $display("A = %b , B =%b -->  A xor B =%b \n",A,B,F);
	
end
endmodule
*/

module alu(A,B,C,F);

input [3:0] A,B;
input [2:0] C;
output [3:0] F;
wire C1OUT;
 
 //0 2s complement of A
  //1 2s complement of B
  //2 A+B 
  //3 A-B
//4 A & B
  //5 A | B
  //6 A*B
 //7
wire [3:0] a2s;
wire [3:0] b2s;
wire[3:0] aPb;
wire[3:0] aMb;
wire[3:0] aAb;
wire[3:0] aOb;
wire[3:0] temp;
wire [3:0] amultb;
wire C2OUT;
wire C3OUT;
wire B1OUT;
wire C4OUT ;
wire [3:0] notA;
wire [3:0]notB;
wire [3:0] bitxor;


invertor invA(A,notA);
invertor invB(B,notB);


// 2S Complement A ;
ripplecadder rca1(notA,1'b1,1'b0,a2s,C1OUT);

// 2s Complement B;
ripplecadder rca2(notB,1'b1,1'b0,b2s,C2OUT);


// A+B 
ripplecadder rca3(A,B,1'b0,aPb,C3OUT);



// A-B
 ripplecadder rca4(~B,1'b1,1'b0,temp,C4OUT);
 ripplecadder rca5(A,temp,1'b0,aMb,B1OUT);


// A and B;
//assign aAb = A & B;
bitwiseand bitwAND(A,B,aAb);

// A or B
//assign aOb= A|B;
bitwiseor bitwsOR(A,B,aOb);

// A*B

multiplier m(A,B,amultb);

// bitwise xor on A ,B;
bitwisexor xr(A,B,bitxor);

mux8to1 mux0(a2s[0],b2s[0],aPb[0],aMb[0],aAb[0],aOb[0],amultb[0],bitxor[0],C,F[0]);
mux8to1 mux1(a2s[1],b2s[1],aPb[1],aMb[1],aAb[1],aOb[1],amultb[1],bitxor[1],C,F[1]);
mux8to1 mux2(a2s[2],b2s[2],aPb[2],aMb[2],aAb[2],aOb[2],amultb[2],bitxor[2],C,F[2]);
mux8to1 mux3(a2s[3],b2s[3],aPb[3],aMb[3],aAb[3],aOb[3],amultb[3],bitxor[3],C,F[3]);













endmodule










module halfadder(a,b,s,cout);


input a,b;
output  s,cout;

xor(s,a,b);
and(cout,a,b);


endmodule



module fulladder(a,b,cin,s,cout) ;

input  a,b ;
input cin;
output   s;
output cout;
wire c1,c2,s1;

halfadder ha1(a,b,s1,c1);
halfadder ha2(s1,cin,s,c2);
or(cout,c1,c2);


endmodule


module mux8to1(i0,i1,i2,i3,i4,i5,i6,i7,a,out);

input [2:0] a;

input i0,i1,i2,i3,i4,i5,i6,i7; 
output out;

wire w0,w1,w2,w3,w4,w5,w6,w7;

wire c0 ,c0n,c1,c1n,c2,c2n;

 assign c0=a[0];
 assign c1=a[1];
 assign c2=a[2];
not(c0n,c0);
not(c1n,c1);
not(c2n,c2);

and(w0,i0,c0n,c1n,c2n);
and(w1,i1,c0,c1n,c2n);
and(w2,i2,c0n,c1,c2n);
and(w3,i3,c0,c1,c2n);
and(w4,i4,c0n,c1n,c2);
and(w5,i5,c0,c1n,c2);
and(w6,i6,c0n,c1,c2);
and(w7,i7,c0,c1,c2);

or(out,w0,w1,w2,w3,w4,w5,w6,w7);

endmodule




module ripplecadder(a,b,cin,s,cout);

input [3:0] a,b;
input cin;
output  [3:0] s;
output  cout;
wire c1;
wire c2;
wire c3;


fulladder fa0(a[0],b[0],cin,s[0],c1);
fulladder fa1(a[1],b[1],c1,s[1],c2);
fulladder fa2(a[2],b[2],c2,s[2],c3);
fulladder fa3(a[3],b[3],c3,s[3],cout);




endmodule

module and4input(a,b,out);
input a;
input [3:0] b;
output [3:0] out;

and(out[0],a,b[0]);
and(out[1],a,b[1]);
and(out[2],a,b[2]);
and(out[3],a,b[3]);

endmodule


module and3input(a,b,out);
input a;
input [3:0] b;
output [2:0] out;

and(out[0],a,b[1]);
and(out[1],a,b[2]);
and(out[2],a,b[3]);


endmodule


module multiplier(a,b,out);

input [3:0] a,b;
output [3:0] out;



and(out[0],a[0],b[0]);
wire [3:0] a1,a2,a3,rcaout1,rcaout2;
wire [3:0] a0;
assign a0[3]=0;
wire fa11cout,fa12cout,fa13cout,s10,s11,s12,rca1out,fa21cout,fa22cout,fa23cout,s20,s21,s22,rca2out;
wire fa31cout;
and3input p(a[0],b,a0[2:0]);
and4input q(a[1],b,a1);
and4input r(a[2],b,a2);
and4input s(a[3],b,a3);        
                                           
 fulladder fa10(a0[0],a1[0],1'b0,out[1],fa11cout);
 fulladder fa11(a0[1],a1[1],fa11cout,s10,fa12cout);
 fulladder fa12(a0[2],a1[2],fa12cout,s11,fa13cout);
 fulladder fa13(a0[3],a1[3],fa13cout,s12,rca1out);
 
 
 fulladder fa20(a2[0],s10,1'b0,out[2],fa21cout);
 fulladder fa21(a2[1],s11,fa21cout,s20,fa22cout);
 fulladder fa22(a2[2],s12,fa22cout,s21,fa23cout);
 fulladder fa23(a2[3],rca21cout,fa23cout,s22,rca2out);

 fulladder fa30(a3[0],s20,1'b0,out[3],fa31cout);


endmodule



module bitwiseand(a,b,out);

input [3:0] a,b;
output[3:0] out;

and(out[0],a[0],b[0]);
and(out[1],a[1],b[1]);
and(out[2],a[2],b[2]);
and(out[3],a[3],b[3]);

endmodule


module bitwiseor(a,b,out);

input [3:0] a,b;
output[3:0] out;

or(out[0],a[0],b[0]);
or(out[1],a[1],b[1]);
or(out[2],a[2],b[2]);
or(out[3],a[3],b[3]);

endmodule


module invertor(a,out);

input [3:0] a;
output[3:0] out;

not(out[0],a[0]);
not(out[1],a[1]);
not(out[2],a[2]);
not(out[3],a[3]);


endmodule 

module bitwisexor(a,b,out);

input  [3:0] a,b;
output [3:0] out;

xor(out[0],a[0],b[0]);
xor(out[1],a[1],b[1]);
xor(out[2],a[2],b[2]);
xor(out[3],a[3],b[3]);

endmodule