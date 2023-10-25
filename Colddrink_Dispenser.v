`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.04.2023 10:19:28
// Design Name: 
// Module Name: Colddrink_Dispenser
// Lab project 1 - It's a vending machine that dispense the cold drink.
// Name - Kaushal Kumar Kumawat
// Roll No. - 21PHC1R15
//////////////////////////////////////////////////////////////////////////////////


module Colddrink_Dispenser(
input clock, reset,
input [2:0] input_coin,
input [1:0] sel_colddrink,
output reg out,coke, pepsi, maaza,
output reg [2:0] change,
output reg [2:0] balance);


// Defining the parameters of the cold drink dispenser
// -> Parameters for the money in INR 
parameter [2:0] INR_0 = 3'b000;
parameter [2:0] INR_1 = 3'b001;
parameter [2:0] INR_2 = 3'b010;
parameter [2:0] INR_3 = 3'b011;
parameter [2:0] INR_4 = 3'b100;
parameter [2:0] INR_5 = 3'b101;
parameter [2:0] INR_6 = 3'b110;

// -> Parameters for select cold drink
parameter [1:0] NOTHING = 2'b00;
parameter [1:0] sel_coke = 2'b01;
parameter [1:0] sel_pepsi = 2'b10;
parameter [1:0] sel_maaza = 2'b11;

// -> Parameters for state machine
reg pre_state, nxt_state;

parameter state_0 = 1'b0;
parameter state_1 = 1'b1;

// Defining the initial conditions
initial
begin
        pre_state <= state_0;
        nxt_state <= state_0;
        change <= INR_0;
        balance <=0;
        out <= 0;
        coke <= 0;
        pepsi <= 0;
        maaza <= 0;
end

// Combinationational block for defining the next state of the vending machine
always @(input_coin, pre_state)
begin
    case(pre_state)
        state_0:
                if(input_coin == INR_0)
                    nxt_state <= state_1;
                else if(input_coin == INR_2 && input_coin == INR_5)
                    nxt_state <= state_0;
        
        state_1:
                if(input_coin == INR_1 && input_coin == INR_2 && input_coin == INR_5)
                    nxt_state <= state_0;
    endcase
end

// Defining the nxt_state update
always @(negedge clock or posedge reset)
begin
    if(reset)
        pre_state <= state_0;
    else
        pre_state <= nxt_state;
end


// Defining the output combinationation logic 
always @(input_coin, sel_colddrink, pre_state)
begin
    case(pre_state)
        state_0:
                if(input_coin == INR_0)
                begin
                    balance = balance + INR_0;
                end
                else if(input_coin == INR_1)
                begin
                    balance = balance + INR_1;
                end
                else if(input_coin == INR_2)
                begin
                    balance = balance + INR_2;
                end
                else if(input_coin == INR_5)
                begin
                    balance = balance + INR_5;
                end
        
        state_1:
            if(input_coin == INR_0)
            begin
                balance = balance + INR_0;
            end
            else if(input_coin == INR_1)
            begin
                balance = balance + INR_1;
            end
            else if(input_coin == INR_2)
            begin
                balance = balance + INR_2;
            end
            else if(input_coin == INR_5)
            begin
                balance = balance + INR_5;
            end
    endcase        
end
// Defining the type of coldrink based on selected cold drink and balance.
always @(*)
begin
    case(balance)
        INR_0:
        begin
            out = 0;
            change = 0;
        end
        INR_1:
        begin
            out = 0;
            change = 0;
        end
        INR_2:
        begin
            out = 1;
            change = balance - INR_2;
        end
        INR_3:
        begin
            out = 1;
            change = balance - INR_2;
        end
        INR_4:
        begin
            out = 1;
            change = balance - INR_2;
        end
        INR_5:
        begin
            out = 1;
            change = balance - INR_2;
        end
        INR_6:
        begin
            out = 1;
            change = balance - INR_2;
        end
    endcase   
    if(sel_colddrink == sel_coke && out == 1)
        coke <= 1;
    else if(sel_colddrink == sel_pepsi && out == 1)
        pepsi <= 1;
    else if(sel_colddrink == sel_maaza && out == 1)
        maaza <= 1;
        
    if(out == 1)
    fork
        #10 pre_state <= state_0;
        #10 nxt_state <= state_0;
        #10 change <= INR_0;
        #10 balance <=0;
        #10 out <= 0;
        #10 coke <= 0;
        #10 pepsi <= 0;
        #10 maaza <= 0;
    join
end
endmodule
