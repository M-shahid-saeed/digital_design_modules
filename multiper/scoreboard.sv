`include "transaction.sv"

class scoreboard #(parameter N = 8);
  mailbox mon2scb;
  transaction #(N) tr;

  bit [(2*N)-1:0] result_q[$]; 
  bit [(2*N)-1:0] expected_val;

  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
  endfunction

  task run();
    forever begin
      mon2scb.get(tr);
     
      if (tr.Reset) begin
        result_q.delete();
        $display("[SCB] Reset Detected. Queue Cleared.");
      end 
      
      else if (tr.EA && tr.EB) begin
        result_q.push_back(tr.Data_in_A * tr.Data_in_B);
      end

      if (result_q.size() > 1) begin 
          expected_val = result_q.pop_front();
          
          if (tr.P_out === expected_val)
            $display("[SCB] PASS! A:%0d * B:%0d | RTL:%0d | Exp:%0d", 
                      tr.Data_in_A, tr.Data_in_B, tr.P_out, expected_val);
          else
            $error("[SCB] FAIL! A:%0d * B:%0d | RTL:%0d | Exp:%0d", 
                      tr.Data_in_A, tr.Data_in_B, tr.P_out, expected_val);
      end
    end
  endtask
endclass