module counter(clk,reset,  ena, count);
input clk,reset, ena;
output [31:0] count;

reg [31:0] count;
//wire [31:0] count;
//assign count=roen? 32'd0: ount;

always @ (posedge clk)
  if(reset)
     count<=32'd0;
  else
     begin 
     	 if(ena==1'b1)         
         count<=count+1'b1;
     end 

endmodule




