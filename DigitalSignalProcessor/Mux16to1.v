`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:24:02 08/23/2015 
// Design Name: 
// Module Name:    Mux16to1 
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
module Mux16to1(Sel,
					In0,
					In1,
					In2,
					In3,
					In4,
					In5,
					In6,
					In7,
					In8,
					In9,
					In10,
					In11,
					In12,
					In13,
					Out
					);
					
input [7:0] 	In0,
					In1,
					In2,
					In3,
					In4,
					In5,
					In6,
					In7,
					In8,
					In9,
					In10,
					In11,
					In12,
					In13;
					
input [3:0] Sel;

output reg [7:0] Out;


always @ (Sel or In0 or In1 or In2 or In3 or In4 or In5 or In6 or In7 or In8 or In9 or In10 or In11 or In12 or In13 )
begin
case (Sel)
4'd0:  Out = In0;
4'd1:  Out = In1;
4'd2:  Out = In2;
4'd3:  Out = In3;
4'd4:  Out = In4;
4'd5:  Out = In5;
4'd6:  Out = In6;
4'd7:  Out = In7;
4'd8:  Out = In8;
4'd9:  Out = In9;
4'd10:  Out = In10;
4'd11:  Out = In11;
4'd12:  Out = In12;
4'd13:  Out = In13;
default: begin
end
endcase
end
endmodule
