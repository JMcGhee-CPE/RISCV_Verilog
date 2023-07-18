`timescale 1ns/1ps
`include "COMMON_COMPONENTS/FIFO.v"

module fifo_tb();

// FIFO Parameters
parameter N = 8;  
parameter LENGTH = 4;
parameter NEAR_FULL = 1; 
parameter NEAR_EMPTY = 0;
parameter COUNT = 1;
parameter EMPTY = 1;
parameter FULL = 1;
parameter ERROR = 1; 

// Inputs
reg [N-1:0] A; 
reg WE;
reg REQ;
reg RST;
reg CLK;

// Outputs 
wire [(NEAR_FULL + NEAR_EMPTY + EMPTY + FULL + ERROR + ($clog2(LENGTH) * COUNT)) -1 : 0] status;
wire [N-1:0] C;

// UUT
FIFO #(
  .N(N),
  .LENGTH(LENGTH), 
  .NEAR_FULL(NEAR_FULL),
  .NEAR_EMPTY(NEAR_EMPTY),
  .COUNT(COUNT),
  .EMPTY(EMPTY), 
  .FULL(FULL),
  .ERROR(ERROR)  
) fifo (
  .A(A),
  .WE(WE), 
  .REQ(REQ),
  .RST(RST),
  .CLK(CLK),
  .status(status),
  .C(C)
);

// Clock generation
always #5 CLK = ~CLK;  

initial begin
  
  // Initialize
  CLK = 0;
  RST = 1;
   
  // Apply Reset
  #10 RST = 0; $display("Reset applied");
  
  // Write 2 entries
  A = 8'hAA; WE = 1; 
  #10;
  $display("Wrote AA");
  
  A = 8'hBB; WE = 1;
  #10;
  $display("Wrote BB");

  // Read 1 entry
  REQ = 1;
  #10 REQ = 0;  
  $display("Read BB");
  
  // Try to write when full
  A = 8'hCC; WE = 1; 
  #10;
  $display("Tried to write CC when full");

  // Try to read when empty
  REQ = 1;
  #10 REQ = 0;
  $display("Tried to read when empty");

  // Done  
  #100 $finish;
  
end
  
endmodule