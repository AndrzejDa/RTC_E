`timescale 1ns / 1ps

module Clock(
    input clk_i,
    input rst_i,
    input button_hr_i,
    input button_min_i,
    output reg [18:0] seconds
    );
    
    always @(posedge clk_i or posedge rst_i) begin
        if(rst_i) begin
        end else if (clk_i)begin
            if(seconds < 86400)
                seconds = seconds + 1;
                if(button_hr_i == 1) begin
                    if (seconds < 82800)
                      seconds = seconds + 3600;
                    else
                      seconds = seconds - 82800;
                end else if (button_min_i == 1) begin
                    if (seconds < 86340)
                      seconds = seconds + 60;
                    else
                      seconds = seconds - 86340;                
                end
            else seconds = 1;  
        end                    
    end
endmodule
