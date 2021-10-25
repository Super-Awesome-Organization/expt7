`timescale 1ns/1ns

module  comparator #(parameter	BUS_WIDTH = 256) (
	input 	[BUS_WIDTH-1:0]	din0,
	input 	[BUS_WIDTH-1:0]	din1,
	output	reg				dout
);	

always @(*) begin
	if (din0 < din1) begin
		dout = 1'b1;
	end else begin
		dout = 1'b0;
	end
end


endmodule