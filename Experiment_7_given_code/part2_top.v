// Group 2: Raj Patel, Zachary Rouviere, Evan Waxman
// Experiement 7 Part 2
// 10/24/21

// Description:
//	

module part2_top(clk,rst);
	input clk,rst;

	wire 	[255:0] ROUTS0;
	wire 	[255:0] ROUTS1;
	wire 			roen, cnten;
	wire  	[1:0] 	counter_ctrl_state;
	wire 			muxout0, muxout1;
	wire 	[31:0] 	count0, count1;
	wire 			comp_out;
	wire 			shift_reg_en, shiftreg_out;
	wire 			ram_wren;
	
	wire 	[7:0] chall;
	assign chall = 8'h69;

	parameter ro_no = 256 ; // stage of ROs
	genvar i ;

	generate
		
			for (i=0 ; i< ro_no ; i=i+1 ) 	
			begin: ro_block		
			ro r0( .en(roen), .roout(ROUTS0 [i]) ) ;
			ro r1( .en(roen), .roout(ROUTS1 [i]) ) ;
			end
	endgenerate


	PUFmux256 mux0(ROUTS0[255:0], chall, muxout0); //chall0
	PUFmux256 mux1(ROUTS1[255:0], chall, muxout1); //chall1

	counterctrl cntctrl(clk,roen,cnten,counter_ctrl_state); 
	
	counter cnt0(clk,rst,muxout0 & cnten,count0);
	counter cnt1(clk,rst,muxout1 & cnten,count1);

	comparator comp(
		.din0(count0),
		.din1(count1),
		.dout(comp_out)
	);

	shiftreg shiftreg (
		.clk(clk),
		.in(comp_out),
		.en(shift_reg_en),
		.outs(shiftreg_out)
	);

	ro_puf_ctrl mainctrl (
		.clk(clk),
		.rst(rst),
		.counter_ctrl_state(counter_ctrl_state),
		.shift_reg_en(shift_reg_en),
		.ram_wren(ram_wren),
		.roen(roen)
	);

	ram0 ram0 (
		.address ( 5'h00 ),
		.clock ( clk ),
		.data ( shiftreg_out ),
		.wren ( ram_wren ),
		.q (  )
	);


endmodule


