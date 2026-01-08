`include "transaction.sv"

class scoreboard;
  mailbox mon2scb;
  transaction tr;

  bit [7:0] expected = 0;

  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
  endfunction

  task run();
    forever begin
      mon2scb.get(tr);
      
      // Comparison logic
      if (tr.q === expected) begin
        $display("[SCB] PASS! RTL_q: %b | Exp_q: %b", tr.q, expected);
      end else begin
        $error("[SCB] FAIL! RTL_q: %b | Exp_q: %b", tr.q, expected);
      end

      // Logic Update (Reference Model)
      if (!tr.rst_n) begin
        expected = 0;
      end 
      else if (tr.shift_en) begin // Yahan 'begin' hona chahiye
        if (tr.dir) begin
          expected = {expected[6:0], tr.din};
        end 
        else begin
          expected = {tr.din, expected[7:1]};
        end 
      end // shift_en ka end
    end // forever ka end
  endtask // task ka end
endclass // class ka end