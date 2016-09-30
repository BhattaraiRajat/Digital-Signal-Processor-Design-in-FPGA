`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:20:10 08/23/2015 
// Design Name: 
// Module Name:    Left_Shift 
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
module Left_Shift(In1,
                   Out
                   );
						
input [7:0] In1;
output [7:0] Out;

assign Out ={In1[6:0],1'b0};


endmodule
