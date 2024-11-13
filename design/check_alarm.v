`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 11/12/2024 02:19:04 AM
// Module Name: check_alarm
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module check_alarm(
    input wire time_mode_detected,
    input wire [3:0] min_set, minten_set, hour_set, hourten_set,
    input wire [3:0] min_time, minten_time, hour_time, hourten_time,
    output wire activate_alarm
    );
    
    reg activate_alarm_reg = 0;
    reg [1:0] count = 0;
    
    assign activate_alarm = activate_alarm_reg;
    
    always @(*) begin
        if ((time_mode_detected) &&
            (min_time == min_set) && (minten_time == minten_set) && 
            (hour_time == hour_set) && (hourten_time == hourten_set))
            activate_alarm_reg = 1;
        else
            activate_alarm_reg = 0;
    end
    
endmodule
