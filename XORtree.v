// Group 2: Raj Patel, Zachary Rouviere, Evan Waxman
// Experiement 7 Part 4
// 10/24/21

// Description:
//	 XORtree.v is an XOR module that will XOR all of the inputs
// and returns a 1 bit value


module XORtree (in, out);
    
    input [9:0] in;
    output out;

    assign out = ^in; // bit-wise xor reduction

endmodule