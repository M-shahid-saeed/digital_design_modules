`ifndef TRANSACTION_SV
`define TRANSACTION_SV

class transaction;
  rand bit din;
  rand bit shift_en;
  rand bit dir;
  bit rst_n;         // Scoreboard ko iski zaroorat hai
  bit [7:0] q;

  function void display(string name);
    $display("[%s] dir=%b, en=%b, din=%b, rst_n=%b, q=%b", name, dir, shift_en, din, rst_n, q);
  endfunction
endclass


`endif  
