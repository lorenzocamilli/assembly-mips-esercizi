#verificare che una stringa in memoria è palindroma
#non funzionante a pieno, si fa facilemte in modo iterativo
#quetso esercizio serviva solo per l'uso dello stack

.text
.globl main
main:
################per prendere una stringa in input
#inizializzare s come uno space di una determinata grandeza
#
#	la $a0, s	#carica l'indirizzo a cui deve cominciare la strniga 
#	li $a1, 1020	#immagazina la lunghezza della stirnga
#	li $v0, 8	#prende in input la stirnga
#	syscall
#
################

	lb $a1, lung	#puntatore inizializzato alla lunghezza della stirna
	sub $a1, $a1, 1	#elimina il carttere temrinatore di stringa (0)
	li $a3, 0		#puntatore di inizio stirnga
	
	jal PALINDROMA
	
	move $a0, $v0
	li $v0, 4	#stampa la stirnga risultato (se palindorma o no)
	syscall
	
	li $v0, 10
	syscall	#termina programma

PALINDROMA:
	#prelva i due caratteri estremi
	lb $t0, s($a1) #preleva l'ultimo carattere
	lb $t1, s($a3) #preleva il primo carattere
	bne $t0, $t1, caso_baseNO	#se non sono uguali 
	subi $sp, $sp, 4	#crea lo spazio nello stack per slavare il 
	#ritorno della funzione chiamante
	sw $ra, 0($sp)	#salva l'inndirizzo di ritorno della funzione
	addi $a3, $a3, 1 #incrementa il puntatore di inizio stirnga al carattere successivo
	subi $a1, $a1, 1 #decrementa il puntatore di fine stringa al carattere predente	
	bge $a3, $a1, caso_baseYES	#e i due caratteri sono uguali 
	jal PALINDROMA	#chiama la funizone sui nuovi caratteri
	lw $ra, 0($sp)	#prelva il valore di ritorno della funzione chiamante
	addi $sp, $sp, 4	#decrementa lo stack
	jr $ra	#etrun 

caso_baseYES:
	la $v0, Pal	
	jr $ra

caso_baseNO:
	la $v0, notPal	
	jr $ra
	
.data
s: .asciiz "arounautodromoomordotuanuora"
lung:  .byte 28
notPal:  .asciiz "Non e' palindroma\n"
Pal: .asciiz "E' palindroma\n"
