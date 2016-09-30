`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:40:56 09/01/2015 
// Design Name: 
// Module Name:    controlUnit 
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
module controlUnit(	input wire clk,
							reset,
							ps2c,
							ps2d,
							next,
							load_key,
							execute_key,
							output wire [7:0] LCD_DB,        
							output wire LCD_E,      
							LCD_RS,      
							LCD_RW
						);
						
reg dsply_en,lcd_en;
reg [15:0] dsply;
wire [11:0] key_code;
wire next_key;
//wire kb_buf_empty;

						
Interface IO_module (
    .clk(clk), 
    .reset(reset), 
    .ps2c(ps2c), 
    .ps2d(ps2d),
	 .next_key(next_key),
    .dsply(dsply), 
    .dsply_en(dsply_en), 
    .lcd_en(lcd_en),  
    .key_code_final(key_code), 
    .LCD_DB(LCD_DB), 
    .LCD_E(LCD_E), 
    .LCD_RS(LCD_RS), 
    .LCD_RW(LCD_RW)
    );	
	
	
reg wea;
wire [7:0] addra;
reg [7:0] addra_reg;
wire [11:0] douta;
reg [11:0] dina;

RAM MEMORY (
  .clka(clk), // input clka
  .wea(wea), // input [0 : 0] wea
  .addra(addra), // input [7 : 0] addra
  .dina(dina), // input [11 : 0] dina
  .douta(douta) // output [11 : 0] douta
);

reg start;
wire data_ready;
reg [11:0] mem_out;
wire [7:0] program_counter;

Processor ALU_logic (
    .clk(clk), 
    .reset(reset), 
    .start(start), 
    .mem_out(mem_out), 
    .program_counter(program_counter), 
    .accumulator(accumulator), 
    .data_ready(data_ready)
    );
	 
localparam [1:0] idle = 2'b00,
						load = 2'b01,
						temp = 2'b10,
						execute = 2'b11;
						
reg [1:0] state,state_next;

always @ (posedge clk,posedge reset)
begin
	if (reset) begin
		state = idle;
		end
	else
		state = state_next;
end

always @ (posedge clk)
begin
	state_next = state;
	lcd_en = 1'b0;
	dsply_en = 1'b0;
	wea = 1'b0;
	dina = 8'b00000000;
	start = 1'b0;
	case(state)
		idle: begin
		addra_reg = 8'b00000000;
			if(load_key)
				state_next = load;
			end
		
		load: begin	
			dina=key_code[11:0];
			wea = 1'b1;
			lcd_en = 1'b1;
			dsply = {addra_reg,douta[11:8],douta[3:0]} ;
			if(next_key) 
				addra_reg = addra_reg + 1;
			if(next)
				state_next = temp;
			end
			

		temp: begin
			lcd_en = 1'b1;
			dsply_en = 1'b1;
			if(execute_key)
				state_next = execute;
			end
		
		execute: begin	
			start = 1'b1;
			addra_reg = program_counter;
					mem_out = douta;
			if (data_ready) begin 
				dsply_en = 1'b1;
				dsply = {accumulator};
			end
			else begin
				lcd_en = 1'b1;
				dsply_en = 1'b1;
				end
			end
		
		/*lcd_en = 1'b1;
			dsply = {addra_reg,douta[11:8],douta[3:0]};
			if(next_key)
			addra_reg = addra_reg + 1;
			end*/
			endcase
			end
assign addra = addra_reg;
endmodule
