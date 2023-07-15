module half_adder(
    input A,
    input B,
    input C_IN,
    output SUM,
    output CARRY
);

    wire xor_ab;

    assign xor_ab = A ^ B;

    assign SUM = xor_ab ^ C_IN;
    assign CARRY = xor_ab & (C_IN);

endmodule