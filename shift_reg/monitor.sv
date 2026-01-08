`include "transaction.sv"

class monitor;
virtual shiftreg_intf vif;
mailbox mon2scb;
transaction tr;
function new(virtual shiftreg_intf vif, mailbox mon2scb);
this.vif=vif;
this.mon2scb=mon2scb;
endfunction

task run();
forever begin
@(posedge vif.clk); 
#1;
    
tr=new();
tr.din=vif.din;
tr.dir=vif.dir;
tr.q=vif.q;
tr.shift_en=vif.shift_en;
tr.rst_n = vif.rst_n; // Monitor interface se reset ki state uthaye
mon2scb.put(tr);
tr.display("MONITOR");
end
endtask
endclass  
