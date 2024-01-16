`timescale 1ns/1ps

// Ogirala Deeven Kumar       - 210681
// Sajja Eswara Sai Raghava   - 210904


module Veda (clock , reset , write_enable , PC , data_in , mode , data_out);

input clock,reset,write_enable,mode;
input[4:0] PC;
input[31:0] data_in;
output reg [31:0] data_out;

reg[31:0] memory [31:0];
integer i;

initial begin

    memory[0] = 32'b00000000001000100000000000000000;
    memory[1] = 32'b00000100010000010000000000000000;
    memory[2] = 32'b00001000001000100000000000000000;
    memory[3] = 32'b00001100010000010000000000000000;
    memory[4] = 32'b00010000001000000000001111101000;
    memory[5] = 32'b00010100001000000000001111101000;
    memory[6] = 32'b00011000001000100000000000000000;
    memory[7] = 32'b00011100001000100000000000000000;
    memory[8] = 32'b00100000001000000000001111101000;
    memory[9] = 32'b00100100001000000000001111101000;
    memory[10] = 32'b00101000000000010000001010000000;
    memory[11] = 32'b00101100000000010000001010000000;
    memory[12] = 32'b00110000001000000000000000001010;
    memory[13] = 32'b00110100001000000000000000001010;
    memory[14] = 32'b00111000000000010000000000001010;
    memory[15] = 32'b00111100000000010000000000001010;
    memory[16] = 32'b01000000001000100000000000001010;
    memory[17] = 32'b01000100001000100000000000001010;
    memory[18] = 32'b01001000001000100000000000001010;
    memory[19] = 32'b01001100001000100000000000001010;
    memory[20] = 32'b01010000000000000000000000000010;
    memory[21] = 32'b01010100000000000000000000000000;
    memory[22] = 32'b01011000000000000000000000001010;
    memory[23] = 32'b01011100001000100000000000000000;
    memory[24] = 32'b01100000010000010000000001100100;
    
end

always@(posedge clock) begin
    if (reset) begin
        for(i=0 ; i<32 ; i=i+1) begin
            memory[i] <=0;
        end
    end
    else if (mode==0) begin
        if (write_enable) begin
            memory[PC]<=data_in;
            data_out<=memory[PC];
        end
        else data_out<=data_in;
    end
    else begin
        data_out <=memory[PC];
    end
end

endmodule

module Instruction_fetch (clock,PC,Instruction);
input clock;
output reg [4:0] PC=5'b00000;
output wire[31:0] Instruction;
reg reset=0;
reg write_enable=0;
reg mode=1;
reg[31:0] data_in=0;

Veda t (clock , reset , write_enable , PC , data_in , mode , Instruction);
always @(negedge clock) begin
    PC=PC+1;
end

endmodule

module tb ();

reg clock;
wire[4:0] PC;
wire [31:0] Instruction;

Instruction_fetch uut (clock , PC ,Instruction);
initial begin
clock<=1;
forever #5 clock<=~clock;
end

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0,tb);
    $monitor("%d %d %b",$time,clock,Instruction);
    #200 $finish;
end

endmodule