// Group 2: Raj Patel, Zachary Rouviere, Evan Waxman
// Experiement 7 Part 1
// 9/24/21

// Description:
//	This module implements combinational logic to compare adc
//	data with temperature lookup table and outputs it to the led
//	bus going to the board's led array 
`timescale 1ns/1ns

module  store_sram_puf (
	input			rst,
	input	[7:0]	uprocessor_din,
	input			uprocessor_clk
);


reg	[5:0] 	ram_addr;

ram	ram_inst (
	.address(ram_addr),
	.clock(uprocessor_clk),
	.data(uprocessor_din),
	.wren(uprocessor_clk),
	.q()
);


always @(posedge unprocessr_clk) begin : proc_
	ram_addr <= #1 ram_addr + 1;
end

endmodule