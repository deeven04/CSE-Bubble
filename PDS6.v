`timescale 1ns/1ps

// Ogirala Deeven Kumar       - 210681
// Sajja Eswara Sai Raghava   - 210904

module Veda (reset , write_enable , PC , data_in , mode , data_out);

input reset,write_enable,mode;
input[4:0] PC;
input[31:0] data_in;
output reg [31:0] data_out;
reg[31:0] memory [31:0];
integer i;

initial begin
    memory[3] = 32'b00000000000111111111000000000000;
    memory[4] = 32'b00000000000111100000000000000000;
    memory[5] = 32'b00000000000111111110100000000000;
    memory[29] = 6;
    memory[30] = 5;
    memory[31] = 4;
  
end

always@(*) begin
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

module alu (clk,PC,a,b,c);
input wire clk;
reg  reset=0;
reg write_enable=1;
reg mode=1;
reg [4:0] addr=0;
reg [31:0] data_in;
wire [31:0] Instruction;
output reg [31:0] a,b,c;
output reg [4:0] PC=0;
reg [4:0] rd,rs,rt;
Veda mem (reset , write_enable , addr , data_in , mode , Instruction);

reg[5:0] opcode;
reg[5:0] func;
reg[15:0] addr_const;
reg [4:0] shamt;
reg[25:0]jump_inst;

    
always @(posedge clk) begin
        opcode=Instruction[31:26];
        func = Instruction[5:0];
        rd = Instruction[25:21];
        rs = Instruction[20:16];
        rt = Instruction[15:11];
        addr_const =  Instruction[15:0];
        shamt = Instruction[10:6];
        jump_inst = Instruction[25:0];
       case(opcode)
        0:begin  
            #1 mode=1;
            #1 addr =rs;
            #1 a=Instruction;
            #1 addr =rt;
            #1 b=Instruction;
            #1 addr=PC;
        end 
        1:begin
            #1 mode=1;
            #1 addr =rs;
            #1 a=Instruction;
            #1 addr =rt;
            #1 b=Instruction;
            #1 addr=PC;
         end 
        2:begin 
            #1 mode=1;
            #1 addr =rs;
            #1 a=Instruction;
            #1 addr =rt;
            #1 b=Instruction;
            #1 addr=PC;
        end 
        3:begin  
            #1 mode=1;
            #1 addr =rs;
            #1 a=Instruction;
            #1 addr =rt;
            #1 b=Instruction;
            #1 addr=PC;
            end 
        4:begin  mode=1;
            #1 addr =rs;
            #1 a=Instruction;
            #1 addr =rt;
            #1 b=Instruction;
            #1 addr=PC;
            end 
        5:begin  mode=1;
            #1 addr =rs;
            #1 a=Instruction;
            #1 addr =rt;
            #1 b=Instruction;
            #1 addr=PC;
            end 
        6:begin  mode=1;
            #1 addr =rs;
            #1 a=Instruction;
            #1 addr =rt;
            #1 b=Instruction;
            #1 addr=PC;
            end 
        7:begin  mode=1;
            #1 addr =rs;
            #1 a=Instruction;
            #1 addr =rt;
            #1 b=Instruction;
            #1 addr=PC;
            end 
        8:begin  mode=1;
            #1 addr =rs;
            #1 a=Instruction;
            #1 addr =rt;
            #1 b=Instruction;
            #1 addr=PC;
            end 
        9:begin  mode=1;
            #1 addr =rs;
            #1 a=Instruction;
            #1 addr =rt;
            #1 b=Instruction;
            #1 addr=PC;
            end 
        10:begin mode=1;
            #1 addr =rs;
            #1 a=Instruction;
            #1 addr =rt;
            #1 b=Instruction;
            #1 addr=PC;
             end 
        11:begin mode=1;
            #1 addr =rs;
            #1 a=Instruction;
            #1 addr =rt;
            #1 b=Instruction;
            #1 addr=PC;
             end
        default : begin end
    endcase
end

always @(negedge clk) begin
       addr=PC;
       case(opcode)
        0:begin  
            c=$signed(a)+$signed(b);
            #1 addr=rd;
            #1 data_in=c;
            #1 mode=0;
            #1 mode=1;
            #1 addr=PC;
        end 
        1:begin
            c=$signed(a)-$signed(b);
            #1 addr=rd;
            #1 data_in=c;
            #1 mode=0;
            #1 mode=1;
            #1 addr=PC;
         end 
        2:begin 
            c=a+b;
            #1 addr=rd;
            #1 data_in=c;
            #1 mode=0;
            #1 mode=1;
            #1 addr=PC;
        end 
        3:begin  mode=1;
            c=a-b;
            #1 addr=rd;
            #1 data_in=c;
            #1 mode=0;
            #1 mode=1;
            0
            #1 addr=PC;
            end 
        4:begin  mode=1;
            c=a+addr_const;
            #1 addr=rd;
            #1 data_in=c;
            #1 mode=0;
            #1 mode=1;
            #1 addr=PC;
            end 
        5:begin  mode=1;
            c=$signed(a)+$signed(addr_const);
            #1 addr=rd;
            #1 data_in=c;
            #1 mode=0;
            #1 mode=1;
            #1 addr=PC;
            end 
        6:begin  mode=1;
            c=a&b;
            #1 addr=rd;
            #1 data_in=c;
            #1 mode=0;
            #1 mode=1;
            #1 addr=PC;
            end 
        7:begin  mode=1;
            c=a|b;
            #1 addr=rd;
            #1 data_in=c;
            #1 mode=0;
            #1 mode=1;
            #1 addr=PC;
            end 
        8:begin  mode=1;
            c= a & addr_const;
            #1 addr=rd;
            #1 data_in=c;
            #1 mode=0;
            #1 mode=1;
            #1 addr=PC;
            end 
        9:begin  mode=1;
            c= a | addr_const;
            #1 addr=rd;
            #1 data_in=c;
            #1 mode=0;
            #1 mode=1;
            #1 addr=PC;
            end 
        10:begin mode=1;
            c= a << shamt;
            #1 addr=rd;
            #1 data_in=c;
            #1 mode=0;
            #1 mode=1;
            #1 addr=PC;
             end 
        11:begin mode=1;
            c= a >> shamt;
            #1 addr=rd;
            #1 data_in=c;
            #1 mode=0;
            #1 mode=1;
            #1 addr=PC;
             end
    endcase
    PC=PC+1;
end

endmodule

module tb ();

reg clock;
wire[4:0] PC;
wire [31:0] a,b,c;
wire [4:0] rd,rs,rt;

alu uut (clock , PC ,a,b,c);
initial begin
clock<=1;
forever #10 clock<=~clock;
end

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0,tb);
    $monitor("%d %d %d ",$time,clock,PC,a,b,c);
    #200 $finish;
end

endmodule