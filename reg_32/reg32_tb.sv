module reg32_tb();

logic  clk;
logic   rst;
logic [31:0]d;
logic    ena;
 logic [31:0]q;
 initial begin
 clk = 0;
 forever  #5 clk= ~clk;
 end
 reg32 dut (
.clk(clk),
.rst(rst),
.ena(ena),
 .d(d),
.q(q));
 
property p_res32;
@(posedge clk)
rst |=> (q==0);
endproperty
assert property(p_res32)
else $fatal("your registerfilr is corrupted");

property a_res32;
@(posedge clk)
disable iff (rst)
ena |=> (q==$past(d));
endproperty
assert property(a_res32)
else $fatal("your registerfilr is corrupted");

property b_res32;
@(posedge clk)
!ena |=> $stable(q);
endproperty
assert property(b_res32)
else $fatal("your registerfilr is corrupted");


task automatic run_time(
input logic  r,
 input logic  [31:0]i,
input logic  l);
rst=r;
d=i;
ena=l;

@(posedge clk);
endtask
initial begin
rst=0;
ena=0;
d=32'b0;
$display("-----starting test------");
#10
run_time(1'b1,32'hABCDABCD,1'b0);
run_time(1'b0,32'hABCDABCD,1'b1);
run_time(1'b1,32'hABCDABCD,1'b0);

run_time(1'b0,32'hABCDABCD,1'b0);
$display("-----end  test------");
end

endmodule