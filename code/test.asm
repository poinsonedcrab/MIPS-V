.text
	addi $17, $0, 8 #const $17=8
	add $14, $14, $17 #$14=8
	addi $14, $14, -1 #$14--
	beq $14, $0, begin
	jr $17 #jump to IMemAddr 8
begin:
	addi $16, $0, 1 #const 1
	addi $15, $0, 8192 #MemAddr
	
	addi $8, $0, 16 #$8=16
	sll $8, $8, 1 #$8=32
	srl $8, $8, 2 #$8=8
	
	sw $8, 0($15) #-------Save Value: 8------
	addi $15, $15, 4 #MemAddr++	
	
	lw $9, -4($15) #$9=8(32'b00000000_00000001_00000000_00001000)
	sllv $10, $9, $9 #$10=2048(32'b00000000_00000000_00001000_00000000)
	lui $9, 1 #$9=32'b00000000_00000001_00000000_00000000
	
	sw $9, 0($15) #-------Save Value: 32'b00000000_00000001_00000000_00001000------
	addi $15, $15, 4 #MemAddr++	

	sw $10, 0($15) #-------Save Value: 2048------
	addi $15, $15, 4 #MemAddr++
	
	sub $10, $10, $16 #$10=2047(32'b00000000_00000000_00000111_11111111)
	
	sw $10, 0($15) #-------Save Value: 2047------
	addi $15, $15, 4 #MemAddr++
	
	or $8, $8, $10 #$8=2047(32'b111_11111111)
	and $8, $8, $0 #$8=0
	nor $8, $8, $8 #$8=2^32-1

	sw $8, 0($15) #-------Save Value: 2^32-1------
	addi $15, $15, 4 #MemAddr++	
	
	xor $11, $10, $8 #$11=32'b11111111_11111111_11111000_00000000
	sra $11, $11, 1 #$11=32'b11111111_11111111_11111100_00000000
	srav $11, $11, $16 #$11=32'b11111111_11111111_11111110_00000000

	sw $11, 0($15) #-------Save Value: 32'b11111111_11111111_11111110_00000000------
	addi $15, $15, 4 #MemAddr++	
	
	srl $11, $11, 1 #$11=32'b01111111_11111111_11111111_00000000
	srlv $11, $11, $16 #$11=32'b00111111_11111111_11111111_10000000
	
	sll $11, $11, 23 #$11=32'b01000000_00000000_00000000_00000000
		
	addu $11, $11, $11 #$11=32'b10000000_00000000_00000000_00000000

	sw $11, 0($15) #-------Save Value: 32'b10000000_00000000_00000000_00000000------
	addi $15, $15, 4 #MemAddr++		
	
	subu $11, $11, $8 #$11=32'b10000000_00000000_00000000_00000001

	sw $11, 0($15) #-------Save Value: 32'b10000000_00000000_00000000_00000001------
	addi $15, $15, 4 #MemAddr++	
	
	addiu $11, $11, 1 #$11=32'b10000000_00000000_00000000_00000010
	
	sw $11, 0($15) #-------Save Value: 32'b10000000_00000000_00000000_00000010------
	addi $15, $15, 4 #MemAddr++	

	ori $11, $11, 1 #$11=32'b10000000_00000000_00000000_00000011
	andi $11, $11, 3 #$11=32'b00000000_00000000_00000000_00000011
	xori $11, $8, 1 #$11=32'b11111111_11111111_11111111_11111110

	sw $11, 0($15) #-------Save Value: 32'b11111111_11111111_11111111_11111100------
	addi $15, $15, 4 #MemAddr++	
	
	slt $12, $16, $11 #$12=0

	sw $12, 0($15) #-------Save Value: 0------
	addi $15, $15, 4 #MemAddr++	

	sltu $12, $16, $11 #$12=1

	sw $12, 0($15) #-------Save Value: 1------
	addi $15, $15, 4 #MemAddr++	
	
	slti $12, $11, 1 #$12=1

	sw $12, 0($15) #-------Save Value: 1------
	addi $15, $15, 4 #MemAddr++	

	sltiu $12, $11, 1 #$12=0

	sw $12, 0($15) #-------Save Value: 0------
	addi $15, $15, 4 #MemAddr++		
	
	movz $13, $12, $12 #because $12=0, set $13=$12,

	sw $13, 0($15) #-------Save Value: 0------
	addi $15, $15, 4 #MemAddr++			

	movn $13, $16, $16 #because $16=1(!=0), set $13=$16,
	
	sw $13, 0($15) #-------Save Value: 1------
	addi $15, $15, 4 #MemAddr++			




	addi $14, $0, 0 #count
	j a
i: 	j end

	
h:	addi $14, $14, 1 #count++
	sw $14, 0($15) #-------Save Value: $14------
	addi $15, $15, 4 #MemAddr++		
	bne $11, $0, i #to i	
	
g:	addi $14, $14, 1 #count++
	sw $14, 0($15) #-------Save Value: $14------
	addi $15, $15, 4 #MemAddr++		
	beq $0, $0, h #to h	
	
f:	addi $14, $14, 1 #count++
	sw $14, 0($15) #-------Save Value: $14------
	addi $15, $15, 4 #MemAddr++		
	blez $0, g #to g

	
e:	addi $14, $14, 1 #count++
	sw $14, 0($15) #-------Save Value: $14------
	addi $15, $15, 4 #MemAddr++		
	bltz $11, f #to f

d:	addi $14, $14, 1 #count++
	sw $14, 0($15) #-------Save Value: $14------
	addi $15, $15, 4 #MemAddr++		
	bgez $0, e #to e
	
c:	addi $14, $14, 1 #count++
	sw $14, 0($15) #-------Save Value: $14------
	addi $15, $15, 4 #MemAddr++		
	bgtz $16, d #to d
	
b:	addi $14, $14, 1 #count++
	sw $14, 0($15) #-------Save Value: $14------
	addi $15, $15, 4 #MemAddr++		
	bne $11,$0, c #to c
	
a:	addi $14, $14, 1 #count++
	sw $14, 0($15) #-------Save Value: $14------
	addi $15, $15, 4 #MemAddr++		
	beq $11, $11, b #to b

end:addi $14, $14, 1 #count++
	sw $14, 0($15) #-------Save Value: $14------
	
out:j out







	
	
	
