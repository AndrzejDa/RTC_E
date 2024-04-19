`timescale 1ns / 1ps

module Prescaler(
    input button_test_i,
    input clk_i,
    input rst_i,
    output reg pres_o
);
    parameter N = 100000000;
    integer counter = 0;
    integer seconds = 0;
    reg temp = 0;
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            counter <= 0;
            temp <= 0;
        end else if (clk_i) begin
            if (counter == N/(2*(999*button_test_i)+1)) begin
                temp <= ~temp;
                counter <= 1;                             
            end else begin
                counter = counter + 1;    
            end
        end
    end
    
    always @* begin
        pres_o = temp;
    end
    
endmodule
