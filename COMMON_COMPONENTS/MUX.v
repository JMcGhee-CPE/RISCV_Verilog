// Multiplexor
// Parameter definitions
//  - N = bit width, default is 32
//  - X = # of inputs, default is 2
//  - Z = # of outputs, default is 1
// With the default parameters, a 32 bit 2t1 mux will be instantiated.
module MUX #(parameter N = 32, parameter X = 2, parameter Z = 1) (
    input [X-1:0][N-1:0] A,
    input [Z-1:0][$clog2(N)-1:0] SEL,
    output [Z-1:0][N-1:0] C 
);

    genvar i;

    generate
        for( i = 0; i < Z; i = i + 1) begin
            assign C[i] = A[SEL[i]];
        end
    endgenerate

endmodule