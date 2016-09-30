`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:20:57 08/23/2015 
// Design Name: 
// Module Name:    Arithmetic_Right_Shift 
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
module Arithmetic_Right_Shift(In1,
                   Out
                   );
						
input [7:0] In1;
output [7:0] Out;

assign Out ={{In1[7]},In1[7:1]};

endmodule