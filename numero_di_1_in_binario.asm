#Implementare un programma in linguaggio assembly MIPS
#che legga da input un intero e calcoli il numero di 
#1 della sua rappresentazione binaria.
#Esempio
#INPUT: 521 (in binario 1000001001)
#OUTPUT:3

.text
.globl main

main:
	li $v0, 5
	syscall 	#numero in input
	move $t0, $v0

	lw $t9, contatore	#poteva anche essere li $t9, 0

ciclo:
	beqz $t0, termina	#quando hai raggiunto 0 termina
	rem $t1, $t0, 2	#resto della divisione (prende l'ultimo bit)
	div $t0, $t0, 2 #divide il numero
	bne $t1, 1, ciclo	#se non è uguale ad 1 ripeti il ciclo	
	addi $t9, $t9, 1	#altrimenti incrementa il contatore	
	j ciclo	#e riepti il ciclo

termina:
	li $v0, 1
	move $a0, $t9
	syscall	#stampa del valore del contatore

	li $v0, 10
	syscall	#terminazione programma

.data
contatore: .word 0


