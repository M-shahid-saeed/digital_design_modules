`include "counter_environment.sv"

module tb_top;
  parameter N = 16; 

  bit clk = 0;
  always #5 clk = ~clk;

  // Interface
  counter_intf #(N) vif(clk);

  // DUT
  counter #(.N(N)) dut (
    .clk(vif.clk),
    .rst(vif.rst),
    .en(vif.en),
    .up_dn(vif.up_dn),
    .counter(vif.counter)
  );

  // Environment handle
  counter_environment #(N) env;

  initial begin
    env = new(vif);
    env.run();
  end

  // Cleanup display
  initial begin
    // Generator ka wait environment ke andar ho raha hai,
    // lekin yahan safety ke liye rakha hai.
    wait(env.gen_done.triggered);
    #1000;
    $display("=== DONE BY SHAHID KING ===");
  end

endmodule