module countertrl(clk,roen,counteren);
input clk,roen;
output counteren;


reg [1:0] state;
reg  counteren;
reg [31:0] cout;

always@(state)
  case (state)
  2'b00: counteren=1'b0;
  2'b01: counteren=1'b0;
  2'b10: counteren=1'b1;
  2'b11: counteren=1'b0;  
  default: counteren=1'b0; 
  endcase

always @(posedge clk)
 case(state)
  2'b00: begin cout<=32'd0; if(roen==0) state<=2'b00; else state<=2'b01; end
  2'b01: begin if(cout==32'd2000000000) state<=2'b10; else cout<=cout+1'b1; end
  2'b10: begin if(cout==32'd2000500000) state<=2'b11; else cout<=cout+1'b1; end  
  2'b11: begin if(roen==0) state<=2'b00; end    
  default: begin state<=2'b00; cout<=32'd0; end
  endcase
  
endmodule	