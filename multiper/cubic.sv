module cubic(
input logic x,
input logic y,
input logic a,
input logic cin,
output logic cout,
output logic s);
logic w1;
and a1(w1,x,y);
 full_adder f1(
 .a(a),
 .b(w1),
 .cin(cin),
 .s(s),
.cout(cout));
endmodule