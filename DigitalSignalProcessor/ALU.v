`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:26:07 09/14/2015 
// Design Name: 
// Module Name:    ALU 
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
module ALU( input [7:0] acc_in,
				input [7:0] data_register,
				input [3:0] opcode,
				output [7:0] result
				);
ALU_Unit ALU (
    .In1(acc_in), 
    .In2(data_register), 
    .Opcode(opcode), 
    .Result(result), 
    .Cout()
    );

endmodule
