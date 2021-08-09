#Programma MIPS hce crea un vettore di float presi input
#calcola la somma degli elementi inseriti e stampa il vettore

.text
.globl main
main:

	la $a0, s1
	li $v0, 4	#messaggio per l'utente
	syscall

	li $v0, 5
	syscall	#prende in input la lunghezza del vettore
	move $t0, $v0


ciclo:
	mul $t2, $t1, 4	#moltiplica per 4 grandezza di una word

	li $v0, 6
	syscall	#prende in input un float

	mfc1 $t8, $f0	#muove il float dal coprocessore matematico
	#ai registri della CPU, pe rinserirli nel vettore
	sw $t8, v($t2)	#scrive il valore nel vettore
	addi $t1, $t1, 1	#incrementa l'indice del vettore
	blt $t1, $t0, ciclo	#confronto con la lunghezza del vettore
	
	
	li $t1, 0	#azzeera l'indice del vettore
stampa:
	mul $t2, $t1, ,4	#moltiplica per 4 grandezza di una word
	lw $t8, v($t2)	#prelevca il valore dal vettore

	mtc1 $t8, $f12	#sposta il valore nel coprocessore matematico

	li $v0, 2	#stampa del float
	syscall
	
	add.s $f1,$f1, $f12	#icnrementa il sommatore
	#per il nuemro appena prelevato
	
	la $a0, s
	li $v0, 4	#stampa uno spazio
	syscall
	
	addi $t1, $t1, 1	#incrementa l'indice di socrrimento del vettore	
	blt $t1, $t0, stampa	#confronto con la lunghezza del vettore
	
	la $a0, s2
	li $v0, 4	#stampa messaggio per l'utente
	syscall	

	mov.s $f12, $f1
	li $v0, 2	#stampa il valore della somma
	syscall					
					
	li $v0, 10
	syscall 	#terminazione programma
	
	
.data
v: .space 1024	
s: .asciiz " "
s1: .asciiz "\nInserisci la lunghezza del vettore: "
s2: .asciiz "\nStampa della somma: " 




