`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"


class environment #(parameter N = 8);
  
  
  generator  #(N) gen;
  driver     #(N) driv;
  monitor    #(N) mon;
  scoreboard #(N) scb;
  
  mailbox gen2driv;
  mailbox mon2scb;
  event gen_done; 
  

  virtual multiplier_intf #(N) vif;
  
  function new(virtual multiplier_intf #(N) vif);
    this.vif = vif;
    gen2driv = new();
    mon2scb  = new();
    
   
    gen  = new(gen2driv, gen_done); 
    driv = new(gen2driv, vif);
    mon  = new(vif, mon2scb);
    scb  = new(mon2scb);
  endfunction
  
  task run();
    $display("[ENV] Simulation Started with N=%0d at %0t", N, $time);
    fork
      gen.run();  
      driv.run(); 
      mon.run();  
      scb.run();  
    join_any 
    

    repeat(10) @(posedge vif.clk); 
    
    $display("[ENV] Simulation Finished at %0t", $time);
    $finish; 
  endtask
endclass