`ifndef TRANSACTION_SV
`define TRANSACTION_SV

class transaction #(parameter N = 8);
    
   
    rand bit [N-1:0] Data_in_A;
    rand bit [N-1:0] Data_in_B;
    
    bit EA = 1'b1; 
    bit EB = 1'b1;
    bit Reset;              
    
    bit [2*N-1:0] P_out;  

    function void display(string name);
      
        $display("[%s] Reset=%b, EA=%b, EB=%b, A=%0d, B=%0d | Product=%0d", 
                  name, Reset, EA, EB, Data_in_A, Data_in_B, P_out);
    endfunction

    
endclass

`endif