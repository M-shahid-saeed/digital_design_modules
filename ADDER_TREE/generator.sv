`include "transaction.sv"
class generator #(parameter N = 8);
transaction #(N) tr;
mailbox gen2driv;
event done;
function new(mailbox gen2driv, event done);
this.gen2driv = gen2driv;
this.done = done;
 endfunction
task run();
for(int i=0; i<255; i++) begin
tr = new();
tr.Data_in_A = $urandom_range(0, (2**(N-1)) - 1); 
tr.Data_in_B = $urandom_range(0, (2**(N-1)) - 1); 
gen2driv.put(tr);
$display("[GENERATOR] Packet %0d sent: A=%0d, B=%0d | (N=%0d)", 
i, tr.Data_in_A, tr.Data_in_B, N);
end
->done;
$display("Sab bhej diya Shahid King! Total 255 packets sent.");
 endtask 
endclass