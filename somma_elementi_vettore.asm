#Somma elementi di un vettore

.text
.globl main
main:

	li $t0,0	#indice scorrimento vettore
	li $a0, 0	#contatore somma
	
ciclo:
	mul $t1, $t0, 4	#indice relativo
	lw $t9, v($t1)	#idnice assoluto
	add $a0, $a0, $t9	#incrementa ail contatore con il valore
	#appena prelevato	
	addi $t0, $t0, 1	#incrementa indice di socrrimento
	blt $t0, 5, ciclo	
	
	li $v0, 1
	syscall	#stampa risultato
	
	li $v0, 10
	syscall
	
.data
v: .word 2,4,6,3,1
