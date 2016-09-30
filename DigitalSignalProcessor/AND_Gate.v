`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:12:31 08/23/2015 
// Design Name: 
// Module Name:    AND_Gate 
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
module AND_Gate(In1,
                In2,
					 Out
                );

input [7:0] In1,
            In2;
				
output [7:0] Out;

assign Out= In1 & In2;

endmodule
