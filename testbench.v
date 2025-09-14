`timescale 1ns/1ps

module testbench;

  logic clk;
  logic reset;  
  logic sel;
  logic wr;
  logic [1:0] addr;  
  logic [15:0] wdata; 
  logic [15:0] rdata;

  // DUT instantiation
  Bit16_4Reg DUT (
    .clk(clk),
    .reset(reset),
    .sel(sel),
    .wr(wr),
    .addr(addr),
    .wdata(wdata),
    .rdata(rdata)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Stimulus
  initial begin
    reset = 1;
    sel   = 0;
    wr    = 0;
    wdata = 0;
    addr  = 0;

    #10 reset = 0;

    // Write to 4 locations
    @(posedge clk); sel = 1; wr = 1; addr = 2'b00; wdata = 16'hABCD;
    @(posedge clk); sel = 1; wr = 1; addr = 2'b01; wdata = 16'h1234;
    @(posedge clk); sel = 1; wr = 1; addr = 2'b10; wdata = 16'hDEAD;
    @(posedge clk); sel = 1; wr = 1; addr = 2'b11; wdata = 16'hBEEF;

    // Read back
    @(posedge clk); wr = 0; addr = 2'b00;
    @(posedge clk); wr = 0; addr = 2'b01;
    @(posedge clk); wr = 0; addr = 2'b10;
    @(posedge clk); wr = 0; addr = 2'b11;

    #20 $finish;
  end

  // Monitor
  always @(posedge clk) begin
    $display("T=%0t | sel=%b wr=%b addr=%0d wdata=%h rdata=%h",
             $time, sel, wr, addr, wdata, rdata);
  end

endmodule
