module ALU #(parameter N = 32) (
    input [N-1:0] A,
    input [N-1:0] B,
    input [4:0] OP,
    output [N-1:0] C,
    output zero,
    output negative
);

    localparam ALU_ADD  = 4'b0000;
    localparam ALU_SUB  = 4'b0001;
    localparam ALU_AND  = 4'b0010;
    localparam ALU_OR   = 4'b0011;
    localparam ALU_XOR  = 4'b0100;
    localparam ALU_SLL  = 4'b0101;
    localparam ALU_SRL  = 4'b0110;
    localparam ALU_SRA  = 4'b0111;
    localparam ALU_SLT  = 4'b1000;

    reg signed [N-1:0] result;

    assign zero = result == 0;
    assign negative = result < 0;
    assign C = result;

    case (OP)
        ALU_ADD: begin
            result <= A + B;
            end
        
        ALU_SUB: begin
            result <= A - B;
            end
        
        ALU_AND: begin
            result <= A & B;
            end
        
        ALU_OR: begin
            result <= A | B;
            end
        
        ALU_XOR: begin
            result <= A ^ B;
            end
        
        ALU_SLL: begin
            result <= A << B;
            end
        
        ALU_SRL: begin
            result <= A >> B;
            end

        ALU_SRA: begin
            result <= A >>> B;
            end

        ALU_SLT: begin
            result <= A < B;
        end

    endcase

endmodule