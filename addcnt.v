// Group 2: Raj Patel, Zachary Rouviere, Evan Waxman
// Experiement 7 Part 4
// 10/24/21

// Description:
//	 addcnt.v controls the address counter for the RAM module
// Counter will count up to 100,000 because each data space in the RAM
// is 1 bit and 100,000 signautre is needed

module addcnt (clk,rst,counter,en);

    input clk,rst;
    output reg [16:0] counter;
	 output reg	en;

     //reg [16:0] counter;
     //initial counter = 17'b0;

    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
		  
            counter <= 17'b0 ; // counter 0 rst
				en <= 1'b0; // enable 0 on rst
				
        end else if (clk == 1'b1) begin
		  
            counter <= counter + 1; //increment counter
				
				if(counter > 100000) begin // if counter is 100,000 then disable enable
				
					en <= 1'b0;
				end else begin
					en <= 1'b1;
					
				end
        end
    end
    
    //always assign out = counter;

endmodule
