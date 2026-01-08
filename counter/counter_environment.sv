`include "transaction.sv"
`include "generator.sv"
`include "counter_driver.sv"
`include "counter_monitor.sv"
`include "counter_scoreboard.sv"

class counter_environment #(parameter N = 8);
  generator #(N) gen;
  counter_driver #(N) drv;
  counter_scoreboard #(N) scb;
  counter_monitor #(N) mon;
  
  mailbox mbx;
  mailbox mon2scb;
  event gen_done;
  virtual counter_intf #(N) vif;

  function new(virtual counter_intf #(N) vif);
    this.vif = vif;
    mbx = new();
    mon2scb = new();
    gen = new(mbx, gen_done);
    drv = new(mbx, vif);
    mon = new(vif, mon2scb);
    scb = new(mon2scb);
  endfunction

  task run();
    fork
      gen.run();
      drv.run();
      mon.run();
      scb.run();
    join_any
    
    // Generator khatam hone ke baad thora wait taake monitor aakhri packet capture karle
    wait(gen_done.triggered);
    #100;
    $finish;
  endtask
endclass