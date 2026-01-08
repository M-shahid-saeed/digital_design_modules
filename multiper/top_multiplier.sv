module top_multiplier #(parameter N=8) (
    input  logic [N-1:0] Data_in_A,
    input  logic [N-1:0] Data_in_B,
    input  logic clk,
    input  logic Reset,      
    input  logic EA, EB,     
    output logic [(2*N)-1:0] P_out 
);
   
    logic [N-1:0]      reg_A, reg_B;
    logic [(2*N)-1:0]  mult_result;

  
    always_ff @(posedge clk or posedge Reset) begin
        if (Reset) begin
            reg_A <= '0; 
            reg_B <= '0;
        end 
        else begin
            if (EA) reg_A <= Data_in_A;
            if (EB) reg_B <= Data_in_B;
        end
    end

   
    multiplier_core #(.N(N)) mult_inst ( 
        .A(reg_A),
        .B(reg_B),
        .P(mult_result)
    );

   
    always_ff @(posedge clk or  posedge Reset) begin
        if (Reset)
            P_out <= '0; 
        else
            P_out <= mult_result;
    end

endmodule