#Si consideri la funzione f definita su interi
#f(x,y) = (x-y)*f(x-5,y+3)
#f(x,y) =4 se x<=0

.text
.globl main
main:

	li $v0, 5
	syscall	#input x
	move $a0, $v0
	
	li $v0, 5
	syscall	#input y
	move $a1, $v0
	
	jal FUNZIONE
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	
FUNZIONE:	
	blez $a0, caso_base
	sub $sp, $sp, 16	#crea spaizo nello stack
	sw $ra, 0($sp)	#salva il valore di ritorno
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sub $a0, $a0, 5
	add $a1, $a1, 3
	jal FUNZIONE
	lw $ra, 0($sp)	#preleva il valroe di ritorno della chiamante
	lw $t0, 4($sp)
	lw $t1, 8($sp)	
	add $sp, $sp, 16	#ripristina lo stack
	sub $v1, $t1, $t0
	mul $v0, $v0, $v1
	jr $ra
	
	
caso_base:
	li $v0, 4
	jr $ra


