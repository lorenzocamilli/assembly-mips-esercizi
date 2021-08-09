#Un programma in linguaggio assembly MIPS deve
#inizializzare quindici valori interi e calcolare
#la media aritmetica (si deve usare il coprocessore 
#matematico) degli elementi alla posizioni pari, 
#alla posizioni dispari e quella complessiva.

.text
.globl main
main:
	li $t1,15	#lunghezza vettore
	li $t2, 0	#indice scorriemnto vettore
	
	li $t6, 0	#registro contatore dei numeri pari
	li $t7, 0	#registro per la sooma dgli uindici pari
	li $t8, 0 	#registro per la somma degli indici dispari
	
ciclo:	
	mul $t3, $t2, 4	#idice assoluto
	lw $t4, v($t3)	#preleva il valore
	move $a1, $t4	#immagazina in un registro preservante il valroe
	
	move $a0, $t4
	li $v0, 1	#stampa valore
	syscall
	
	la $a0, s
	li $v0, 4	#stampa lo spazio per distanziare le varie satampe
	syscall
	
	rem $t9, $t2, 2	#controlla se il valore dell'indice
	#è pari o dispari
	beqz $t9, indice_pari	#se è pari
	bnez $t9, indice_dispari	#e è disapri
	
return:	
	addi $t2, $t2, 1	#incrementa il registro scorrimento
	bgt $t1, $t2, ciclo	#ripete il ciclo



media_pari:
	mtc1 $t7, $f7	#sposta nel coprocessore matematrico la 
	#somma dei nuemri pari
	mtc1 $t6, $f6	#sposta nel coprocessore matematico il nuemro di indici pari
	cvt.s.w $f7, $f7	#conversione in virgola mobile dei valori
	cvt.s.w $f6, $f6
	div.s $f0, $f7, $f6 #calcola la media dei apri
	
	la $a0, s1
	li $v0, 4	#stampa la stringa s1
	syscall
	
	mov.s $f12, $f0
	li $v0, 2	#stampa la media dei pari
	syscall
	
	

media_dispari:
	mtc1 $t8, $f8	#sposta nel coprocessore matematico il
	#la somma degli elementi negli idici dispari
	sub $t5, $t1, $t6	#numero di elemnti dispari (calcolato da
	#unmero elementi-numero indici pari)
	mtc1 $t5, $f5	#sposta nel coprocessore matematico il numeor di di indici dispari
	cvt.s.w $f8, $f8	#conversione dei valori in virgola mobile
	cvt.s.w $f5, $f5
	div.s $f1, $f8, $f5	#media elemementi dispari

	
	la $a0, s2
	li $v0, 4	#stampa la stringa s2
	syscall
	
	mov.s $f12, $f1
	li $v0, 2	#stampa la media dei dispari
	syscall

	j fine


indice_pari:
	add $t7, $a1, $t7	#somma dei valori sugli indici pari
	addi $t6, $t6, 1	#numero di indici pari
	j return	#ritorna al ciclo di scorrimento
	
indice_dispari:
	add $t8, $a1, $t8	#somma dei valori sugli indici dispari
	j return	#ritorna al al ciclo di scorrimento


fine:
	li $v0, 10
	syscall	#syscall di terminazione programma


.data
v: .word 1,2,2,4,2,6,2,8,2,10,2,12,2,14,2
s: .asciiz " "
s1: .asciiz "\nMedia indici pari: "
s2: .asciiz "\nMedia indici dispari: "
