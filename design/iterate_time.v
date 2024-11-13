`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 11/11/2024 09:22:32 PM
// Module Name: iterate_time
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module iterate_time(
    input wire clk_1hz,
    output wire [3:0] min, minten, hour, hourten
    );
    
    reg [3:0] min_reg = 0;
    reg [3:0] minten_reg = 5;
    reg [3:0] hour_reg = 2;
    reg [3:0] hourten_reg = 1;
    
    assign min = min_reg;
    assign minten = minten_reg;
    assign hour = hour_reg;
    assign hourten = hourten_reg;
    
    always @(posedge clk_1hz) begin
        if (min_reg == 9) begin
            min_reg <= 0;
            if (minten_reg == 5) begin
                minten_reg <= 0;
                if (hour_reg == 2 && hourten_reg == 1) begin
                    hour_reg <= 1;  // 12:59 -> 01:00
                    hourten_reg <= 0;
                end
                else if (hour_reg == 9 && hourten_reg == 0) begin
                    hour_reg <= 0;  // 09:59 -> 10:00
                    hourten_reg <= 1;
                end
                else
                    hour_reg <= hour_reg + 1;
            end
            else
                minten_reg <= minten_reg + 1;
        end
        else
            min_reg <= min_reg + 1;
    end
endmodule
