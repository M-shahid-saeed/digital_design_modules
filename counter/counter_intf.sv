interface counter_intf #(parameter N=8) (input logic clk);
  logic rst;
  logic en;
  logic up_dn;
  logic [N-1:0] counter;

  property enable_checker;
    @(posedge clk)
    disable iff(rst)
    (en && !up_dn) |=> (counter == $past(counter) + 1'b1); 
  endproperty

  ASSERT_ENABLE_CHECK: assert property(enable_checker)
  else $error("[ASSERT FAIL] Shahid King: Behavior ghalat hai!");

endinterface