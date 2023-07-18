module REGISTER #(parameter N = 32) (
    input [N-1:0] A,
    input RST,
    input CLK,
    output reg [N-1:0] O 
);

    always @(posedge RST or posedge CLK ) begin
        if(RST)
            O <= 0;
        else
            O <= A;
    end

endmodule