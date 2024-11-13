`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 11/11/2024 09:05:20 PM
// Module Name: debounce
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////

module debounce(
    input wire clk_1khz,
    input wire btn_in,
    output wire btn_out
    );
    
    reg t0, t1, t2;
    
    assign btn_out = t2;
    
    always @(posedge clk_1khz) begin
        t0 <= btn_in;
        t1 <= t0;
        t2 <= t1;
    end
    
endmodule
