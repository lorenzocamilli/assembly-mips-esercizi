#Scrivere un programma in linguaggio assembly MIPS
#che riceve in ingresso una sequenza di N numeri interi.
#I numeri sono memorizzati in un vettore. Il valore N 
#è inserito dall’utente, ma il vettore può contenere 
#al massimo 30 numeri. 
#Terminato l’inserimento della sequenza di numeri, 
#il programma deve verificare se gli elementi del vettore 
#sono tutti uguali tra loro.

.text 
.globl main
main:

	li $v0 5
	syscall #input lunghezza vettore
	move $t0, $v0
	move $a1, $t0
	
	bgt $t0, 30, errore	#controllo
	blez $t0, errore


	la $t1, v	#indirizzo memroia vettore
	mul $t0, $t0, 4	#moltiplicaizone della lunghezza per
	#la dimensione del dati su cui si sta operando (4)
	add $t0	, $t0, $t1	#indirizzo finale del vettore
	
ciclo:
	li $v0, 5
	syscall	#prende in input gli elemnti
	move $t9, $v0
	sw $t9, ($t1)	#salva il valore nella cella dle vettore
	add $t1, $t1, 4	#incrementa l'inizio del vettore
	blt $t1, $t0, ciclo	#confronta l'indice con la fine del vettore
	

	la $t0, v	#indirizzo memoria vettore
	li $t1, 0	#indice scorrimento evttore

stampa:
	
	mul $t8, $t1, 4		#base*dimensione (4 per le word)
	lw $t9, v($t8)	#prelelva il valore nella cella del vettore

	li $v0, 1
	move $a0, $t9	#stampa del velore
	syscall
	
	li $v0, 4
	la $a0, s	#stampa dello spazio
	syscall


	addi $t1, $t1, 1	#incremento indice scorrimento
	blt $t1, $a1, stampa	#confronto dell'indice con la dimensione del vettore
	j termina


errore:
	la $a0, er
	li $v0, 4
	syscall

termina:
	li $v0 10
	syscall


.data
v: .space 120	#30*4 (dimensione word)
s: .asciiz " "
er: .asciiz "Il valore inseirito deve essere un numero minore o uguale a 30"




