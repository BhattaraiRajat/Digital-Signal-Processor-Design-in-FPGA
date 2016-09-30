`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:23:17 08/20/2015 
// Design Name: 
// Module Name:    Interface 
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
module Interface(			clk,
								reset,
								ps2c,
								ps2d,
								next_key,
								dsply,
								dsply_en,
								lcd_en,
								key_code_final,
								LCD_DB,        
								LCD_E,      
								LCD_RS,      
								LCD_RW
						);

//input output declaration
input 			clk, ps2c, ps2d,reset,dsply_en,lcd_en;
input  [15:0]   dsply;
output next_key;
output [7:0] 	LCD_DB;
output 			LCD_E;
output 			LCD_RS;
output 			LCD_RW;
output [11:0]   key_code_final;
wire [7:0] key_code;
reg [255:0] char_input=256'h30;//input for lcdDriver

lcdDriver LCD (
    .clk(clk), 
    .reset(reset), 
    .LCD_DB(LCD_DB), 
    .LCD_E(LCD_E), 
    .LCD_RS(LCD_RS), 
    .LCD_RW(LCD_RW), 
    .char_input(char_input)
    );

									

wire [7:0] ascii_code1,ascii_code2,ascii_code3,ascii_code4;	
reg rd_key_code;
wire kb_buf_empty;
wire [1:0] count_out;

kb_code makecode (
		.clk(clk), 
		.reset(reset),
		.rx_en(1'b1),
		.count_out(count_out),
		.ps2d(ps2d), 
		.ps2c(ps2c), 
		.rd_key_code(rd_key_code), 
		.key_code(key_code), 
		.kb_buf_empty(kb_buf_empty),
		.next_key(next_key)
	);
	

reg [1:0] state,next_state;
reg [7:0] R1=8'b00000000,R2=8'b00000000;
localparam idle = 2'b00,
				read1 = 2'b01,
				read2 = 2'b10;
				
always @ (posedge clk,posedge reset)
begin
	if (reset)
		state = idle;
	else
		state = next_state;
end

							
always @ (posedge clk)
begin
	next_state = state;
	rd_key_code = 0;
	case(state)
		idle: begin
			if(count_out == 2'b10)
				next_state = read1;
		end
		read1: begin
			if(kb_buf_empty == 0) begin
				rd_key_code = 1;
				R2 = key_code;
			end
			next_state = read2;
		end
		
		read2: begin
			if(kb_buf_empty == 0)  begin
				rd_key_code = 1;
				R1 = key_code;
				end
			next_state = idle;
			end
endcase
end
		
keytoHex encoder1 (
    .key_code(R1), 
    .Hex(key_code_final[7:0])
    );
	 
	 
keytoHex encoder2 (
    .key_code(R2), 
    .Hex({key_code_final[11:8]})
    );

//Hex to ASCII Conversion	 
HextoASCII encoder3 (
    .Hex({4'b0000,dsply[15:12]}), 
    .ascii_code(ascii_code1)
    );

HextoASCII encoder4(
    .Hex({4'b0000,dsply[11:8]}), 
    .ascii_code(ascii_code2)
    );

HextoASCII encoder5 (
    .Hex({4'b0000,dsply[7:4]}), 
    .ascii_code(ascii_code3)
    );

HextoASCII encoder6 (
    .Hex({4'b0000,dsply[3:0]}), 
    .ascii_code(ascii_code4)
    );

	


always @(posedge clk)
begin
//Characters to be printed in the first line of LCD
//By default the white space is being Displayed
case({dsply_en,lcd_en})
2'b00: begin
	char_input[7:0]		=8'b0101_0111;	//W
	char_input[15:8]		=8'b0100_0101;	//E
	char_input[23:16]		=8'b0100_1100;	//L
	char_input[31:24]		=8'b0100_0011;	//C

	char_input[39:32]		=8'b0100_1111;	//O
	char_input[47:40]		=8'b0100_1101;	//M
	char_input[55:48]		=8'b0100_0101; //E
	char_input[63:56]		=8'b1010_0000;

	char_input[71:64]		=8'b0011_1010; //:
	char_input[79:72]		=8'b0010_1001; //)
	char_input[87:80]		=8'b1010_0000;
	char_input[95:88]		=8'b1010_0000;

	char_input[103:96]	=8'b1010_0000;
	char_input[111:104]	=8'b1010_0000;
	char_input[119:112]	=8'b1010_0000;
	char_input[127:120]	=8'b1010_0000;

//Characters to be printed in the second line of the LCD
//By default the white space is being displayed

	char_input[135:128]	=8'b1010_0000;
	char_input[143:136]	=8'b1010_0000;
	char_input[151:144]	=8'b1010_0000;
	char_input[159:152]	=8'b1010_0000;

	char_input[167:160]	=8'b1010_0000;
	char_input[175:168]	=8'b1010_0000;
	char_input[183:176]	=8'b1010_0000;
	char_input[191:184]	=8'b1010_0000;

	char_input[199:192]	=8'b1010_0000;
	char_input[207:200]	=8'b1010_0000;
	char_input[215:208]	=8'b1010_0000;
	char_input[223:216]	=8'b1010_0000;

	char_input[231:224]	=8'b1010_0000;
	char_input[239:232]	=8'b1010_0000;
	char_input[247:240]	=8'b1010_0000;
	char_input[255:248]	=8'b1010_0000;
	end

2'b01: begin
	char_input[7:0]		=8'b0100_1001; //I
	char_input[15:8]		=8'b0100_1110; //N
	char_input[23:16]		=8'b0100_1101; //M
	char_input[31:24]		=8'b0100_0101; //E

	char_input[39:32]		=8'b0100_1101; //M
	char_input[47:40]		=8'b0100_1111; //O
	char_input[55:48]		=8'b0101_0010;	//R
	char_input[63:56]		=8'b0101_1001; //Y

	char_input[71:64]		=ascii_code1;
	char_input[79:72]		=ascii_code2;
	char_input[87:80]		=8'b1010_0000;
	char_input[95:88]		=8'b1010_0000;

	char_input[103:96]	=ascii_code3;
	char_input[111:104]	=ascii_code4;
	char_input[119:112]	=8'b1010_0000;
	char_input[127:120]	=8'b1010_0000;

//Characters to be printed in the second line of the LCD
//By default the white space is being displayed

	char_input[135:128]	=8'b1010_0000;
	char_input[143:136]	=8'b1010_0000;
	char_input[151:144]	=8'b1010_0000;
	char_input[159:152]	=8'b1010_0000;

	char_input[167:160]	=8'b1010_0000;
	char_input[175:168]	=8'b1010_0000;
	char_input[183:176]	=8'b1010_0000;
	char_input[191:184]	=8'b1010_0000;

	char_input[199:192]	=8'b1010_0000;
	char_input[207:200]	=8'b1010_0000;
	char_input[215:208]	=8'b1010_0000;
	char_input[223:216]	=8'b1010_0000;

	char_input[231:224]	=8'b1010_0000;
	char_input[239:232]	=8'b1010_0000;
	char_input[247:240]	=8'b1010_0000;
	char_input[255:248]	=8'b1010_0000;
	end
	
2'b10: begin
	char_input[7:0]		=8'b0100_0001; //A
	char_input[15:8]		=8'b0100_0011; //C
	char_input[23:16]		=8'b0100_0011;	//C
	char_input[31:24]		=8'b1010_0000;

	char_input[39:32]		=8'b1010_0000;
	char_input[47:40]		=8'b1010_0000;
	char_input[55:48]		=8'b1010_0000;
	char_input[63:56]		=8'b1010_0000;

	char_input[71:64]		=8'b1010_0000;
	char_input[79:72]		=8'b1010_0000;
	char_input[87:80]		=8'b1010_0000;
	char_input[95:88]		=8'b1010_0000;

	char_input[103:96]	=8'b1010_0000;
	char_input[111:104]	=ascii_code3;
	char_input[119:112]	=ascii_code4;
	char_input[127:120]	=8'b1010_0000;

//Characters to be printed in the second line of the LCD
//By default the white space is being displayed

	char_input[135:128]	=8'b1010_0000;
	char_input[143:136]	=8'b1010_0000;
	char_input[151:144]	=8'b1010_0000;
	char_input[159:152]	=8'b1010_0000;

	char_input[167:160]	=8'b1010_0000;
	char_input[175:168]	=8'b1010_0000;
	char_input[183:176]	=8'b1010_0000;
	char_input[191:184]	=8'b1010_0000;

	char_input[199:192]	=8'b1010_0000;
	char_input[207:200]	=8'b1010_0000;
	char_input[215:208]	=8'b1010_0000;
	char_input[223:216]	=8'b1010_0000;

	char_input[231:224]	=8'b1010_0000;
	char_input[239:232]	=8'b1010_0000;
	char_input[247:240]	=8'b1010_0000;
	char_input[255:248]	=8'b1010_0000;
	end
	
2'b11: begin
	char_input[7:0]		=8'b0100_1100; //L
	char_input[15:8]		=8'b0100_1111; //O
	char_input[23:16]		=8'b0100_0001; //A
	char_input[31:24]		=8'b0100_0100; //D

	char_input[39:32]		=8'b0100_1001; //I
	char_input[47:40]		=8'b0100_1110; //N
	char_input[55:48]		=8'b0100_0111; //G
	char_input[63:56]		=8'b1010_0000;

	char_input[71:64]		=8'b0010_1110; //.
	char_input[79:72]		=8'b0010_1110;	//.
	char_input[87:80]		=8'b0010_1110; //.
	char_input[95:88]		=8'b1010_0000;

	char_input[103:96]	=8'b1010_0000;
	char_input[111:104]	=8'b1010_0000;
	char_input[119:112]	=8'b1010_0000;
	char_input[127:120]	=8'b1010_0000;

//Characters to be printed in the second line of the LCD
//By default the white space is being displayed

	char_input[135:128]	=8'b1010_0000;
	char_input[143:136]	=8'b1010_0000;
	char_input[151:144]	=8'b1010_0000;
	char_input[159:152]	=8'b1010_0000;

	char_input[167:160]	=8'b1010_0000;
	char_input[175:168]	=8'b1010_0000;
	char_input[183:176]	=8'b1010_0000;
	char_input[191:184]	=8'b1010_0000;

	char_input[199:192]	=8'b1010_0000;
	char_input[207:200]	=8'b1010_0000;
	char_input[215:208]	=8'b1010_0000;
	char_input[223:216]	=8'b1010_0000;

	char_input[231:224]	=8'b1010_0000;
	char_input[239:232]	=8'b1010_0000;
	char_input[247:240]	=8'b1010_0000;
	char_input[255:248]	=8'b1010_0000;
	end
	endcase
	end
endmodule


