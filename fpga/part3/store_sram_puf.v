// Group 2: Raj Patel, Zachary Rouviere, Evan Waxman
// Experiement 7 Part 1
// 10/24/21

// Description:
//	This module takes the SRAM bytes data from the microprocesser
// and stores it into a ram enity, so that the values can be seen 
// in the in system content memory editor window. A total of 64 bytes are 
// transfered to the FPGA

`timescale 1ns/1ns

module  store_sram_puf (
	input			rst,
	input	[7:0]	uprocessor_din,
	input			uprocessor_clk
);


reg	[9:0] 	ram_addr;
initial ram_addr = 10'b0000000000; // initalize ram_addr to 0
reg cnt;						// count regiester to data can be written to address 0
initial cnt = 1'b0;				// count regiester is initalized to 0 

ram1	ram_inst (
	.address(ram_addr),
	.clock(uprocessor_clk),
	.data(uprocessor_din),
	.wren(uprocessor_clk),	// data is true on every pos clock edge
	.q()
);


always @(posedge uprocessor_clk) begin
    if (cnt == 1'b0) begin			// determines if the board has just been powered up
        //ram_addr <= 6'b000000;
        cnt <= 1'b1;				// changes count reg to 1 and ram_addr is set to 0 for first clk cycle
    end else begin
        ram_addr <= #1 ram_addr + 10'b0000000001; // increments the address of the ram
    end
end

endmodule