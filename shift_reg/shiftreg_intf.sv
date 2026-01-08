interface shiftreg_intf#(parameter N=8) (input logic clk);
logic rst_n;
logic shift_en;
logic dir;
logic din;
logic [N-1:0]q;

property valid_in1;
@(posedge clk)
disable iff(!rst_n)
(shift_en && dir == 1'b1) |=> (q == $past({q[N-2:0], din}));
  endproperty

 property valid_in0;
@(posedge clk)
disable iff(!rst_n)
(shift_en && dir == 1'b0) |=> (q == $past({din, q[N-1:1]}));
  endproperty 
  
assert property(valid_in1)
else $error("ghalat ha 1");

assert property(valid_in0) 
else $error("ghalat ha 0");  
  
 endinterface
 