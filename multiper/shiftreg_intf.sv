interface shiftreg_intf #(parameter N=8) (input logic clk);
  logic [N-1:0] Data_in_A;
  logic [N-1:0] Data_in_B;
  logic Reset;      
  logic EA, EB;     
  logic [(2*N)-1:0] P_out; 


property p_mult_check;
@(posedge clk)
disable iff(Reset)
(EA && EB) |=> ##1 (P_out == ($past(Data_in_A, 2) * $past(Data_in_B, 2)));
endproperty
assert_mult: assert property(p_mult_check) 
else $error("Multiplication Result Ghalat Ha!");

endinterface