`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:17:22 08/23/2015 
// Design Name: 
// Module Name:    CLA8bit 
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
module CLA8bit(
					A,
					B,
					Cin,
					Sum,
					Cout
               );
	 
input [7:0] A,
            B;
input Cin;

output [7:0] Sum;
output Cout;
wire [7:0] G,
           P,
			  C;

assign G = A & B;
assign P = A ^ B;
assign Sum = {P[7] ^ C[6],P[6] ^ C[5],P[5] ^ C[4],P[4] ^ C[3],P[3] ^ C[2],P[2] ^ C[1],P[1] ^ C[0], P[0] ^ Cin};
assign Cout = C[7];

assign C[0]=G[0]|(P[0]&Cin);
assign C[1]=G[1]|(P[1]&G[0])|(P[1]&P[0]&Cin);
assign C[2]=G[2]|(P[2]&G[1])|(P[2]&P[1]&G[0])|(P[2]&P[1]&P[0]&Cin);
assign C[3]=G[3]|(P[3]&G[2])|(P[3]&P[2]&G[1])|(P[3]&P[2]&P[1]&G[0])|(P[3]&P[2]&P[1]&P[0]&Cin);
assign C[4]=G[4]|(P[4]&G[3])|(P[4]&P[3]&G[2])|(P[4]&P[3]&P[2]&G[1])|(P[4]&P[3]&P[2]&P[1]&G[0])|(P[4]&P[3]&P[2]&P[1]&P[0]&Cin);
assign C[5]=G[5]|(P[5]&G[4])|(P[5]&P[4]&G[3])|(P[5]&P[4]&P[3]&G[2])|(P[5]&P[4]&P[3]&P[2]&G[1])|(P[5]&P[4]&P[3]&P[2]&P[1]&G[0])|(P[5]&P[4]&P[3]&P[2]&P[1]&P[0]&Cin) ;
assign C[6]=G[6]|(P[6]&G[5])|(P[6]&P[5]&G[4])|(P[6]&P[5]&P[4]&G[3])|(P[6]&P[5]&P[4]&P[3]&G[2])|(P[6]&P[5]&P[4]&P[3]&P[2]&G[1])|(P[6]&P[5]&P[4]&P[3]&P[2]&P[1]&G[0])|( P[6]&P[5]&P[4]&P[3]&P[2]&P[1]&P[0]&Cin);
assign C[7]=G[7]|(P[7]&G[6])|(P[7]&P[6]&G[5])|(P[7]&P[6]&P[5]&G[4])|(P[7]&P[6]&P[5]&P[4]&G[3])|(P[7]&P[6]&P[5]&P[4]&P[3]&G[2])|(P[7]&P[6]&P[5]&P[4]&P[3]&P[2]&G[1])|( P[7]&P[6]&P[5]&P[4]&P[3]&P[2]&P[1]&G[0])|(P[7]&P[6]&P[5]&P[4]&P[3]&P[2]&P[1]&P[0]&Cin);
endmodule
