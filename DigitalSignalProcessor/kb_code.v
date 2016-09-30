`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:43:03 08/11/2015 
// Design Name: 
// Module Name:    kb_code 
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
module kb_code
		#(parameter W_SIZE = 2)		
		( input wire clk,reset,rx_en,
		input wire ps2d, ps2c, rd_key_code,
		output wire [7:0] key_code,
		output wire kb_buf_empty,
		output wire [1:0] count_out,
		output reg next_key
		);
localparam BRK = 8'hf0; //break code
localparam
	wait_brk = 1'b0,
	get_code = 1'b1;
reg state_reg, state_next;
wire [7:0] scan_out;
reg got_code_tick;
wire scan_done_tick;
reg [1:0] count_out_reg= 2'b00;
//instantiation

ps2_rx port_reciever (
		.clk(clk), 
		.reset(reset), 
		.ps2d(ps2d), 
		.ps2c(ps2c), 
		.rx_en(rx_en), 
		.rx_done_tick(scan_done_tick), 
		.dout(scan_out)
	);
	
fifo #(.B(8), .W(W_SIZE)) FIFO (
		.clk(clk), 
		.reset(reset), 
		.rd(rd_key_code), 
		.wr(got_code_tick), 
		.w_data(scan_out), 
		.empty(kb_buf_empty), 
		.full(), 
		.r_data(key_code)
	);
	
//FSM to get scan code after f0 is recieved
always @ (posedge clk, posedge reset)
begin
	if (reset)
		state_reg <= wait_brk;
	else
		state_reg <= state_next;
end
//next state logic

always @ (posedge clk)
begin
	got_code_tick = 1'b0;
	state_next = state_reg;
	next_key = 1'b0;
	case(state_reg)
		wait_brk: begin
			if (count_out_reg == 2'b10)
						count_out_reg = 2'b00;
			if (scan_done_tick == 1'b1 && scan_out == BRK)
				state_next = get_code;
				end
		get_code: begin
			if(scan_done_tick)
				begin
				if(scan_out == 8'h31)
					next_key = 1'b1;
				else begin
					got_code_tick = 1'b1;
					count_out_reg = count_out_reg + 1;
					end
					state_next = wait_brk;
				end
				end
	endcase
end
assign count_out = count_out_reg;
endmodule
