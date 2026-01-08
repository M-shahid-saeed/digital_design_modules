module reg32(
input logic clk,rst,ena,
input logic [31:0]d,
output logic [31:0]q);
always_ff@(posedge clk or posedge rst) begin
if(rst)begin
q<=32'b0;
end
else if(ena)begin
q<=d;
end
end
endmodule

