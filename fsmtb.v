module tb;
reg clk,rst,d_i,valid_i;
wire pattern;
integer count;

pattern_det dut(clk,rst,d_i,valid_i, pattern);

always begin
#5 clk =0;
#5 clk =1;
end
initial begin
count = 0;
rst=1;
#20
rst=0;
repeat(100000) begin
@(posedge clk);
d_i= $random;
valid_i =1;

end 
@(posedge clk);
d_i = 0;
valid_i =0;
#50;
always@(posedge pattern)count = count+1;
$display ("total count = %0d", count);
$finish;
end


endmodule
