module n_bit_adder #(parameter N = 16) (
    input  logic [N-1:0] A,
    input  logic [N-1:0] B,
    output logic [N-1:0] Sum
);
    logic [N:0] carry;
    assign carry[0] = 1'b0;

    genvar i;
    generate
        for (i = 0; i < N; i++) begin : adder_loop
            full_adder fa_inst (
                .a(A[i]),
                .b(B[i]),
                .cin(carry[i]),
                .s(Sum[i]),
                .cout(carry[i+1])
            );
        end
    endgenerate
endmodule