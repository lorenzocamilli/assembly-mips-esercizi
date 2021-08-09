#Si consideri la funzione f definita su interi
#f(x,y) = 2*f(x-2,y-5)
#f(0,y) = 1
#f(x,0) = 2
#f(0,0)=3

.text
.globl main
main:

	li $v0, 5
	syscall	#input X
	move $a0, $v0	
	 
	li $v0, 5
	syscall	#input Y
	move $a1, $v0		
	
	jal	 FUNZIONE
	
	move $a0, $v0
	li $v0, 1	#stampa #risultato
	syscall
	
	li $v0, 10
	syscall
		
				
FUNZIONE:
	beqz $a0, zerox	
	subu $sp, $sp, 8
	sw $ra, 0($sp)	#salva il valroe di rirotrno
#	sw $a0, 4($sp)
#	sw $a1, 8($sp)
	subi $a0, $a0, 2	#decrementa x 
	subi $a1, $a1, 5	#decrementa y
	jal FUNZIONE
	lw $ra, 0($sp)
#	lw $a0, 4($sp)
#	lw $a1, 8($sp)
	addi $sp, $sp, 8
	mul $v0, $v0, 2	#moltipèlic ail rusltato per 2
	jr $ra
		
zerox:
	beqz $a1, zeroxy
	li $v0, 2	#se x=0 e y!=0
	jr $ra

zeroy:
	beqz $a0, zeroxy
	li $v0, 1 #se x!=0 e y=0
	jr $ra	
	
zeroxy:	#se x ed y sono uguali
	li $v0, 3	
	jr $ra
