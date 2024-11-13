`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 11/11/2024 09:30:58 PM
// Module Name: gen_freq
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module gen_freq(
    input wire clk,
    input wire [31:0] divider,
    output wire clk_1hz
    );
    
    reg [31:0] count = 0;
    reg clk_1hz_reg = 0;
    
    assign clk_1hz = clk_1hz_reg;
    
    always @(posedge clk) begin
        if (count == (divider - 1)) begin
            clk_1hz_reg = ~clk_1hz_reg;
            count <= 0;
        end
        else
            count <= count + 1;
    end
    
endmodule
