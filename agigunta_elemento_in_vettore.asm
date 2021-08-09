#Inizializzare, con valori casuali, un vettore di
#dimensione 10 con elementi word e realizzare la funzione
#INS(vettore, DIM, ELEM, POS)
#che inserisce l'elemento ELEM (immesso da tastiera) alla
#posizione POS (immessa da tastiera) slittando a destra 
#gli elementi successivi alla posizione di inserimento
#ESEMPIO:
#v1=555,6,710,33,6071,789,5,-67,99,1000
#lunghezzav1=10
#INS(v1,10,2312,6)
#v1=555,6,710,33,6071,2312,789,5,-67,99,1000
#lunghezzav1=11
#PS: per evitare la gestione del caso in cui l'utente
#inserisca una posizione al di fuori dal range [0,9] 
#si consiglia di stamapre su videoterminale un segnale di avvertimento

.text
.globl main
main:

	li $v0,4
	la $a0, sElem	#messaggio per l'utente
	syscall
	
	li $v0, 5
	syscall	#prende in input l'elemento da inserire
	move $a3, $v0
	
	li $v0,4
	la $a0, sPos	#messaggio per l'utente
	syscall
	
	li $v0, 5
	syscall	#prende in input  la posizione dell'elemento
	move $a2, $v0
	
	li $t4, 0	#indice scorrimento vettore input
		
	#verifica che la posizone inserita non ecceda il 9 e non sia minore di 0
	bltz $a2, errore
	bgt $a2, 9, errore 
	j vettore_random
	
errore:
	la $a0, sError
	li $v0,4
	syscall		#stampa stringa errore
	
	j fine
	
	
vettore_random:
	#crea un vettore con 10 numeri random
	li $v0, 42 	#syscall per nuemri casuali
    li $a1,  100 # limite superiore numeri casuali
    syscall

	mul $t6, $t4, 4	#moltiplica l'indice per la dimensione di una word
	sw $a0, in($t6)	#scrittura nel vettore

	addi $t4, $t4, 1	#incrementa indice di scorriemnto
	blt $t4, 10, vettore_random
		
		
	la $a0, sRandom
	li $v0, 4	#messaggio per l'utente
	syscall
	
	li $t9, 0
	
stampa_random:
#stampa il vettore randomico
	mul $t1, $t9, 4
	lw $a0, in($t1)
	li $v0, 1
	syscall	
	
	la $a0, s
	li $v0, 4
	syscall
	
	addi $t9, $t9, 1		
	blt $t9, 10,  stampa_random	
	
	

	li $t0, 0	#indice scorrimento vettore input
scorrimento:	#scorrimento del vettore fino allla posiaizone
#presa in input
	beq $t0, $a2, inseirsci	#se l'indice di socrrimento è uguale al
	#valore della posizione inserita dlal'utente 
	mul $t1, $t0, 4
	lw $t5, in($t1)
	sw $t5, out($t1)	#scrive il valore prelevato nel vettore di output
	addi $t0, $t0, 1		
	blt $t0, 10,  scorrimento	#altrimenti continua a scorrere

inseirsci:	#inserisce nella posizione pres in input il valore 
	#preso in input
	mul $t1, $t0, 4
	sw $a3, out($t1)	
	
	addi $t8, $t0, 1	#indice di scorriemnto del vettore di output
	#inizializzato al valore delliondice dis corrimento del evttore di input
	#+1 perché ho inserito un elemento
	
scorrimento2:	
	mul $t1, $t0, 4
	lw $t5, in($t1)	#recupera il valore corrispondente nel
	#vettore di input
	mul $t7, $t8, 4		#moltiplica pe rla grandezza di una word
	sw $t5, out($t7)	#scrive il valore del vettore in input 
	addi $t0, $t0, 1	#incrementa l'indice di socrirmento	vettore input
	addi $t8, $t8, 1	#incrementa l'indice di socrirmento	vettore output
	blt $t0, 11,  scorrimento2
	
	li $t9, 0
	
	la $a0, sOut
	li $v0, 4	#messaggio per l'utente
	syscall
	
stampa:	#stampa del vettore di output
	mul $t1, $t9, 4
	lw $a0, out($t1)
	li $v0, 1
	syscall	
	
	la $a0, s
	li $v0, 4	#stampa uno spazio di separazione tra gli elementi
	syscall
	
	addi $t9, $t9, 1		
	blt $t9, 11,  stampa
	
fine:	#termina programma
	li $v0, 10
	syscall
	
	
.data	
in: .space 400
out: .space 404
s: .asciiz " "
sElem: .asciiz "\nInserisci l'elemeto da aggiungere "
sPos: .asciiz "\nInserisci la posizione in cui aggiungere l'elemento "
sError: .asciiz "\nIl valore inserito deve essere un numero compreso tra 0 e 9 "
sRandom: .asciiz "\nVettore elementi ranodm: "
sOut: .asciiz "\nVettore output: "

