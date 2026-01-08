
module multiplier_core #(parameter N=8)(
    input  logic [N-1:0] A,
    input  logic [N-1:0] B,
    output logic [2*N-1:0] P
);
   
    logic [N-1:0][N-1:0] s_net;
    logic [N-1:0][N-1:0] c_net;

    genvar r, c, i, j; 

    generate
        
        for (r = 0; r < N; r = r + 1) begin : row_loop
            for (c = 0; c < N; c = c + 1) begin : col_loop
                
                wire a_in_wire; 
                wire cin_in_wire;

        
                assign a_in_wire = (r == 0) ? 1'b0 : 
                                   (c == N-1) ? c_net[r-1][c] : 
                                   s_net[r-1][c+1];

             
                assign cin_in_wire = (c == 0) ? 1'b0 : c_net[r][c-1];

            
                cubic cell_inst (
                    .x   (A[c]), 
                    .y   (B[r]), 
                    .a   (a_in_wire),
                    .cin (cin_in_wire),
                    .cout(c_net[r][c]),
                    .s   (s_net[r][c])
                );
            end
        end

   
        for (i = 0; i < N; i = i + 1) begin : p_side_bits
            assign P[i] = s_net[i][0];
        end
        
        for (j = 1; j < N; j = j + 1) begin : p_bottom_bits
            assign P[N+j-1] = s_net[N-1][j];
        end
        
        assign P[2*N-1] = c_net[N-1][N-1];

    endgenerate
endmodule