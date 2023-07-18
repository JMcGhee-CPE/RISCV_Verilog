// Cache
// Parameter definitions
//  - N = bit width, default is 32
//  - SIZE_KB = # of inputs, default is 2
//  - ASSOC = # of outputs, default is 1
//  - BLOCK_SIZE = # of bytes per block
// With the default parameters, a 32 bit 2t1 mux will be instantiated.

module Cache #(
    parameter WORD = 32,
    parameter ADDR_WIDTH = 20,
    parameter SIZE_KB = 12,
    parameter ASSOC = 4, 
    parameter BLOCK_SIZE = 4,
    parameter REPLACEMENT_POLICY = "LRU",
    parameter WRITEBACK_POLICY = "WRITE-THROUGH"
    ) 
    
    (

    input wire         clk, rst;
    input wire [ADDR_WIDTH-1:0]  i_p_addr;
    input wire [3:0]   i_p_byte_en;
    input wire [WORD-1:0]  i_p_writedata;
    input wire         i_p_read, i_p_write;
    output reg [WORD-1:0]  o_p_readdata;
    output reg         o_p_readdata_valid;
    output wire        o_p_waitrequest;

    output reg [ADDR_WIDTH-1:0]  o_m_addr;
    output wire [3:0]  o_m_byte_en;
    output reg [(WORD*BLOCK_SIZE)-1:0] o_m_writedata;
    output reg         o_m_read, o_m_write;
    input wire [(WORD*BLOCK_SIZE)-1:0] i_m_readdata;
    input wire         i_m_readdata_valid;
    input wire         i_m_waitrequest;

);

    localparam BLOCK_SZ = $clog2(BLOCK_SIZE) // # of bits needed to select a block
    localparam SET_SZ = $clog2((SIZE_KB * 1024) / ASSOC); // # of bits needed to select a set
    localparam TAG_SZ = ADDR_WIDTH - SET_SZ - BLOCK_SIZE;  // # of tag bits needed to uniquely identify an address

    reg[2:0] CACHE_STATE;

    wire [TAG_SZ-1:0] replace_tag;


    reg [TAG_SZ-1:0] TAGS [ASSOC-1:0];
    
    // TODO, make this generate if
    reg [TAG_SZ-1:0] LRU [TAG_SZ-1:0];
    reg VALID [TAG_SZ-1:0];
    reg DIRTY [TAG_SZ-1:0];

    always @(posedge clk) begin
    end

    assign replace_tag = LRU[TAG_SZ-1];

    localparam IDLE = 0;
    localparam COMP = 1;
    localparam HIT  = 2;
    localparam FETCH1 = 3;
    localparam FETCH2 = 4;
    localparam FETCH3 = 5;
    localparam WB1 = 6;
    localparam WB2 = 7;

    always @(posedge clk) begin
        if(rst) begin
           
        end
        else begin
            case (state)
                IDLE: begin
                end

                COMP: begin
                end

                HIT: begin
                end

                FETCH1: begin
                end

                FETCH2: begin
                end

                FETCH3: begin
                end

                WB1: begin
                    
                end

                WB2: begin
                    
                end
            endcase // case (state)
        end
    end
endmodule