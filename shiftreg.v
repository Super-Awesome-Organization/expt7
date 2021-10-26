module shiftreg (clk,rst,in,en,outs);

    input clk,rst,in,en;
    output reg [127:0] outs;

    always @(posedge clk) begin
        if (rst) begin
            outs <= 127'd0;
        end else begin
            if (en == 1'b1) begin
                outs <= {outs[126:0], in};
            end else begin
                outs <= outs;
            end
        end
    end
endmodule