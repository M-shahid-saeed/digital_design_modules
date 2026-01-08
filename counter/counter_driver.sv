`include "transaction.sv"

class counter_driver #(parameter N = 8); 
  transaction #(N) tr;
  mailbox mbx;
  virtual counter_intf #(N) vif;

  function new(mailbox mbx, virtual counter_intf #(N) vif);
    this.mbx = mbx;
    this.vif = vif;
  endfunction

  task run();
    vif.rst <= 1;
    vif.en  <= 0;
    repeat(2) @(posedge vif.clk);
    vif.rst <= 0;

    forever begin
      mbx.get(tr);
      @(posedge vif.clk);
      vif.en <= tr.en;
      vif.up_dn <= tr.up_dn;
      $display("[DRV] Time:%0t | en:%b | up_dn:%b", $time, tr.en, tr.up_dn);
    end
  endtask
endclass