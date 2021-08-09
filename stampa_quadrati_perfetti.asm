#Si scriva un programma in linguaggio assembly MIPS
#per il calcolo dei quadrati perfetti per una sequenza di 
#numeri. Il programma deve prima leggere un numero inserito 
#da tastiera, e quindi stampare i primi quadrati perfetti sino 
#al quadrato del numero.
#ES:
#INPUT=5
#OUTPUT=1,4,9,16,25

.text
.globl main
main:

	li $v0, 5
	syscall	#input da tastiera
	move $t0, $v0

	li $t1, 1	#indice per scorrimento
	addi $t2, $t0, 1	#limite superiore a n+1 (in modo 
	#da stampare anche n^2 alla fine)
ciclo:
	beq $t1, $t2, termina	#se l'indice ha raggiunto il limite superiore termina
	mul $t3, $t1, $t1	#fa il quadrato del nuemro
	move $a0, $t3
	li $v0, 1	#stampa quadrato
	syscall

	la $t9, spazio
	move $a0, $t9
	li $v0, 4
	syscall	#stampa spazio tra numeri

	addi $t1, $t1, 1	#incrememtno indice
	j ciclo

termina:
	li $v0, 10
	syscall

.data
spazio: .asciiz " "
