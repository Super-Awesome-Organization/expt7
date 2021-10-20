// Group 2: Raj Patel, Zachary Rouviere, Evan Waxman
// Experiement 7 Part 2
// 10/24/21

// Description:
//	

module part2_wrapper(clk,rst) 
	input clk,rst;

	wire 	[255:0] ROUTS0;
	wire 	[255:0] ROUTS1;
	reg 			roen, cnten;
	reg  	[1:0] 	counter_ctrl_state;

	parameter ro_no = 256 ; // stage of ROs
	genvar i ;

	generate
		
			for (i=0 ; i< ro_no ; i=i+1 ) 	
			begin: ro_block		
			ro r0( .en(roen), .roout(ROUTS0 [i]) ) ;
			ro r1( .en(roen), .roout(ROUTS1 [i]) ) ;
			end
	endgenerate


	PUFmux256 mux0(ROUTS0[255:0], chall0, muxout0); //chall0
	PUFmux256 mux1(ROUTS1[255:0], chall1, muxout1); //chall1

	counterctrl cntctrl(clk,roen,cnten,counter_ctrl_state); 
	
	counter cnt0(clk,rst,muxout0 & cnten,count);
	counter cnt1(clk,rst,muxout1 & cnten,count);

	ro_puf_ctrl mainctrl (
		.clk(clk)
		.rst(rst)
		.counter_ctrl_state(counter_ctrl_state)
		.roen(roen)
	);

endmodule


