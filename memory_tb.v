module tb;
       //1kb memory with 16 bit width
          //width=16, depth=1024/16 = 64,addr_width=6
parameter WIDTH=16;
parameter DEPTH=16;
parameter ADDR_WIDTH=4;
reg clk_i,rst_i;
reg [ADDR_WIDTH-1:0] addr_i;
reg [WIDTH-1:0] wdata_i;
wire [WIDTH-1:0] rdata_o;
reg wr_rd_i;
reg valid_i;
wire ready_o;
integer i;

memory #(.DEPTH(16), .ADDR_WIDTH(4), .WIDTH(16)) dut(clk_i, rst_i, addr_i, wdata_i, rdata_o, wr_rd_i, valid_i, ready_o);

always #5 clk_i = ~clk_i;

initial begin
	clk_i = 0;
	rst_i = 1;
	#20;
	rst_i = 0;
	//now apply stimulus
	//wirte to all locations
       write_memory();
       read_memory();
       #100;
      $finish;
      end

	task write_memory();
	begin  
		for (i = 0; i < DEPTH; i = i+1) begin 
		@(posedge clk_i); //at the positive edge of the clock 
		//memory is a sychronous design,all operations should be done at the positive edge of the clock
		addr_i = i;
		wdata_i = $random;
		wr_rd_i = 1;
		valid_i = 1;
		wait (ready_o == 1);end
		@(posedge clk_i);
		valid_i = 0;
		addr_i = 0;
		wdata_i = 0;
		wr_rd_i = 0;
	end
endtask

	task read_memory();
	begin  
		for (i = 0; i < DEPTH; i = i+1) begin 
		@(posedge clk_i); //at the positive edge of the clock 
		//memory is a sychronous design,all operations should be done at the positive edge of the clock
		addr_i = i;
		wr_rd_i = 0;
		valid_i = 1;
		wait (ready_o == 1);end
		@(posedge clk_i);
		valid_i = 0;
		addr_i = 0;
		wdata_i = 0;
		wr_rd_i = 0;



	end
       endtask
	endmodule
