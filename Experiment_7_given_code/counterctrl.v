module counterctrl(clk,roen,counteren,counterrst,counter_ctrl_state);
input clk,roen;
output counteren;
output counterrst;
output [1:0] counter_ctrl_state;


reg [1:0] state;
reg counteren;
reg counterrst;
reg [31:0] cout;

assign counter_ctrl_state = state;

always @(state) begin
  case (state)
  2'b00: begin counteren=1'b0; counterrst=1'b1; end
  2'b01: begin counteren=1'b0; counterrst=1'b0; end
  2'b10: begin counteren=1'b1; counterrst=1'b0; end
  2'b11: begin counteren=1'b0; counterrst=1'b0; end
  default: begin counteren=1'b0; counterrst=1'b0; end
  endcase
end

always @(posedge clk) begin
 case(state)
  2'b00: begin cout<=32'd0; if(roen==0) begin state<=2'b00; end else state<=2'b01; end
  // 2'b01: begin if(cout==32'd20) state<=2'b10; else cout<=cout+1'b1; end
  // 2'b10: begin if(cout==32'd25) state<=2'b11; else cout<=cout+1'b1; end
  2'b01: begin if(cout==32'd2000000000) state<=2'b10; else cout<=cout+1'b1; end
  2'b10: begin if(cout==32'd2000500000) state<=2'b11; else cout<=cout+1'b1; end
  2'b11: begin if(roen==0) state<=2'b00; end    
  default: begin state<=2'b00; cout<=32'd0; end
  endcase
end
  
endmodule	