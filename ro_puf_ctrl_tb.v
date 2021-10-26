// Group 2: Raj Patel, Zachary Rouviere, Evan Waxman
// Experiement 4 Part 3
// 9/17/21

// Description:
//	trojan_seq_tb.v is a testbench to test functionality of trojan_seq.v
`timescale 1ns/1ns

module ro_puf_ctrl_tb ();

	reg 			clk = 1;
	reg 			rst;
	wire	[1:0]	counter_ctrl_state;
	wire			shift_reg_en;
	wire			ram_wren;
	wire			roen;
	wire	[7:0]	challenge_cnt;
	wire 			counteren;
	wire 			muxout0;
	wire 			muxout1;
	wire 			count0;
	wire 			count1;
	wire 	[7:0]	challenge;
	wire 			comp_out;
	wire 			counterrst;


	parameter ro_no = 256 ; // number of RO pairs for signature generation
	

	PUFmux256 U_MUX0(, challenge, muxout0);
	PUFmux256 U_MUX1(, challenge, muxout1);
	
	ro_puf_ctrl U_MAIN_CTRL (
		.clk(clk),
		.rst(rst),
		.counter_ctrl_state(counter_ctrl_state),
		.shift_reg_en(shift_reg_en),
		.ram_wren(ram_wren),
		.roen(roen),
		.challenge(challenge)
	);

	counterctrl U_COUNT_CTRL (
		.clk(clk),
		.roen(roen),
		.counteren(counteren),
		.counterrst(counterrst),
		.counter_ctrl_state(counter_ctrl_state)
	);


	counter U_COUNT0 (
		.clk(muxout0),
		.reset(counterrst),
		.ena(counteren),
		.count(count0)
	);

	counter U_COUNT1 (
		.clk(muxout1),
		.reset(counterrst),
		.ena(counteren),
		.count(count1)
	);

	comparator U_COMP(
		.din0(count0),
		.din1(count1),
		.dout(comp_out)
	);

	`define DELAY(TIME_CLK) #(10*TIME_CLK); //delays one clk cycle, TIME_CLK = number of clk cycles to delay

	reg simState = 0;
	always begin 
		if (simState != 1) begin
			`DELAY(1/2)
			clk = ~clk;
		end
	end


	initial begin
		$display($time, "- Starting Sim");
		rst = 1'b1;
		`DELAY(10)

		rst = 1'b0;
		`DELAY(10000)

		$stop;
	end

endmodule