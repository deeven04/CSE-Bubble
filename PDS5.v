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

module Instruction_decode (clock,PC,Opcode);
input clock;
output reg [4:0] PC=5'b00000;
output reg[5:0] Opcode;
reg reset=0;
reg write_enable=0;
reg mode=1;
wire[31:0] Instruction;
reg[31:0] data_in=0;

Veda t (clock , reset , write_enable , PC , data_in , mode , Instruction);
always @(negedge clock) begin
    PC=PC+1;
end
always @(posedge clock) begin
    Opcode=Instruction[31:26];
end

endmodule

module tb ();

reg clock;
wire[4:0] PC;
wire [5:0] Opcode;

Instruction_decode uut (clock , PC ,Opcode);
initial begin
clock<=1;
forever #5 clock<=~clock;
end
always @(Opcode) begin
       case(Opcode)
        5'b00000: $display("add");
        5'b00001: $display("sub");
        5'b00010: $display("addu");
        5'b00011: $display("subu");
        5'b00100: $display("addi");
        5'b00101: $display("addiu");
        5'b00110: $display("and");
        5'b00111: $display("or");
        5'b01000: $display("andi");
        5'b01001: $display("ori");
        5'b01010: $display("sll");
        5'b01011: $display("srl");
        5'b01100: $display("lw");
        5'b01101: $display("sw");
        5'b01110: $display("beq");
        5'b01111: $display("bne");
        5'b10000: $display("bgt"); 
        5'b10001: $display("bgte");
        5'b10010: $display("ble");
        5'b10011: $display("bleq");
        5'b10100: $display("j");
        5'b10101: $display("jr");
        5'b10110: $display("jal");
        5'b10111: $display("slt");
        5'b11000: $display("slti");
        default : $display("None of these");
    endcase
end
initial begin
    // $dumpfile("test.vcd");
    // $dumpvars(0,tb);
    // $monitor("%d %d %d %d",$time,clock,PC,Opcode);
    #250 $finish;
end
endmodule