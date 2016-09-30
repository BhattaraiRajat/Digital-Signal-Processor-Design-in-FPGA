`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:10:08 08/20/2015 
// Design Name: 
// Module Name:    HextoASCII 
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
module HextoASCII(input [7:0] Hex,
						output reg [7:0] ascii_code 
						);
always @ *
 
begin
		case(Hex)
			8'h0: ascii_code = 8'b00110000; //0
			8'h1: ascii_code = 8'b00110001; //1
			8'h2: ascii_code = 8'b00110010; //2
			8'h3: ascii_code = 8'b00110011; //3
			8'h4: ascii_code = 8'b00110100; //4
			8'h5: ascii_code = 8'b00110101; //5
			8'h6: ascii_code = 8'b00110110; //6
			8'h7: ascii_code = 8'b00110111; //7
			8'h8: ascii_code = 8'b00111000; //8
			8'h9: ascii_code = 8'b00111001; //9
			8'ha: ascii_code = 8'b01000001; //a
			8'hb: ascii_code = 8'b01000010; //b
			8'hc: ascii_code = 8'b01000011; //c
			8'hd: ascii_code = 8'b01000100; //d
			8'he: ascii_code = 8'b01000101; //e
			8'hf: ascii_code = 8'b01000110; //f
			default: ascii_code = 8'b1010_0000;
		endcase

end
endmodule
