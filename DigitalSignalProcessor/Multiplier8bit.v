`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:18:15 08/23/2015 
// Design Name: 
// Module Name:    Multiplier8bit 
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
module Multiplier8bit(In1,
                       In2,
							  Out
                       );

input signed [7:0] In1,
                   In2;
				
output signed [15:0] Out;

assign Out = In1*In2;


endmodule
