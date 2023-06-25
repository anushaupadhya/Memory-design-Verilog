module pattern_det(clk,rst,d_i,valid_i,pattern);
parameter s_RESET = 3'b000;
parameter s_B = 3'b001;
parameter s_BB = 3'b010;
parameter s_BBC = 3'b011;
parameter s_BBCB = 3'b100;
parameter s_BBCBC = 3'b101;
parameter B= 1'b0;
parameter C= 1'b1;

input clk,rst,d_i,valid_i;
output reg pattern;

reg [2:0] state,next_state;
always@(posedge clk)begin
    if(rst==1) begin
pattern=0;
state=s_RESET;
next_state = s_RESET;

end
else begin 
pattern = 0;
if (valid_i==1) begin
case (state)
s_RESET :begin
if (d_i==B) next_state = s_B;
else
next_state= s_RESET;
end

s_B : begin 
if (d_i == B) next_state = s_BB;
else
next_state= s_RESET;
end

s_BB : begin 
if (d_i == B) next_state = s_BB;
else
next_state= s_BBC;
end

s_BBC : begin 
if (d_i == B) next_state = s_BBCB;
else
next_state= s_RESET;
end

s_BBCB : begin 
if (d_i == B) next_state = s_BB;
else
next_state= s_BBCBC;
end

s_BBCBC : begin 
pattern =1;
if (d_i == B) next_state = s_B;
else
next_state= s_RESET;
end

default : begin 
$display(" error condition");
next_state= s_RESET;
end
endcase
end
end
end
always@(next_state) state = next_state;
endmodule
