`include "transaction.sv"


class driver #(parameter N = 8); 
  
  
  transaction #(N) tr;
  mailbox gen2driv;
  
 
  virtual multiplier_intf #(N) vif; 

  function new(mailbox gen2driv, virtual multiplier_intf #(N) vif);
    this.gen2driv = gen2driv;
    this.vif = vif;
  endfunction

  task run();
   
    vif.Reset     <= 1'b1;
    vif.Data_in_A <= 0; 
    vif.Data_in_B <= 0;
    vif.EA        <= 1'b0;
    vif.EB        <= 1'b0;
    
    repeat(5) @(posedge vif.clk); 
    
    vif.Reset <= 1'b0; 
    $display("[DRV] Reset Released. System is now ACTIVE for N=%0d", N);

   
    forever begin
      gen2driv.get(tr); 
      
      @(posedge vif.clk); 
      
     
      vif.Data_in_A <= tr.Data_in_A;
      vif.Data_in_B <= tr.Data_in_B;
      vif.EA        <= 1'b1; 
      vif.EB        <= 1'b1;
      
      $display("[DRV] Driving: A=%0d, B=%0d | N=%0d", tr.Data_in_A, tr.Data_in_B, N);
      
      @(posedge vif.clk);
    end
  endtask
endclass