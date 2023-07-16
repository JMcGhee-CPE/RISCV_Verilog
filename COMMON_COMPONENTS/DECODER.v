module DECODER #(parameter N = 5) (
    input [N-1:0] A,
    input OE,
    output reg [2**N - 1:0] C 
);

    always @(A, OE) begin
        C = 0;
        if(OE)
            C[A] = 1'b1;
    end

endmodule