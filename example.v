
//WITHOUT ENUM
module example (input logic clk , input logic reset ,  input logic sel ,  input logic wr
);

logic state[1:0];
parameter  IDLE = 2'b00 ;
parameter WRITE = 2'b01;
parameter READ = 2'b10;
    
    always_ff @(posedge clk ) begin

        if(reset)
        state <=IDLE;
        else if (sel && wr) begin
            state <= IDLE;
            
        end
        else if (sel & !wr) begin
            state <= READ;
        end    
    end
endmodule
//WITH NUM 

module example (input logic clk , input logic reset ,  input logic sel ,  input logic wr
);
typedef enum logic [1:0]{IDLE , READ , WRITE  } state_t;

state_t state;


//logic state[1:0];
//parameter  IDLE = 2'b00 ;
//parameter WRITE = 2'b01;
//parameter READ = 2'b10;
    
    always_ff @(posedge clk ) begin

        if(reset)
        state <=IDLE;
        else if (sel && wr) begin
            state <= IDLE;
            
        end
        else if (sel & !wr) begin
            state <= READ;
        end    
    end
endmodule


