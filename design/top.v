`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Aaron Tartz
// 
// Create Date: 11/11/2024 08:52:03 PM
// Module Name: top
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input wire clk,
    input wire [1:0] btn,
    input wire ck_io40, ck_io41,
    output wire ck_io1, ck_io2, ck_io3, ck_io4, ck_io5, ck_io7, ck_io10, ck_io11,
    output wire ck_io6, ck_io8, ck_io9, ck_io12,
    output wire led0_g
    );
    
    wire clk_1hz, clk_1khz;
    wire [1:0] btn_out;
    wire [3:0] digit_sel;
    wire [3:0] min, minten, hour, hourten;
    wire [3:0] min_set, minten_set, hour_set, hourten_set;
    wire [3:0] min_time, minten_time, hour_time, hourten_time;
    wire [3:0] min_alarm, minten_alarm, hour_alarm, hourten_alarm;
    wire [7:0] disp_num;
    
    assign {ck_io12, ck_io9, ck_io8, ck_io6} = digit_sel;
    assign {ck_io1, ck_io2, ck_io3, ck_io4, ck_io5, ck_io7, ck_io10, ck_io11} = disp_num;
    
    assign min = ck_io41 ? min_alarm : min_time;
    assign minten = ck_io41 ? minten_alarm : minten_time;
    assign hour = ck_io41 ? hour_alarm : hour_time;
    assign hourten = ck_io41 ? hourten_alarm : hourten_time;
    
    debounce debounce_btn0 (  // hour increase
        .clk_1khz(clk_1khz),
        .btn_in(btn[0]),
        .btn_out(btn_out[0])
    );
    
    debounce debounce_btn1 (  // min increase
        .clk_1khz(clk_1khz),
        .btn_in(btn[1]),
        .btn_out(btn_out[1])
    );
    
    gen_freq gen_1hz (
        .clk(clk),
        .divider(32'd50_000_000),
        .clk_1hz(clk_1hz)
    );
    
    gen_freq gen_1khz (
        .clk(clk),
        .divider(32'd50_000),
        .clk_1hz(clk_1khz)
    );
    
    iterate_anode iterate_anode_inst (
        .clk_1khz(clk_1khz),
        .anode_sel(digit_sel)
    );
    
    iterate_time iterate_time_inst (
        .clk_1hz(clk_1hz),
        .min(min_time),
        .minten(minten_time),
        .hour(hour_time),
        .hourten(hourten_time)
    );
    
    alarm_mode alarm_mode_inst (
        .alarm_mode_detected(ck_io41),
        .set_alarm(ck_io40),
        .incr_min(btn_out[1]),
        .incr_hour(btn_out[0]),
        .min_out(min_alarm),
        .minten_out(minten_alarm),
        .hour_out(hour_alarm),
        .hourten_out(hourten_alarm),
        .min_set(min_set),
        .minten_set(minten_set),
        .hour_set(hour_set),
        .hourten_set(hourten_set)
    );
    
    check_alarm check_alarm_inst (
        .time_mode_detected(~ck_io41),  // mode that displays clock, not changing alarm
        .min_set(min_set),
        .minten_set(minten_set),
        .hour_set(hour_set),
        .hourten_set(hourten_set),
        .min_time(min_time),
        .minten_time(minten_time),
        .hour_time(hour_time),
        .hourten_time(hourten_time),
        .activate_alarm(led0_g)
    );

    segdisp segdisp_inst (
        .min(min),
        .minten(minten),
        .hour(hour),
        .hourten(hourten),
        .digit_sel(digit_sel),
        .disp_num(disp_num)
    );
    
endmodule
