`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:26:06 08/26/2015 
// Design Name: 
// Module Name:    Processor 
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
module Processor(clk,
                 reset,
					  start,
					  accumulator,
					  mem_out,
					  program_counter,
					  data_ready
					  
    );

input clk,
      reset,start;
input [11:0] mem_out;
output reg data_ready;
//output reg [7:0] to_lcd=8'b0;		
		
//registers
output reg [7:0] accumulator=8'b00000000;

output reg [7:0] program_counter=8'b00000000;
reg [7:0] data_register=8'b00000000;

reg [11:0] instruction_register;
reg [3:0] opcode;

			 
//wires
wire [11:0] mem_out;	
wire [7:0] result;
				
				
				
ALU_Unit ALU(
    .In1(accumulator), 
    .In2(data_register), 
    .Opcode(opcode),
    .Result(result), 
    .Cout(Cout)
    );



parameter [2:0] idle=0,
                fetch=1,
                decode=2,
                execute_alu=3,
					 halt=4;
					 
reg [2:0] presentstate=idle,
          nextstate=idle;

always@(posedge clk)
begin
if(reset)
begin
presentstate=idle;
end
else
presentstate=nextstate;
end

always@(posedge clk)
begin
case(presentstate)

idle: begin
if (start) begin
accumulator=0;
program_counter=0;
data_ready=1'b0;
nextstate=fetch;
end
end

fetch: begin
     data_ready=1'b0;
	  instruction_register=mem_out;
	  program_counter=program_counter+1;
	  nextstate=decode;
end

decode:begin
data_ready=1'b0;
data_register=instruction_register[7:0];
opcode=instruction_register[11:8];
if(instruction_register[11:8]==4'b1111)
nextstate=halt;
else
nextstate=execute_alu;
end

execute_alu: begin
data_ready=1'b0;
accumulator=result;
nextstate=fetch;       
end

halt:begin
data_ready=1'b1;
end
//to_lcd=accumulator;

endcase

end
	
endmodule
