`include "transaction.sv"

class generator #(parameter N = 8); 
  transaction #(N) tr;
  mailbox mbx;
  event done;

  function new(mailbox mbx, event done);
    this.mbx = mbx;
    this.done = done;
  endfunction

  task run();
    for(int i=0; i<257; i++) begin
      tr = new();
      tr.en    = $urandom_range(0, 1); 
      tr.up_dn = $urandom_range(0, 1); 
      mbx.put(tr);
      $display("[GEN] Packet %0d: en=%b, up_dn=%b", i, tr.en, tr.up_dn);
    end
    ->done;
    $display("[GEN] Done.");
  endtask 
endclass