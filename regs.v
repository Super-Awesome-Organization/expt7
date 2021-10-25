// Group 2: Raj Patel, Zachary Rouviere, Evan Waxman
// Experiement 7 Part 4
// 10/24/21

// Description:
//	 Regs.v creates a 1 bit register

module regs (clk,rst,in,out);

    input clk,rst,in;
    output reg out;

    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1) begin			
            out <= 1'b0; // output 0 on rst
        end else if (clk == 1'b1) begin
            out <= in; // input = output
        end
    end
    
endmodule
