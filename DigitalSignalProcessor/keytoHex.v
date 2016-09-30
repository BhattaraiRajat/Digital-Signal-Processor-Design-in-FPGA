`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:00:19 08/20/2015 
// Design Name: 
// Module Name:    keytoHex 
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
module keytoHex(input [7:0] key_code,
					 output reg [7:0] Hex
					);

always @ * 
begin
case(key_code)
			8'h45: Hex = 8'b00000000; //0
			8'h16: Hex = 8'b00000001; //1
			8'h1E: Hex = 8'b00000010; //2
			8'h26: Hex = 8'b00000011; //3
			8'h25: Hex = 8'b00000100; //4
			8'h2E: Hex = 8'b00000101; //5
			8'h36: Hex = 8'b00000110; //6
			8'h3d: Hex = 8'b00000111; //7
			8'h3e: Hex = 8'b00001000; //8
			8'h46: Hex = 8'b00001001; //9
			8'h1c: Hex = 8'b00001010; //a
			8'h32: Hex = 8'b00001011; //b
			8'h21: Hex = 8'b00001100; //c
			8'h23: Hex = 8'b00001101; //d
			8'h24: Hex = 8'b00001110; //e
			8'h2b: Hex = 8'b00001111; //f
			default: begin
			end
		endcase 
end
endmodule
