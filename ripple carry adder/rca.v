
module stimulus;

reg [3:0] A,B;
reg cin;
wire [3:0] out;
wire cout;

ripplecadder rca(A,B,cin,out,cout);

initial begin

 A=4'b1011;
 B=4'b0001;
 cin=1'b0;

#1 $monitor("A=%d B=%d carryy in =%d--> A+B=%d carry out= %d",A,B,cin,out,cout);
#2 A=4'b1001; 
   B=4'b0011;
   cin=1'b0;
#2 A=4'b1001; 
   B=4'b0011;
   cin=1'b0;
#2 A=4'b0011; 
   B=4'b0101;
   cin=1'b1;
#2 A=4'b0111; 
   B=4'b0101;
   cin=1'b0;
#2 A=4'b0001; 
   B=4'b1110;
   cin=1'b0;
#2 A=4'b0011; 
   B=4'b0111;
   cin=1'b1;
#2 A=4'b1111; 
   B=4'b0111;
   cin=1'b1;

end

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


/* 2 A=4'b1001; 
   B=4'b0011;
   cin=1'b0;
#2 A=4'b1001; 
   B=4'b0011;
   cin=1'b0;
#2 A=4'b0011; 
   B=4'b0101;
   cin=1'b1;
#2 A=4'b0111; 
   B=4'b0101;
   cin=1'b0;
#2 A=4'b0001; 
   B=4'b1110;
   cin=1'b0;
#2 A=4'b0011; 
   B=4'b0111;
   cin=1'b1;   */