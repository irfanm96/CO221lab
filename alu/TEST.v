module shift(A,OUT);

input [3:0] A;
output [3:0] OUT;

wire shift;
wire shiftn;
assign shift=1'b1;
not(shiftn,shift);

wire a1,a2,a3,a4,a5,a6,a7,a8;


and(a1,shiftn,A[3]);
and(a2,shift,A[2]);

and(a3,shiftn,A[2]);
and(a4,shift,A[1]);

and(a5,shiftn,A[1]);
and(a6,shift,A[0]);

and(a7,shiftn,A[0]);
and(a8,1'b0,shift);

or(OUT[3],a1,a2);
or(OUT[2],a3,a4);
or(OUT[1],a5,a6);
or(OUT[0],a7,a8);

endmodule