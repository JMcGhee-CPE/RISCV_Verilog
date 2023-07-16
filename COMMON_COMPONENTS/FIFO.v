module FIFO #(

    parameter N = 32, 
    parameter LENGTH = 5, 
    parameter NEAR_FULL = 1,
    parameter NEAR_EMPTY = 0,
    parameter COUNT = 0,
    parameter EMPTY = 0,
    parameter FULL = 1,
    parameter ERROR = 1
    
    ) (
    input [N-1:0] A,
    input WE,
    input REQ,
    input RST,
    input CLK,
    output [(NEAR_FULL + NEAR_EMPTY + EMPTY + FULL + ERROR + ($clog2(LENGTH) * COUNT)) -1 : 0] status,
    output reg [N-1:0] C
);

    localparam NEAR_FULL_IDX = NEAR_FULL ? NEAR_FULL + NEAR_EMPTY + EMPTY + FULL + ERROR + ($clog2(LENGTH) * COUNT) -1 : -1;
    localparam NEAR_EMPTY_IDX = NEAR_EMPTY ? NEAR_EMPTY + EMPTY + FULL + ERROR + ($clog2(LENGTH) * COUNT) -1 : -1;
    localparam COUNT_IDX = COUNT ? ($clog2(LENGTH) * COUNT) -1 : -1;
    localparam EMPTY_IDX = EMPTY ? EMPTY + FULL + ERROR + ($clog2(LENGTH) * COUNT) -1 : -1;
    localparam FULL_IDX = FULL ? FULL + ERROR + ($clog2(LENGTH) * COUNT) -1 : -1;
    localparam ERROR_IDX = FULL ? ERROR + ($clog2(LENGTH) * COUNT) -1 : -1;

    reg [$clog2(LENGTH)-1 : 0] head_idx;
    reg [$clog2(LENGTH)-1 : 0] tail_idx;

    reg [N-1:0] data [LENGTH-1:0];


    integer i;

    generate
        if(ERROR) begin
            // If the clock is enabled and we tried to write when it is full, or read when it is empty
            assign status[ERROR_IDX] = CLK && ((WE && (head_idx == tail_idx)) || (REQ && (head_idx == (tail_idx + 1))));
        end
        if(NEAR_FULL) begin
            assign status[NEAR_FULL_IDX] = (head_idx + 1) == tail_idx;
        end
        if(NEAR_EMPTY) begin
            assign status[NEAR_EMPTY_IDX] = head_idx == (tail_idx + 2);
        end
        if(FULL) begin
            assign status[FULL_IDX] = head_idx == tail_idx;
        end
        if(EMPTY) begin
            assign status[EMPTY_IDX] = head_idx == (tail_idx + 1);
        end
        if(COUNT) begin
            assign status[COUNT_IDX:0] = head_idx > tail_idx ? head_idx - tail_idx : (head_idx + 9) - tail_idx;
        end

    endgenerate

    always@(posedge CLK or posedge RST) begin

        if(RST) begin
            // Unfortunately we can't write to the tail by doing this, but it simplifies logic.
            head_idx <= 1;
            tail_idx <= 0;
            for(i = 0; i < LENGTH; i = i + 1) begin
                data[i] <= 0;
            end
        end

        if(WE) begin
            // If not FULL
            if(head_idx != tail_idx) begin
                data[head_idx] <= A;
                head_idx <= head_idx == (LENGTH - 1) ? 0 : head_idx + 1;

            end
        end
        if(REQ) begin
            // If not EMPTY
            if(head_idx != (tail_idx + 1)) begin
                tail_idx <= tail_idx + 1;
                tail_idx <= tail_idx == (LENGTH - 1) ? 0 : head_idx + 1;
                C <= data[tail_idx];
            end
        end
    end

endmodule