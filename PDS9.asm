
# // Ogirala Deeven Kumar       - 210681
# // Sajja Eswara Sai Raghava   - 210904

.data
n: .word 10
Array: .word 20, 7, 40, 61, 97, 5, -5, 6, 13, 3 
newline: .asciiz "\n"

.text
main:

BubbleSort :
lw  $t0, n 
li $t1, 1
outer_loop :
bgt $t1, $t0, print
la  $s0, Array  
addi $t1, $t1, 1
li $t2, 1
inner_loop :
beq $t2, $t0, outer_loop
lw $t3 ,0($s0)
lw $t4 ,4($s0)
bgt $t4,$t3, continue
sw $t3 ,4($s0)
sw $t4 ,0($s0)
continue:
addi $t2, $t2, 1
addi $s0, $s0, 4
j inner_loop


print:
lw $t0, n
la $t2, Array
li $t1 , 1
print_loop:
bgt $t1, $t0, exit
li $v0, 1   
lw $a0, 0($t2)
syscall
li $v0, 4    
la $a0, newline
syscall
addi $t1, $t1, 1
addi $t2, $t2, 4
j print_loop

exit:
li $v0, 10
syscall




