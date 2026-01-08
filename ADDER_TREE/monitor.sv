`include "transaction.sv"


class monitor #(parameter N = 8);
  
  
  virtual multiplier_intf #(N) vif;
  mailbox mon2scb;
  
  
  transaction #(N) tr;

  function new(virtual multiplier_intf #(N) vif, mailbox mon2scb);
    this.vif = vif;
    this.mon2scb = mon2scb;
  endfunction

  task run();
    forever begin
      @(posedge vif.clk);
      
      tr = new();
      tr.Data_in_A = vif.Data_in_A;
      tr.Data_in_B = vif.Data_in_B;
      tr.EA        = vif.EA;
      tr.EB        = vif.EB;
      tr.Reset     = vif.Reset;
      tr.P_out     = vif.P_out; 
      mon2scb.put(tr);
      tr.display("MONITOR");
    end
  endtask
endclass