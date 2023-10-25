`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.04.2023 18:15:07
// Design Name: 
// Module Name: Colddrink_Dispenser_tb
// Name - Kaushal Kumar Kumawat
// Roll No. - 21PHC1R15
//////////////////////////////////////////////////////////////////////////////////


module Colddrink_Dispenser_tb();
reg clock, reset;
reg [2:0] input_coin;
reg [1:0] sel_colddrink;
wire out, coke, pepsi, maaza;
wire [2:0] change,balance;

Colddrink_Dispenser CD_1(clock, reset,input_coin,sel_colddrink,out,coke, pepsi, maaza,change,balance);

initial
begin
    clock = 0;
    reset = 1;
    input_coin =0;
    sel_colddrink = 0;
    #10 reset = 0;
    #10 sel_colddrink = 2'b01;
    #10 input_coin = 3'd1;
    #10 input_coin = 3'd2;
    #10 input_coin = 3'd0;
    //reset = 1;
    //#1 reset = 0;
    #10 sel_colddrink = 2'b10;
    #10 input_coin = 3'd5;
    #10 input_coin = 3'd0;
    //reset = 1;
    //#1 reset = 0;
    #10 sel_colddrink = 2'b11;
    #10 input_coin = 3'd2;
    #10 input_coin = 3'd0;
end


initial #150 $stop;

endmodule
