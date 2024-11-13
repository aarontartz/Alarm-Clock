`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 11/11/2024 09:05:20 PM
// Module Name: iterate_anode
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module iterate_anode (
    input wire clk_1khz,
    output reg [3:0] anode_sel
    );
    
    reg [1:0] count = 0;
    
    always @(posedge clk_1khz) begin
        if (count == 2'b11)
            count <= 2'b00;
        else
            count <= count + 1;
    end
    
    always @(*) begin
        case (count)
            2'b00: anode_sel = 4'b0001;
            2'b01: anode_sel = 4'b0010;
            2'b10: anode_sel = 4'b0100;
            2'b11: anode_sel = 4'b1000;
        endcase
    end
    
endmodule
