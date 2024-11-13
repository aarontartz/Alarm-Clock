`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 11/11/2024 08:13:02 PM
// Module Name: segdisp
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module segdisp(
    input wire [3:0] min, minten, hour, hourten, digit_sel,
    output reg [7:0] disp_num
    );
    
    localparam LED0 = 8'b00101000;   // "0"  
    localparam LED1 = 8'b11101011;   // "1" 
    localparam LED2 = 8'b00110010;   // "2" 
    localparam LED3 = 8'b10100010;   // "3" 
    localparam LED4 = 8'b11100001;   // "4" 
    localparam LED5 = 8'b10100100;   // "5" 
    localparam LED6 = 8'b00100100;   // "6" 
    localparam LED7 = 8'b11101010;   // "7" 
    localparam LED8 = 8'b00100000;   // "8"  
    localparam LED9 = 8'b10100000;   // "9" 
    
    always @(*) begin
        case(digit_sel)
            4'b0001: begin
                case(min)
                    4'b0000: disp_num = LED0;
                    4'b0001: disp_num = LED1;
                    4'b0010: disp_num = LED2;
                    4'b0011: disp_num = LED3;
                    4'b0100: disp_num = LED4;
                    4'b0101: disp_num = LED5;
                    4'b0110: disp_num = LED6;
                    4'b0111: disp_num = LED7;
                    4'b1000: disp_num = LED8;
                    4'b1001: disp_num = LED9;
                endcase
            end
                    
            4'b0010: begin       // minten Digit
                case(minten)
                    4'b0000: disp_num = LED0;
                    4'b0001: disp_num = LED1;
                    4'b0010: disp_num = LED2;
                    4'b0011: disp_num = LED3;
                    4'b0100: disp_num = LED4;
                    4'b0101: disp_num = LED5;
                    endcase
                end
                    
            4'b0100: begin
                case(hour)
                    4'b0000: disp_num = LED0;
                    4'b0001: disp_num = LED1;
                    4'b0010: disp_num = LED2;
                    4'b0011: disp_num = LED3;
                    4'b0100: disp_num = LED4;
                    4'b0101: disp_num = LED5;
                    4'b0110: disp_num = LED6;
                    4'b0111: disp_num = LED7;
                    4'b1000: disp_num = LED8;
                    4'b1001: disp_num = LED9;
                    endcase
                end
                    
            4'b1000: begin
                case(hourten)
                    4'b0000: disp_num = LED0;
                    4'b0001: disp_num = LED1;
                    endcase
                end
        endcase
    end
endmodule
