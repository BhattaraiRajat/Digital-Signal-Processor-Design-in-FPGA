`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:22:37 08/20/2015 
// Design Name: 
// Module Name:    lcdDriver 
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
//to display a fixed no. of characters defined by letter_cnt
module lcdDriver( 	clk,      
							reset,
							LCD_DB,        
							LCD_E,      
							LCD_RS,      
							LCD_RW,      	
							char_input
					);
		
input				clk;
input				reset;
input [255:0] 	char_input; 
	
output [7:0] 	LCD_DB;
output 			LCD_E;
output 			LCD_RS;
output 			LCD_RW;
//output 			SF_CE0;

integer	letter_cnt=32; //no. of characters to be printed

reg [2:0] tx_state = 3'b110; //initalized to done condition
reg [7:0] tx_byte;
wire tx_init;

wire init_init; 
reg init_done = 1'b0;
reg [3:0] init_state = 4'b0000;

reg [7:0] ascii [0:31];
//---------------------------------------------------------------------------------------------------------------------------------
integer i1 = 0; //ascii char index
integer i  = 0; //power on initialization counter
integer i2 = 0; //transmission state machine counter
integer i3 = 0; //pause counter
//-----------------------------------------------------------------------------------------------------------------------------------
reg [3:0] SF_D0,SF_D1;
reg LCD_E0, LCD_E1;
wire mux;
reg [3:0] cur_state = 4'b0000;
parameter [2:0]	high_setup 				= 3'b000, 
						high_hold 				= 3'b001, 
						oneus 					= 3'b010, 
						low_setup 				= 3'b011, 
						low_hold 				= 3'b100, 
						fortyus 					= 3'b101, 
						done1 					= 3'b110;


//---------------------------------------------------------------------------------------------------------------------------------------
parameter [3:0]	idle 				= 4'b0000, 
						fifteenms 		= 4'b0001, 
						one 				= 4'b0010, 
						two 				= 4'b0011, 
						three 			= 4'b0100, 
						four 				= 4'b0101, 
						five 				= 4'b0110, 
						six 				= 4'b0111, 
						seven 			= 4'b1000, 
						eight 			= 4'b1001, 
						done2 			= 4'b1010;
						

//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
parameter [3:0]	init 					= 4'b0000, 
						function_set		= 4'b0001, 
						entry_set			= 4'b0010, 
						set_display			= 4'b0011, 
						clr_display			= 4'b0100, 
						pause					= 4'b0101, 
						set_addr				= 4'b0110, 
						Char2Display		= 4'b0111,
						char_update			= 4'b1000,
						done3					= 4'b1001;
						



////////////////trigger///////////////////////

wire rstclk;
assign rstclk = (clk|reset);
assign LCD_DB[3:0] = 4'b1111;
assign {LCD_DB[7:4], LCD_E} = (mux) ? {SF_D0, LCD_E0}:{SF_D1, LCD_E1};
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//assign SF_CE0 	= 1'b1;
assign LCD_RW 	= 1'b0;
//--------------------------------------------------------------------------------------------------------------------------------
assign tx_init = ((cur_state == init)|(cur_state == pause)|(cur_state == char_update)|(cur_state == done3)) ? 1'b0:1'b1;
assign mux 		= (cur_state == init)? 1'b0: 1'b1;

//--------------------------------------------------------------------------------------------------------------------------------
assign init_init = (cur_state == init)? 1'b1: 1'b0;

assign LCD_RS = ((cur_state == function_set)|(cur_state == entry_set)|(cur_state == set_display)|
					  (cur_state == clr_display)|(cur_state == set_addr))? 1'b0: 1'b1;
//------------------------------------------------------------------------------------------------------------------------------
always @ (posedge clk)
begin
	ascii[0] = char_input[7:0];
	ascii[1] = char_input[15:8];
	ascii[2] = char_input[23:16];
	ascii[3] = char_input[31:24];
	ascii[4] = char_input[39:32];
	ascii[5] = char_input[47:40];
	ascii[6] = char_input[55:48];
	ascii[7] = char_input[63:56];
	ascii[8] = char_input[71:64];
	ascii[9] = char_input[79:72];
	ascii[10] = char_input[87:80];
	ascii[11] = char_input[95:88];
	ascii[12] = char_input[103:96];
	ascii[13] = char_input[111:104];
	ascii[14] = char_input[119:112];
	ascii[15] = char_input[127:120];
	ascii[16] = char_input[135:128];
	ascii[17] = char_input[143:136];
	ascii[18] = char_input[151:144];
	ascii[19] = char_input[159:152];
	ascii[20] = char_input[167:160];
	ascii[21] = char_input[175:168];
	ascii[22] = char_input[183:176];
	ascii[23] = char_input[191:184];
	ascii[24] = char_input[199:192];
	ascii[25] = char_input[207:200];
	ascii[26] = char_input[215:208];
	ascii[27] = char_input[223:216];
	ascii[28] = char_input[231:224];
	ascii[29] = char_input[239:232];
	ascii[30] = char_input[247:240];
	ascii[31] = char_input[255:248];
end									
//--what byte to transmit to lcd
always @  (posedge clk)
      begin
      case(cur_state)
				function_set		: begin tx_byte = 8'b0010_1000;  end			
				entry_set			: begin tx_byte = 8'b0000_0110;  end
				set_display			: begin tx_byte = 8'b0000_1111;  end
				clr_display			: begin tx_byte = 8'b0000_0001;  end
				set_addr				: begin tx_byte = (i1==16)? 8'b1100_0000:8'b1000_0000;  end
				Char2Display		: begin tx_byte = ascii[i1];  end
				default				: begin tx_byte = 8'b0000_0000;  end
		endcase
	end
							 
//--main state machine
always @ (posedge clk or posedge reset)
begin
     if(reset == 1'b1) 
	  begin
           cur_state = init;
			  i1 = 0;
	  end
     else begin
           case(cur_state)
//--refer to intialize state machine below
								init:
												begin
													 if(init_done == 1'b1)
														 cur_state = function_set;
													 else
														 cur_state = init;
													 //end
												 end
 //--every other state but pause uses the transmit state machine
								function_set:
														begin
															 if(i2 == 2000)
																 cur_state = entry_set;
															 else
																 cur_state = function_set;
															 //end
														 end
								entry_set:
													  begin
														  if(i2 == 2000)
															  cur_state = set_display;
														  else
															  cur_state = entry_set;
														  //end
													  end
								set_display:
								                   begin
															 if(i2 == 2000) 
																 cur_state = clr_display;
															 else
																 cur_state = set_display;
															// end
														 end
								clr_display:
								                   begin
															 i3 = 0;
															 if(i2 == 2000) 
																 cur_state = pause;
															 else
																 cur_state = clr_display;
															// end
														 end
								pause:
								              begin
													  if(i3 == 82000) begin
														  cur_state = set_addr;
														  i3 = 0;
														  end
													  else begin
															cur_state = pause;
															i3 = i3 + 1;
															end
													 // end
												  end
								set_addr:
								                begin
													 //done_data_flag=1'b0;
														 if(i2 == 2000) 
															 cur_state = Char2Display;
														 else
															 cur_state = set_addr;
														// end
													 end
								Char2Display:
								               begin
														if(i2 == 2000) 
															cur_state = char_update;
														else
															cur_state = Char2Display;
														//end
													end
														
								char_update:
													begin
														if(i1<letter_cnt)
															begin
																i1 = i1+1;
																
																if( i1==16 || i1==32) 
																cur_state=set_addr;
																else
																cur_state = Char2Display;
																
															end
														else
															begin
																i1 = 0;
																//done_data_flag=1'b1;
																cur_state = done3;
															end
													end
								done3:
									begin
									//if(new_data_flag)
									 //begin
									//done_data_flag=1'b0;
									cur_state = set_addr;
									//end
									//else	
//									 begin
//									 cur_state = done3;
//									 end
									end
													
								
				endcase
			end
	end
	



//--transmission state machine
always @ (posedge rstclk)
begin
     if(reset==1'b1)
			begin
				tx_state = done1;
			end
     else begin
           case (tx_state)
							high_setup:			 //--40ns
													begin
														LCD_E0 	= 1'b0;
														SF_D0 	= tx_byte[7:4];
														if(i2 == 2) begin
															tx_state = high_hold;
															i2 = 0;
															end
 														else begin
															tx_state = high_setup;
															i2 = i2 + 1;
															end
														//end 
													end
							high_hold:			// --230ns
							                 begin
													  LCD_E0 = 1'b1;
													  SF_D0 = tx_byte[7:4];
													  if(i2 == 12) begin
														  tx_state = oneus;
														  i2 = 0;
														  end
													  else begin
														  tx_state = high_hold;
														  i2 = i2 + 1;
														  end
													 // end
												  end
							oneus:
							             begin
												 LCD_E0 = 1'b0;
												 if(i2 == 50) begin
													 tx_state = low_setup;
													 i2 = 0;
													 end
												 else begin
													 tx_state = oneus;
													 i2 = i2 + 1;
													 end
												// end
											 end
							low_setup:
												  begin
													  LCD_E0 = 1'b0;
													  SF_D0 = tx_byte[3:0];
													  if(i2 == 2) begin
														  tx_state = low_hold;
														  i2 = 0;
														  end
													  else begin
														  tx_state = low_setup;
														  i2 = i2 + 1;
														  end
													//  end
												  end
							low_hold:
												begin
													LCD_E0 = 1'b1;
													SF_D0 = tx_byte[3:0];
													if(i2 == 12) begin
													  tx_state = fortyus;
													  i2 = 0;
													  end
													else begin
													  tx_state = low_hold;
													  i2 = i2 + 1;
													  end
													//end
												end
							fortyus:
												begin
													LCD_E0 = 1'b0;
													if(i2 == 2000) begin
														tx_state = done1;
														i2 = 0;
														end
													else begin
														tx_state = fortyus;
														i2 = i2 + 1;
														end
												//	end
												end
							done1:
											begin
												LCD_E0 = 1'b0;
												if(tx_init == 1'b1) begin
													tx_state = high_setup;
													i2 = 0;
													end
												else begin
													tx_state = done1;
													i2 = 0;
													end
												//end
											end
			 endcase
    end
end
//--specified by datasheet ---power on initialization
always @ (posedge rstclk) /// rstclk = (clk|reset);

begin
     if(reset == 1'b1) begin
       init_state = idle;
       init_done = 1'b0;
		end
     else 
	  begin
       case(init_state)
						idle:
										begin
											init_done = 1'b0;
											if(init_init == 1'b1) begin
												init_state = fifteenms;
												i = 0;
											end
											else begin
												init_state = idle;
												i = i + 1;
											end
											//end
										end
						fifteenms:
												begin
													init_done = 1'b0;
													if(i == 750000) begin
														init_state = one;
														i = 0;
													end
													else begin
														init_state = fifteenms;
														i = i + 1;
													end
													//end
												end
						one:
										begin
										SF_D1 = 4'b0011;
										LCD_E1 = 1'b1;
										init_done = 1'b0;
										if(i == 11) begin
										   init_state = two;
										   i = 0;
										end
										else begin
										   init_state = one;
										   i = i + 1;
										end
										//end
										end
						two:
										begin
											LCD_E1 = 1'b0;
											init_done = 1'b0;
											if(i == 205000) begin
												init_state=three;
												i = 0;
											end
											else begin
												init_state=two;
												i = i + 1;
											end
											//end
										end
						three:
										begin
											SF_D1 = 4'b0011;
											LCD_E1 = 1'b1;
											init_done = 1'b0;
											if(i == 11) begin
												init_state=four;
												i = 0;
											end
											else begin
												init_state=three;
												i = i + 1;
											end
											//end
										end
						four:
										begin
											LCD_E1 = 1'b0;
											init_done = 1'b0;
											if(i == 5000) begin
												init_state=five;
												i = 0;
											end
											else begin
												init_state=four;
												i = i + 1;
											end
											//end
										end
						five:
										begin
											SF_D1 = 4'b0011;
											LCD_E1 = 1'b1;
											init_done = 1'b0;
											if(i == 11) begin
												init_state=six;
												i = 0;
											end
											else begin
												init_state=five;
												i = i + 1;
											end
										end
						six:
										begin
											LCD_E1 = 1'b0;
											init_done = 1'b0;
											if(i == 2000) begin
												init_state=seven;
												i = 0;
											end
											else begin
												init_state=six;
												i = i + 1;
											end
											//end
										end
						seven:
										begin
											SF_D1 = 4'b0010;
											LCD_E1 = 1'b1;
											init_done = 1'b0;
											if(i == 11) begin
												init_state=eight;
												i = 0;
											end
											else begin
												init_state=seven;
												i = i + 1;
											end
										//end
										end
						eight:
										begin
											LCD_E1 = 1'b0;
											init_done = 1'b0;
											if(i == 2000) begin
												init_state=done2;
												i = 0;
											end
											else begin
												init_state=eight;
												i = i + 1;
											end
											//end
										end
						done2:
										begin
											init_state = done2;
											init_done = 1'b1;
										end
		  endcase
   end
	
end

endmodule
