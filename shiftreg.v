module shiftreg (clk,in,en,outs);

    input clk,in,en;
    output [127:0] outs;

    reg [127:0] tempreg;
    initial tempreg = 128'b0;
    wire [127:0] tempwire;

    always @(posedge clk) begin
        if (en == 1'b1) begin

            tempreg <= tempreg << 1;
            tempreg[0]	<= in;		

        end else begin
            tempreg<=tempreg;
        end
    end

    assign tempwire = tempreg;
    assign outs = tempwire;
endmodule