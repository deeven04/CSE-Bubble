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
    memory[0] = 32'b010000_00001_00000_0000000000001101;//bgt 1,0,print
    memory[1] = 32'b001100_01000_00101_0000000000011111;//load s0
    memory[2] = 32'b000100_00001_00001_0000000000000001;//addi t1
    memory[3] = 32'b001100_00010_00111_0000000000000000;//load t2
    memory[4] = 32'b001110_00010_00000_0000000000000000;//beq 2,0,outerloop
    memory[5] = 32'b001100_00011_01000_0000000000000000;//load 3
    memory[6] = 32'b001100_00100_01000_0000000000000001;//load 4
    memory[7] = 32'b010000_00100_00011_0000000000001010;//bgt 4,3,continue
    memory[8] = 32'b001101_00100_01000_0000000000000000;//store 3
    memory[9] = 32'b001101_00011_01000_0000000000000001;//store 4
    memory[10] = 32'b000100_00010_00010_0000000000000001;//addi t2
    memory[11] = 32'b000100_01000_01000_0000000000000001;//addi s0
    memory[12] = 32'b010100_00000000000000000000000100;  // j innerloop
    memory[13] = 32'b111111_00000000000000000000000000; // print the array and finish program
    memory[19] = 1;
    memory[20] = 10; // data begin
    memory[21] = 4;
    memory[22] = 1;
    memory[23] = 3;
    memory[24] = 9;
    memory[25] = 7;
    memory[26] = 8;
    memory[27] = 0;
    memory[28] = 2;
    memory[29] = 6;
    memory[30] = 5;
    memory[31] = 21; // data starting address
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

module control (clk);

input wire clk;
reg  reset=0;
reg write_enable=1;
reg mode=1;
reg [4:0] addr=0;
reg [31:0] data_in;
wire [31:0] data_out;

reg [31:0] a,b;
wire[31:0] c;
reg[31:0] temp[7:0];
reg [4:0] PC=0;
reg [4:0] rd,rs,rt;
reg[5:0] opcode;
reg[5:0] func;
reg[15:0] addr_const;
reg [4:0] shamt;
reg[25:0]jump_inst;
integer i=0;

Veda mem (reset , write_enable , addr , data_in , mode , data_out);
Alu  al(opcode,a,b,c);

initial begin
temp[0]=10; // size of array
temp[1]=1;
temp[6]=21; // start of address
temp[7]=19;
temp[5]=0;
end 

always @(posedge clk) begin
        addr=PC;
        #1 ;                   // reading the Instructions
        opcode=data_out[31:26];
        func = data_out[5:0];
        rd = data_out[25:21];
        rs = data_out[20:16];
        rt = data_out[15:11];
        addr_const =  data_out[15:0];
        shamt = data_out[10:6];
        jump_inst = data_out[25:0];
        //$display("%d %d %d %d %d %d %d %d %d",PC,rs,rd,opcode,temp[0],temp[1],temp[2],temp[3],temp[4]);
       case(opcode)
        0:begin  
            #1 a=temp[rs];
            #1 b=temp[rt];
            #1 temp[rd]=c;
            end
        1:begin
            #1 a=temp[rs];
            #1 b=temp[rt];
            #1 temp[rd]=c;
            end
        2:begin
            #1 a=temp[rs];
            #1 b=temp[rt];
            #1 temp[rd]=c;
        end 
        3:begin 
            #1 a=temp[rs];
            #1 b=temp[rt];
            #1 temp[rd]=c;
            end 
        4:begin
            #1 a=temp[rs];
            #1 b=addr_const;
            #1 temp[rd]=c;
            end 
        5:begin
            #1 a=temp[rs];
            #1 b=temp[rt];
            #1 temp[rd]=c;
            end 
        6:begin
            #1 a=temp[rs];
            #1 b=temp[rt];
            #1 temp[rd]=c;
            end 
        7:begin
            #1 a=temp[rs];
            #1 b=temp[rt];
            #1 temp[rd]=c;
            end 
        8:begin
            #1 a=temp[rs];
            #1 b=temp[rt];
            #1 temp[rd]=c;
            end 
        9:begin
            #1 a=temp[rs];
            #1 b=temp[rt];
            #1 temp[rd]=c;
            end 
        10:begin
            #1 a=temp[rs];
            #1 b=temp[rt];
            #1 temp[rd]=c;
             end 
        11:begin
            #1 a=temp[rs];
            #1 b=temp[rt];
            #1 temp[rd]=c;
            end
        12:begin 
            #1 b=addr_const;
            #1 addr = temp[rs] + b;
            #1 a=data_out;
            #1 temp[rd]=a;
        end 
        13:begin 
            #1 addr =temp[rs]+addr_const;
            #1 data_in=temp[rd];
            #1 mode = 0;
            #1 mode = 1;
        end 
        14:begin
            #1 a=temp[rd];
            #1 b=temp[rs];
            if(a==b) PC=addr_const-1;
         end 
        15:begin 
            #1 a=temp[rd];
            #1 b=temp[rs];
            if(a!=b) PC=addr_const-1;
        end 
        16:begin  
            #1 a=temp[rd];
            #1 b=temp[rs];
            if(a>b) PC=addr_const-1;
            else PC=PC;
            end 
        17:begin  
            #1 a=temp[rd];
            #1 b=temp[rs];
            if(a>=b) PC=addr_const-1;
            end 
        18:begin  
            #1 a=temp[rd];
            #1 b=temp[rs];
            if(a<b) PC=addr_const-1;
            end 
        19:begin  
            #1 a=temp[rd];
            #1 b=temp[rs];
            if(a<=b) PC=addr_const-1;
            end 
        20:begin  
            #1 PC = jump_inst-1;
            end 
        21:begin  
            #1 PC = jump_inst-1;
            end 
        22:begin  
            #1 addr =rs;
            #1 a=data_out;
            #1 addr =rt;
            #1 b=data_out;
            end 
        23:begin
            #1 addr =rs;
            #1 a=data_out;
            #1 addr =rt;
            #1 b=data_out;
            end 
        24:begin 
            #1 addr =rs;
            #1 a=data_out;
            #1 addr =rt;
            #1 b=data_out;
            end
        63:begin
            for(i=21 ; i<31 ; i=i+1) begin
                addr=i;
                #1 ;
                $display("%d",data_out);
            end
            $finish;
        end
        default : ;
    endcase
    #1 PC=PC+1;
end
endmodule


module tb ();
reg clock;
control uut (clock);
initial begin
clock<=1;
forever #5 clock<=~clock;
end
endmodule