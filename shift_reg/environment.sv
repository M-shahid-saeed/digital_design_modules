
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;
  generator  gen;
  driver     driv;
  monitor    mon;
  scoreboard scb;
  
  mailbox gen2driv;
  mailbox mon2scb;
  event next;
  
  virtual shiftreg_intf vif;
  
  function new(virtual shiftreg_intf vif);
    this.vif = vif;
    gen2driv = new();
    mon2scb  = new();
    
    gen  = new(gen2driv, next);
    driv = new(gen2driv, vif);
    mon  = new(vif, mon2scb);
    scb  = new(mon2scb);
  endfunction
  
 task run();
  fork
    gen.run(); 
    driv.run(); 
    mon.run();  
    scb.run();  
  join_any
  
  #100; // Thora sa intizar taake aakhri bit shift ho jaye
  $finish; 
endtask
endclass 