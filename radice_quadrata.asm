#Realizzare un programma in assembly MIPS che 
#calcola la radice quadrata di un nuemro preso
#in input


.text
.globl main
main:
	
	la $a0, input
	li $v0, 4
	syscall

	
	li $v0, 5
	syscall	#prende in input il numero 
	move $a1, $v0
	
	blt $a1, 1, errore	#verifica che non sia minore di 1

	mtc1 $a1, $f1	#lo sposta nel coprocessore matematico
	cvt.s.w	$f1, $f1	#conversione
	sqrt.s $f12, $f1	#calcola la radice quadrata


	la $a0, res
	li $v0, 4
	syscall	#stampa messaggio per l'utente

	li $v0, 2
	syscall	#stampa il avlore della radice quadrata
	
	li $v0, 10
	syscall	#termina programma
	
errore:
	la $a0, err
	li $v0, 4
	syscall

.data:
err: .asciiz "\nValore non valido perché negativo"
res: .asciiz "\nLa radice del numero è: "
input: .asciiz "\nInserisci un nuemro: "