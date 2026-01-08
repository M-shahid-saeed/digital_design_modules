`include "transaction.sv"
class generator;
transaction tr;
mailbox gen2driv;
event done;
function new(mailbox gen2driv,event done);
this.gen2driv=gen2driv;
this.done=done;
endfunction
task run();
    for(int i=0; i<127; i++) begin
      tr = new();
		tr.din    = $urandom_range(0, 64); 
      tr.shift_en = $urandom_range(0, 1); 
		tr.dir=$urandom_range(0, 64);  
		gen2driv.put(tr);
      $display("[GENERATOR] Packet %0d sent: en=%b, dir=%b ,data=%b", i, tr.shift_en, tr.dir,tr.din);
    end
    
    ->done;
    $display("sab bhej dia shahid king");
  endtask 

endclass 