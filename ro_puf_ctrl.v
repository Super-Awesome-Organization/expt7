`timescale 1ns/1ns

module  ro_puf_ctrl (
	input			clk,
	input 			rst,
	input 	[1:0]	counter_ctrl_state,
	output			roen
);

parameter 	STATE0  = 2'b10, 
			STATE1	= 2'b01, 
			STATE2 	= 2'b11;

reg		[1:0]	state, next_state;
reg				roen_next;
reg		[6:0]	signature_bit_count;
reg				signature_bit_count_en;

always @(posedge clk) begin
	if(rst) begin
		roen <= #1 1'b0;
		signature_bit_count <= #1 7'h00;
		state <= #1 STATE0;
	end else begin
		roen <= #1 roen_next;
		if (signature_bit_count_en == 1'b1) begin
			signature_bit_count <= #1 signature_bit_count + 1'b1;
		end
		state <= #1 next_state;
	end
end


always @(*) begin
	roen_next = roen;
	signature_bit_count_en = 1'b0;
	next_state = state;

	case (state)
		STATE0: begin
			roen_next = 1'b0;

			if (&signature_bit_count == 1'b1) begin
				next_state = STATE2;
			end else begin
				next_state = STATE1;
			end
		end

		STATE1: begin
			roen_next = 1'b1;

			if (counter_ctrl_state == 2'b11) begin
				signature_bit_count_en = 1'b1;
				next_state = STATE0;
			end
		end

		STATE2: begin
			roen_next = 1'b0;
		end

		default: begin
			roen_next = 1'b0;
			signature_bit_count_en = 1'b0;
			next_state = STATE0;
		end
	endcase
end

endmodule