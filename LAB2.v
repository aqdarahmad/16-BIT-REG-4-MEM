module Bit16_4Reg (
    input  logic clk,
    input  logic reset,  
    input  logic sel,
    input  logic wr,
    input  logic [1:0] addr,  
    input  logic [15:0] wdata, 
    output logic [15:0] rdata
);

   
    logic [15:0] mem[3:0];

    always_ff @(posedge clk) begin
        if (reset) begin
        
            mem[0] <= 16'b0;
            mem[1] <= 16'b0;
            mem[2] <= 16'b0;
            mem[3] <= 16'b0;
            rdata <= 16'b0;
        end else begin
            if (sel && wr) begin
             
                mem[addr] <= wdata;
            end
            if (sel && !wr) begin
            
                rdata <= mem[addr];
            end
        end
    end

endmodule
