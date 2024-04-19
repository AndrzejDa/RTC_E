`timescale 1ns / 1ps

module rtc(clk_i, rst_i, button_hr_i, button_min_i, button_test_i, led7_seg_o, led7_an_o);
    
    input clk_i;
    input rst_i;
    input button_hr_i;
    input button_min_i;
    input button_test_i;
    //output xd;
    output [7:0] led7_seg_o;
    output [7:0] led7_an_o;
    
    wire b_hr_deb;
    wire b_min_deb;
    wire b_test_deb;
    wire pclk;
    wire clk_1ms;
    wire [18:0] seconds;
    wire [3:0] hours_tens;
    wire [3:0] hours_ones;
    wire [3:0] minutes_tens;
    wire [3:0] minutes_ones;
    wire [6:0] digit_h_t;
    wire [6:0] digit_h_o;
    wire [6:0] digit_m_t;
    wire [6:0] digit_m_o;
    
    
    debouncer db_hr(button_hr_i, rst_i, clk_i, b_hr_deb);
    debouncer db_min(button_min_i, rst_i, clk_i, b_min_deb);
    debouncer db_test(button_test_i, rst_i, clk_i, b_test_deb);
    
    Prescaler pres(button_test_i, clk_i, rst_i, pclk);
    DisplaySync dync(clk_i, clk_1ms);         
    Clock counter(pclk, rst_i, b_hr_deb, b_min_deb, seconds);
    DigitDecoder decoder(seconds, hours_tens, hours_ones, minutes_tens, minutes_ones);
    Digit d1(hours_tens, digit_h_t);
    Digit d2(hours_ones, digit_h_o);
    Digit d3(minutes_tens, digit_m_t);
    Digit d4(minutes_ones, digit_m_o);
    Display seg7(pclk, clk_1ms, rst_i, digit_h_t, digit_h_o, digit_m_t, digit_m_o, led7_seg_o, led7_an_o);
    
    
endmodule
