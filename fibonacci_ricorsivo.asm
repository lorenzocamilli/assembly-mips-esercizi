#Calcolo dell'n-esimo numero di Fibonacci 

.text
.globl main
main:
	la $a0, s1
	li $v0, 4	
	syscall	#stampa messaggio per l'utente
	
	li $v0 5
	syscall	#prende in input il numero
	move $a1, $v0

	jal FIB
	
	move $a0, $v0
	li $v0, 1
	syscall	#stampa risultato
	
	li $v0, 10
	syscall	#terminazione programma
#FIB(N)=)FIB(N-1)+FIB(N-2), FIB(1)=1, FIB(0)=0
FIB:
	beq $a1, 1, caso_base1	#e il valore è uguale a 1
	#vai al caso base 1
	beqz $a1, caso_base0	#se il valroe è uguale a 0 
	#vai al caso abse 0	
	subi $sp, $sp, 12	#crea 3 spazi nello tsack pointer
	sw $ra, 0($sp)	#salva il avlore di ritorno
	sw $a1, 4($sp)	#salva il valore attuale del nuemro
	subi $a1, $a1, 1	#decrementa il nuemro di 1
	jal FIB	#chiama la funzione su n-1
	sw $v0, 8($sp)	#salva il risultato
	lw $a1, 4($sp)
	subi $a1, $a1, 2
	jal FIB	#chiama la funzione su n-2
	lw $v1, 8($sp)
	add $v0, $v0, $v1	#calcola fib
	lw $ra, 0($sp)   #preleva il valore di ritorno
	addi $sp, $sp, 12     #elimina lo spaizo creato
	jr $ra  #ritorna         	
	
caso_base1:
	li $v0, 1
	jr $ra	

caso_base0:
	li $v0, 0
	jr $ra

.data
s1: .asciiz "\nInserisci un numero: " 

