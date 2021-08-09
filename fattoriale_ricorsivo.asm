#Si consideri la funzione f fattoriale definita 
#per valori interi n
#FATTORIALE(x) = x*FATTORIALE(x-1)
#FATTORIALE(1) = 1
#FATTORIALE(0) = 1
#Si realizzi un programma in Si realizzi un 
#programma in assembly assembly MIPS che,definito 
#un intero positivo che,definito un intero positivo x?2,
#calcola il corrispondente valore di 
#FATTORIALE(x) in modo ricorsivo


.globl main
main:

	li $v0, 5
	syscall	#input numero
	move $a0, $v0

	jal FATTORIALE
	
	move $a0, $v0
	li $v0, 1	#stampa risultato
	syscall
	
	li $v0, 10
	syscall
	
	
FATTORIALE:
	blt $a0, 2, caso_base	#se il numero è minore di 2 alllora
	#vai al caso base
	subu $sp, $sp, 8	#crea spazio (2 celle) nello stack
	sw $ra, 0($sp)	#salva nella prima cella il valore di ritorno
	#della funzione che ha chiamato la routine
	sw $a0, 4($sp)	#salvati il valore attuale del numero
	subi $a0, $a0, 1	#decrementa il nuemro per la prossima iterazione
	jal FATTORIALE	#chiama nuovamente la routine
	#arrivi qui al ritorno di ogni chiamata
	lw $ra, 0($sp)	#carica in ra l'indirizzo che era stato
	#salvato della chiamante
	lw $a0, 4($sp)	#preleva il nuemro salvato
	addi $sp, $sp, 8	#togle le due celle usate dlalo stack
	mul $v0, $v0, $a0	#calcola il fattoriale
	jr $ra	#ritorna lal'indirizzo slavato
		
caso_base:
	li $v0, 1	
	jr $ra
	
