module counter #(parameter N=8)(
input logic rst,
input logic clk,
input logic en,
input logic up_dn,
output logic [N-1:0] counter);
always_ff@(posedge clk or posedge rst)begin
if(rst)begin     
counter<=0;
end
else if(en)begin
counter <= (up_dn==0) ? counter+1 :counter - 1;
end
end
endmodule

