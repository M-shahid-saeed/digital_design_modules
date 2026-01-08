`include "environment.sv"

module tb_top;
    
    parameter N = 8; 

    bit clk;
    always #5 clk = ~clk;


    multiplier_intf #(N) vif(clk);

   
    adder_tree_multiplier #(N) dut (
        .clk(vif.clk),
        .Reset(vif.Reset),
        .Data_in_A(vif.Data_in_A),
        .Data_in_B(vif.Data_in_B),
        .EA(vif.EA),
        .EB(vif.EB),
        .P_out(vif.P_out)
    );

    environment #(N) env;

    initial begin
       
        env = new(vif);
        env.run();
    end

    initial begin
        $dumpfile("dump.vcd");
      
        $dumpvars(0, tb_top);
    end
endmodule