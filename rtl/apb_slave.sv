`define DATA_WIDTH 32
`define ADDR_WIDTH 32
`define DEPTH 256

module apb_design_n(
input pclk,
input prst,
input psel,
input pen,
input pwrite,
input [`ADDR_WIDTH-1:0] paddr,
input [`DATA_WIDTH-1:0] pwdata,
output reg [`DATA_WIDTH-1:0] prdata,
output reg pready,

output reg pslverr
);

// Memory
reg [`DATA_WIDTH-1:0] mem [0:255];

// State encoding
localparam IDLE = 2'b00;
localparam SETUP = 2'b01;
localparam ACCESS = 2'b10;

reg [1:0] state, next_state;

// Address decode (ERROR condition)
// Valid addresses: 0x00 - 0x7F

wire addr_error;
assign addr_error = (paddr >`DEPTH);

// Sequential logic
always @(posedge pclk or posedge prst) begin
if (prst) begin
state <= IDLE;
prdata <= `DATA_WIDTH'h0;
pready <= 1'b0;
pslverr <= 1'b0;
end
else begin
state <= next_state;

// Default values
pslverr <= 1'b0;

// ACCESS phase operations
if (state == ACCESS) begin
if (addr_error) begin

// Error response
pslverr <= 1'b1;
end
else begin
// Normal read/write
if (pwrite)
mem[paddr] <= pwdata;
else
prdata <= mem[paddr];
end
end

// READY asserted only in ACCESS phase
pready <= (state == ACCESS);
end
end

// Next-state logic

always @(*) begin
case (state)
IDLE: begin
if (psel && !pen)
next_state = SETUP;
else
next_state = IDLE;
end

SETUP: begin
if (psel && pen)
next_state = ACCESS;
else if (psel && !pen)
next_state = SETUP;
else
next_state = IDLE;
end

ACCESS: begin
if (psel && pen)
next_state = ACCESS; // wait states
else if (psel && !pen)
next_state = SETUP;
else
next_state = IDLE;
end

default: next_state = IDLE;
endcase
end

endmodule
