`include "transaction.sv"

class counter_scoreboard #(parameter N = 8);
  mailbox mon2scb;
  transaction #(N) tr;
  bit [N-1:0] expected = 0;

  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
  endfunction

  task run();
    forever begin
      mon2scb.get(tr);
      if(tr.en) begin
        if(tr.up_dn)
          expected--;
        else
          expected++;
      end

      if(tr.counter == expected) 
        $display("[SCB] PASS | Expected: %0d, Actual: %0d", expected, tr.counter);
      else
        $display("[SCB] FAIL | Expected: %0d, Actual: %0d", expected, tr.counter);
    end 
  endtask
endclass