`include "transaction.sv"

class counter_monitor #(parameter N = 8);
  virtual counter_intf #(N) vif;
  mailbox mon2scb;
  transaction #(N) tr;

  function new(virtual counter_intf #(N) vif, mailbox mon2scb);
    this.vif = vif;
    this.mon2scb = mon2scb;
  endfunction

  task run();
    forever begin
      @(posedge vif.clk);
      #1;
      tr = new();
      tr.en = vif.en;
      tr.up_dn = vif.up_dn;
      tr.counter = vif.counter;
      mon2scb.put(tr);
    end
  endtask
endclass