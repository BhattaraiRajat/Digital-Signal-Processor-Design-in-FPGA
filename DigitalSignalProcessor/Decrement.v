`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:16:19 08/23/2015 
// Design Name: 
// Module Name:    Decrement 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Decrement(In1,
                 Out
    );

input [7:0] In1;

output [7:0] Out;

assign Out=In1-1;

endmodule
