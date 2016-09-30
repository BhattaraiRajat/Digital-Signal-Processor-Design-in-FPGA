`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:23:43 08/23/2015 
// Design Name: 
// Module Name:    DeMux1to16 
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
module DeMux1to16(In1,
                  Sel,
						Out0,
						Out1,
						Out2,
						Out3,
						Out4,
						Out5,
						Out6,
						Out7,
						Out8,
						Out9,
						Out10,
						Out11,
						Out12,
						Out13
                  );
	 
input [7:0] In1;

input [3:0] Sel;

 output reg [7:0]  Out0,
                   Out1,
						 Out2,
						 Out3,
						 Out4,
						 Out5,
						 Out6,
						 Out7,
						 Out8,
						 Out9,
						 Out10,
						 Out11,
						 Out12,
						 Out13;
						 
	 
always @ (Sel or In1)
begin
case(Sel)
4'd0: Out0 =  In1;
4'd1: Out1 =  In1;
4'd2: Out2 =  In1;
4'd3: Out3 =  In1;
4'd4: Out4 =  In1;
4'd5: Out5 =  In1;
4'd6: Out6 =  In1;
4'd7: Out7 =  In1;
4'd8: Out8 =  In1;
4'd9: Out9 =  In1;
4'd10: Out10 = In1;
4'd11: Out11 = In1;
4'd12: Out12 = In1;
4'd13: Out13 = In1;
default: begin
end
endcase
end


endmodule

