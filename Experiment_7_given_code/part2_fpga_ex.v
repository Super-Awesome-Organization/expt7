// Group 2: Raj Patel, Zachary Rouviere, Evan Waxman
// Experiement 7 Part 2
// 10/24/21

// Description:
//	

module part2_wrapper(clk,rst) 
	input clk,rst;

	wire [255:0] ROUTS0;
	wire [255:0] ROUTS1;
	reg ROEN0, ROEN1, cnten;

	parameter ro_no = 256 ; // stage of ROs
	genvar i ;

	generate
		
			for (i=0 ; i< ro_no ; i=i+1 ) 	
			begin: ro_block		
			ro r0( .en(cnten), .roout(ROUTS0 [i]) ) ;
			ro r1( .en(cnten), .roout(ROUTS1 [i]) ) ;
			end
	endgenerate


	PUFmux256 mux0(ROUTS0[255:0], chall0, muxout0); //chall0
	PUFmux256 mux1(ROUTS1[255:0], chall1, muxout1); //chall1

	counterctrl cntctrl(clk,roen,cnten); 
	
	counter cnt0(clk,rst,muxout0,count);
	counter cnt1(clk,rst,muxout1,count);

endmodule


