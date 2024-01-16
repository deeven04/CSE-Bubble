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
    memory[7] = 32'b01010000000000000000000000000011;
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

module Alu (opcode,a,b,c);

input wire[5:0] opcode;
input wire[31:0] a,b;
output reg [31:0] c;    
always @(*) begin
    case(opcode)
        0: c=$signed(a)+$signed(b);
        1: c=$signed(a)-$signed(b);
        2: c=a+b;
        3: c=a-b;
        4: c=a+b; 
        5: c=$signed(a)+$signed(b); 
        6: c=a&b;  
        7: c=a|b;
        8: c= a & b;
        9: c= a | b;
        10: c= a << b;            
        11: c= a >> b;      
        default :  ;
    endcase
end

endmodule

module control (clk,PC,a,b,c);

input wire clk;
reg  reset=0;
reg write_enable=1;
reg mode=1;
reg [4:0] addr=0;
reg [31:0] data_in;
wire [31:0] data_out;
output reg [31:0] a,b;
output wire[31:0] c;
output reg [4:0] PC=0;
reg [4:0] rd,rs,rt;
reg[5:0] opcode;
reg[5:0] func;
reg[15:0] addr_const;
reg [4:0] shamt;
reg[25:0]jump_inst;


Veda mem (reset , write_enable , addr , data_in , mode , data_out);
Alu  al(opcode,a,b,c);
    
always @(posedge clk) begin
        addr=PC;                      // reading the Instructions
        opcode=data_out[31:26];
        func = data_out[5:0];
        rd = data_out[25:21];
        rs = data_out[20:16];
        rt = data_out[15:11];
        addr_const =  data_out[15:0];
        shamt = data_out[10:6];
        jump_inst = data_out[25:0];

       case(opcode)
        0:begin  
            #1 addr =rs;        // reading the data
            #1 a=data_out;
            #1 addr =rt;
            #1 b=data_out;   
            #1 addr=rd;         // executing 
            #1 data_in=c;
            #1 mode=0;          // writing the data back
            #1 mode=1;
            #1 addr=PC;
        end 
        1:begin
            #1 addr =rs;
            #1 a=data_out;
            #1 addr =rt;
            #1 b=data_out;
            #1 addr=rd;
            #1 data_in=c;
            #1 mode=0;
            #1 mode=1;
            #1 addr=PC;
         end 
        2:begin
            #1 addr =rs;
            #1 a=data_out;
            #1 addr =rt;
            #1 b=data_out;
            #1 addr=rd;
            #1 data_in=c;
            #1 mode=0;
            #1 mode=1;
            #1 addr=PC;
        end 
        3:begin 
            #1 addr =rs;
            #1 a=data_out;
            #1 addr =rt;
            #1 b=data_out;
            #1 addr=rd;
            #1 data_in=c;
            #1 mode=0;
            #1 mode=1;
            #1 addr=PC;
            end 
        4:begin
            #1 addr =rs;
            #1 a=data_out;
            #1 addr =rt;
            #1 b=data_out;
            #1 addr=rd;
            #1 data_in=c;
            #1 mode=0;
            #1 mode=1;
            #1 addr=PC;
            end 
        5:begin
            #1 addr =rs;
            #1 a=data_out;
            #1 addr =rt;
            #1 b=data_out;
            #1 addr=rd;
            #1 data_in=c;
            #1 mode=0;
            #1 mode=1;
            #1 addr=PC;
            end 
        6:begin
            #1 addr =rs;
            #1 a=data_out;
            #1 addr =rt;
            #1 b=data_out;
            #1 addr=rd;
            #1 data_in=c;
            #1 mode=0;
            #1 mode=1;
            #1 addr=PC;
            end 
        7:begin
            #1 addr =rs;
            #1 a=data_out;
            #1 addr =rt;
            #1 b=data_out;
            #1 addr=rd;
            #1 data_in=c;
            #1 mode=0;
            #1 mode=1;
            #1 addr=PC;
            end 
        8:begin
            #1 addr =rs;
            #1 a=data_out;
            #1 addr =rt;
            #1 b=data_out;
            #1 addr=rd;
            #1 data_in=c;
            #1 mode=0;
            #1 mode=1;
            #1 addr=PC;
            end 
        9:begin
            #1 addr =rs;
            #1 a=data_out;
            #1 addr =rt;
            #1 b=data_out;
            #1 addr=rd;
            #1 data_in=c;
            #1 mode=0;
            #1 mode=1;
            #1 addr=PC;
            end 
        10:begin
            #1 addr =rs;
            #1 a=data_out;
            #1 addr =rt;
            #1 b=data_out;
            #1 addr=rd;
            #1 data_in=c;
            #1 mode=0;
            #1 mode=1;
            #1 addr=PC;
             end 
        11:begin
            #1 addr =rs;
            #1 a=data_out;
            #1 addr =rt;
            #1 b=data_out;
            #1 addr=rd;
            #1 data_in=c;
            #1 mode=0;
            #1 mode=1;
            #1 addr=PC;
             end
         12:begin 
            #1 addr =rs;
            #1 a=data_out;
            #1 addr =rt;
            #1 b=data_out;
            #1 addr=PC;
        end 
        13:begin 
            #1 addr =rs;
            #1 a=data_out;
            #1 addr =rt;
            #1 b=data_out;
            #1 addr=PC;
        end 
        14:begin
            #1 addr =rs;
            #1 a=data_out;
            #1 addr =rt;
            #1 b=data_out;
            #1 addr=PC;
            if(a==b) PC=PC+addr_const;
         end 
        15:begin 
            #1 addr =rs;
            #1 a=data_out;
            #1 addr =rt;
            #1 b=data_out;
            #1 addr=PC;
            if(a!=b) PC=PC+addr_const;
        end 
        16:begin  
            #1 addr =rs;
            #1 a=data_out;
            #1 addr =rt;
            #1 b=data_out;
            #1 addr=PC;
            if(a>b) PC=PC+addr_const;
            end 
        17:begin  
            #1 addr =rs;
            #1 a=data_out;
            #1 addr =rt;
            #1 b=data_out;
            #1 addr=PC;
            if(a>=b) PC=PC+addr_const;
            end 
        18:begin  
            #1 addr =rs;
            #1 a=data_out;
            #1 addr =rt;
            #1 b=data_out;
            #1 addr=PC;
            if(a<b) PC=PC+addr_const;
            end 
        19:begin  
            #1 addr =rs;
            #1 a=data_out;
            #1 addr =rt;
            #1 b=data_out;
            #1 addr=PC;
            if(a<=b) PC=PC+addr_const;
            end 
        20:begin  
            #1 PC = jump_inst-1;
            end 
        21:begin  
            PC = jump_inst;
            end 
        22:begin  
            #1 addr =rs;
            #1 a=data_out;
            #1 addr =rt;
            #1 b=data_out;
            #1 addr=PC;
            end 
        23:begin
            #1 addr =rs;
            #1 a=data_out;
            #1 addr =rt;
            #1 b=data_out;
            #1 addr=PC;
            end 
        24:begin 
            #1 addr =rs;
            #1 a=data_out;
            #1 addr =rt;
            #1 b=data_out;
            #1 addr=PC;
            end
        default : ;
    endcase
    PC=PC+1;
end

endmodule


module tb ();

reg clock;
wire[4:0] PC;
wire [31:0] a,b,c;
wire [4:0] rd,rs,rt;

control uut (clock,PC,a,b,c);
initial begin
clock<=1;
forever #5 clock<=~clock;
end

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0,tb);
    $monitor("%d %d %d ",$time,clock,PC,a,b,c);
    #250 $finish;
end
endmodule