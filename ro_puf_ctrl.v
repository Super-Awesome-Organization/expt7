`timescale 1ns/1ns

module  ro_puf_ctrl (
	input				clk,
	input 				rst,
	input 		[1:0]	counter_ctrl_state,
	output	reg			shift_reg_en,
	output 	reg 		ram_wren,
	output 	reg			roen,
	output 	reg [7:0] 	challenge
);

parameter 	STATE0  = 2'b00, 
			STATE1	= 2'b01, 
			STATE2 	= 2'b10;

reg		[1:0]	state, next_state;
reg				roen_next;
reg 			shift_reg_en_next;
reg 			ram_wren_next;
reg 			challenge_en;


always @(posedge clk) begin
	if(rst) begin
		roen <= #1 1'b0;
		ram_wren <= #1 1'b0;
		shift_reg_en <= #1 1'b0;
		challenge <= #1 8'h00;

		state <= #1 STATE0;
	end else begin
		roen <= #1 roen_next;
		ram_wren <= #1 ram_wren_next;
		shift_reg_en <= #1 shift_reg_en_next;

		// challenge counter
		if (challenge_en == 1'b1) begin
			challenge <= #1 challenge + 1;
		end

		state <= #1 next_state;
	end
end


always @(*) begin
	roen_next = roen;
	ram_wren_next = ram_wren;
	shift_reg_en_next = shift_reg_en;
	challenge_en = 1'b0;
	next_state = state;

	case (state)
		// initial state: disable ro enable, shift reg en, and ram wr en
		STATE0: begin
			roen_next = 1'b0;
			ram_wren_next = 1'b0;
			shift_reg_en_next = 1'b0;

			if (challenge == 8'd128) begin	// write signature to sram
				ram_wren_next = 1'b1;
				next_state = STATE2;
			end else if (counter_ctrl_state == 2'b00) begin 						// get next signature bit from new ro pair
				next_state = STATE1;
			end
		end

		// enable ro pair state: enable ro enable until counter controller reaches final state
		STATE1: begin
			roen_next = 1'b1;
			ram_wren_next = 1'b0;

			if (counter_ctrl_state == 2'b11) begin 	// shift new signature bit into shift reg, increment challenge counter
				shift_reg_en_next = 1'b1;
				challenge_en = 1'b1;
				next_state = STATE0;
			end
		end

		// done state, 127 bit signature acquired, ro's disabled until power/rst cycle
		STATE2: begin
			roen_next = 1'b0;
			ram_wren_next = 1'b0;
			shift_reg_en_next = 1'b0;
		end

		// default state: default all comb. signals to 0
		default: begin
			roen_next = 1'b0;
			ram_wren_next = 1'b0;
			shift_reg_en_next = 1'b0;
			challenge_en = 1'b0;
			next_state = STATE0;
		end
	endcase
end

endmodule