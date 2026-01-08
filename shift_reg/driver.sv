`include "transaction.sv"

class driver; 
  transaction tr;
  mailbox gen2driv;
  virtual shiftreg_intf vif;

  // Simple Constructor (Next hata diya)
  function new(mailbox gen2driv, virtual shiftreg_intf vif);
    this.gen2driv = gen2driv;
    this.vif = vif;
  endfunction

  task run();
    // --- RESET LOGIC ---
    // Start mein reset ko pakka '0' (active) rakhein
    vif.rst_n <= 1'b0; 
    vif.shift_en <= 0;
    vif.din <= 0;
    
    repeat(5) @(posedge vif.clk); // 5 clocks tak reset rakhein taake system settle ho jaye
    
    vif.rst_n <= 1'b1; // Reset RELEASE (Ab 'q' change hoga)
    $display("[DRV] Reset Released at %0t. System is now ACTIVE.", $time);

    // --- DRIVING LOGIC ---
    forever begin
      gen2driv.get(tr);
      @(posedge vif.clk);
      
      vif.shift_en <= tr.shift_en;
      vif.dir      <= tr.dir;
      vif.din      <= tr.din;
      
      // Driver bus data bhejta rahega bina kisi event ke intizar ke
      @(posedge vif.clk);
    end
  endtask
endclass