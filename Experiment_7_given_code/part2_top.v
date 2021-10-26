// Group 2: Raj Patel, Zachary Rouviere, Evan Waxman
// Experiement 7 Part 2
// 10/24/21

// Description:
//	This top level entity generates a conventional RO-PUF based on Figure 2 of the Experiment 7
//	documentation. A pair of 128 RO-PUFs are generated and connected to two 128-1 muxes, where
//	the mux select for each mux is controlled by the 7 bit challenge bus as it increments from
//	0 to 127. During each challenge, the toggle rate of each RO is counted for a set interval defined
//	by the counterctrl module and then those count values are compared by the comparator module.
//	A 0 or 1 bit value is outputted by the comparator depending on which RO is faster. This bit
//	is then shifted into a shift register and the process repeats until 128 bits are gathered,
//	creating a 128-bit signature unique to the board.

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
	wire 	[7:0]	challenge;
	wire 			counterrst;

	parameter ro_no = 256 ; // number of RO pairs for signature generation
	
	genvar i ;
	generate
		for (i=0 ; i< ro_no ; i=i+1 ) 	
		begin: ro_block		
			ro r0( .en(1'b1), .roout(ROUTS0[i]) ) ;
			ro r1( .en(1'b1), .roout(ROUTS1[i]) ) ;
		end
	endgenerate

	PUFmux256 mux0(ROUTS0[ro_no-1:0], challenge, muxout0);
	PUFmux256 mux1(ROUTS1[ro_no-1:0], challenge, muxout1);

	counterctrl cntctrl(clk,roen,cnten,counterrst,counter_ctrl_state); 
	
	counter cnt0(muxout0,counterrst,cnten,count0);
	counter cnt1(muxout1,counterrst,cnten,count1);


	comparator comp(
		.din0(count0),
		.din1(count1),
		.dout(comp_out)
	);

	shiftreg shiftreg (
		.clk(clk),
		.rst(rst),
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
		.roen(roen),
		.challenge(challenge)
	);

	ram ram (
		.address ( 5'h00 ),
		.clock ( clk ),
		.data ( shiftreg_out ),
		.wren ( ram_wren ),
		.q (  )
	);


endmodule


