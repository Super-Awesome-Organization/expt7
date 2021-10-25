// Group 2: Raj Patel, Zachary Rouviere, Evan Waxman
// Experiement 7 Part 4
// 10/24/21

// Description:
//	 part4_wrapper.v is a wrapper for the RO TRNG. The wrapper entianates RO blocks
//		XorTree, Register, Address counter, and a 100,000 bit RAM.
// 	Change ro_no for the number of RO blocks to be generated.

module part4_wrapper(clk,rst); 
	input clk,rst;

	wire [ro_no-1:0] ROUTS0;
	//wire [255:0] ROUTS1;
	wire xorout,xoroutreg;
	wire [16:0] ram_addr;
	wire en;

	reg ROEN0, ROEN1, cnten;

	parameter ro_no = 10 ; // stage of ROs change 10 20 30
	genvar i ;


	generate
		
			for (i=0 ; i< ro_no ; i=i+1 ) 	
			begin: ro_block		
			ro r0( .en(1'b1), .roout(ROUTS0 [i]) ) ;
			//ro r1( .en(ROEN1), .roout(ROUTS1 [i]) ) ;
			end
	endgenerate


	XORtree xort(ROUTS0[ro_no-1:0], xorout); // XOR Tree

	regs reg0(clk,rst,xorout,xoroutreg);	// Register

	addcnt ac0(clk,rst,ram_addr,en);		// Address counter for RAM

	ram1 ram_inst (							// RAM address 17 bit wide with data size of 1
		.address(ram_addr),
		.clock(clk),
		.data(xoroutreg),
		.wren(en),	
		.q()
	);
	

endmodule


