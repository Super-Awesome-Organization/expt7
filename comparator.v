`timescale 1ns/1ns

module  comparator #(parameter	BUS_WIDTH = 256) (
	input 	[BUS_WIDTH-1:0]	din0,
	input 	[BUS_WIDTH-1:0]	din1,
	output					dout
);	

always @(*)
	if din0 > din1 begin
		dout = 1'b0;
	end else begin
		dout = 1'b1;
	end
end


endmodule