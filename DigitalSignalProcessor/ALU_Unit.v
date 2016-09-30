`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:24:35 08/23/2015 
// Design Name: 
// Module Name:    ALU_Unit 
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
module ALU_Unit(In1,
                In2,
					 Opcode,
					 Result,
					 Cout
    );
	 
input [7:0] In1,
            In2;
				
input [3:0] Opcode;

output [7:0] Result;
output Cout;

//wires

wire Cout1,
     Cout2;
	  
wire [7:0] wa0,
           wa1,
			  wa2,
			  wa3,
			  wa4,
			  wa5,
			  wa6,
			  wa7,
			  wa8,
			  wa9,
			  wa10,
			  wa11,
			  wa12,
			  wa13;
			  
wire [7:0] wb0,
           wb1,
			  wb2,
			  wb3,
			  wb4,
			  wb5,
			  wb6,
			  wb7,
			  wb8,
			  wb9,
			  wb10,
			  wb11,
			  wb12,
			  wb13;
			  
wire [7:0] r0,
           r1,
			  r2,
			  r3,
			  r4,
			  r5,
			  r6,
			  r7,
			  r8,
			  r9,
			  r11,
			  r12,
			  r13;
			  
wire [15:0] r10; 
			  			  
			 
//Demux instances			  
DeMux1to16 DeMux1 (
    .In1(In1), 
    .Sel(Opcode), 
    .Out0(wa0), 
    .Out1(wa1), 
    .Out2(wa2), 
    .Out3(wa3), 
    .Out4(wa4), 
    .Out5(wa5), 
    .Out6(wa6), 
    .Out7(wa7), 
    .Out8(wa8), 
    .Out9(wa9), 
    .Out10(wa10), 
    .Out11(wa11), 
    .Out12(wa12), 
    .Out13(wa13)
    );
	 
DeMux1to16 DeMux2 (
    .In1(In2), 
    .Sel(Opcode), 
    .Out0(wb0), 
    .Out1(wb1), 
    .Out2(wb2), 
    .Out3(wb3), 
    .Out4(wb4), 
    .Out5(wb5), 
    .Out6(wb6), 
    .Out7(wb7), 
    .Out8(wb8), 
    .Out9(wb9), 
    .Out10(wb10), 
    .Out11(wb11), 
    .Out12(wb12), 
    .Out13(wb13)
    );

//ALU functional unit instances

AND_Gate  AND_Gate(
    .In1(wa0), 
    .In2(wb0), 
    .Out(r0)
    );

OR_Gate OR (
    .In1(wa1), 
    .In2(wb1), 
    .Out(r1)
    );

NAND_Gate NAND (
    .In1(wa2), 
    .In2(wb2), 
    .Out(r2)
    );

NOR_Gate NOR (
    .In1(wa3), 
    .In2(wb3), 
    .Out(r3)
    );

XOR_Gate XOR (
    .In1(wa4), 
    .In2(wb4), 
    .Out(r4)
    );

Complement ComplementAC (
    .In1(wa5), 
    .Out(r5)
    );

Increment IncrementAC (
    .In1(wa6), 
    .Out(r6)
    );

Decrement DecrementAC (
    .In1(wa7), 
    .Out(r7)
    );

CLA8bit ADDER (
    .A(wa8), 
    .B(wb8), 
    .Cin(1'b0), 
    .Sum(r8), 
    .Cout(Cout1)
    );

Subtractor8bit SUBTRACTOR (
    .A(wa9), 
    .B(wb9), 
    .Diff(r9), 
    .Cout(Cout2)
    );

Multiplier8bit MULTIPLIER (
    .In1(wa10), 
    .In2(wb10), 
    .Out(r10)
    );

Right_Shift SHR (
    .In1(wa11), 
    .Out(r11)
    );

Left_Shift SHL (
    .In1(wa12), 
    .Out(r12)
    );

Arithmetic_Right_Shift ASR(
    .In1(wa13), 
    .Out(r13)
    );

//MUX Instantiation

Mux16to1 MUX (
    .Sel(Opcode), 
    .In0(r0), 
    .In1(r1), 
    .In2(r2), 
    .In3(r3), 
    .In4(r4), 
    .In5(r5), 
    .In6(r6), 
    .In7(r7), 
    .In8(r8), 
    .In9(r9), 
    .In10(r10[7:0]), 
    .In11(r11), 
    .In12(r12), 
    .In13(r13), 
    .Out(Result)
    );



endmodule
