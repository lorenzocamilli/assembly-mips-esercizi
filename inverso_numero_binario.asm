#Dato a intero positivo (da 0 a 255) inserito da 
#tastiera, scrivere il valore binario di a al contrario 
#Esempio
#INPUT (a): 5 (cioè 00000101)
#OUTPUT: 160 (10100000)
#INPUT (a): 105 (cioè 01101001)
#OUTPUT: 150 (10010110)

.text
.globl main
main:

	li $v0, 5
	syscall
	move $t0, $v0
	
	li $t1, 0 #contatore che conta il numero di rotazioni
#fatte
	
ciclo:
	rem $t2, $t0, 2
	
	li $v0, 1	#stampa il bit estratto
	move $a0, $t2
	syscall
	
	ror $t0, $t0, 1	#fa una rotazione a destra di 1 
	addi $t7, $t7, 1
	
	blt $t7, 7, ciclo	#stampa 7 bit
	
	li $v0, 10
	syscall
