`timescale 1ns / 1ps

module debouncer(
    input sw_i,
    input rst_i,
    input clk_i,
    output reg sw_o
    );
    
    parameter N = 5000000;
    integer counter = 0;
    integer state = 0;
    reg temp = 0;
    
    initial begin
        sw_o <= 1'b0;
    end
    
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            counter <= 0;
            temp <= 0;
        end else begin
            case(state)
                0: begin
                    sw_o <= 1'b0;
                    if(sw_i == 1) begin
                        state <= 1;
                    end
                end
                1: begin
                    if (counter == N) begin
                        state <= 2;
                        counter <= 0;
                    end else begin
                        counter <= counter + 1;    
                    end;
                end
                2: begin                    
                    if(sw_i == 0) begin
                        state <= 0;
                    end else begin
                        sw_o <= 1'b1;
                    end
                end            
            endcase
        end
    end
endmodule
