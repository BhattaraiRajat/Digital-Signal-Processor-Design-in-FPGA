`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:17:40 08/23/2015 
// Design Name: 
// Module Name:    Subtractor8bit 
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
module Subtractor8bit( 	A,
								B,
								Diff,
								Cout
    );
	 
	 input [7:0] A,B;
	 output [7:0] Diff;
	 output Cout;
	 wire [7:0] Bi;
	 assign Bi = B ^ 8'hff;
	 
	 CLA8bit uut (
		.A(A), 
		.B(Bi), 
		.Cin(1'b1), 
		.Sum(Diff), 
		.Cout(Cout)
	);



endmodule
