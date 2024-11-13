`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 11/12/2024 12:51:27 AM
// Module Name: alarm_mode
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module alarm_mode(
    input wire set_alarm, alarm_mode_detected, incr_min, incr_hour,
    output wire [3:0] min_out, minten_out, hour_out, hourten_out,
    output reg [3:0] min_set, minten_set, hour_set, hourten_set
    );
    
    reg [3:0] min = 0;
    reg [3:0] minten = 0;
    reg [3:0] hour = 1;
    reg [3:0] hourten = 0;
    
    assign min_out = min;
    assign minten_out = minten;
    assign hour_out = hour;
    assign hourten_out = hourten;
    
    always @(set_alarm) begin
        if ((set_alarm == 1) && alarm_mode_detected) begin  // will only set alarm if in alarm mode
            min_set = min;
            minten_set = minten;
            hour_set = hour;
            hourten_set = hourten;
        end
    end
    
    always @(posedge incr_min) begin
        if (alarm_mode_detected) begin
            if (min == 9) begin
                min = 0;
                if (minten == 5)
                    minten = 0;
                else
                    minten = minten + 1;
            end
            else
                min = min + 1;
        end
    end
    
    always @(posedge incr_hour) begin
        if (alarm_mode_detected) begin
            if (hour == 2 && hourten == 1) begin
                hour = 1;
                hourten = 0;
            end
            else if (hour == 9 && hourten == 0) begin
                hour = 0;
                hourten = 1;
            end
            else
                hour = hour + 1;
        end
    end
    
endmodule
