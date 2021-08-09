#Si consideri la funzione f definita su interi
#f(x) = f(x-2) – 2
#f(1) = 14
#f(0) = 10

.text
.globl main
main:
	li $v0, 5
	syscall	#input numero
	move $a0, $v0
	
	jal FUNZIONE
	
	move $a0, $v0
	li $v0, 1	#stampa risultato
	syscall
	
	li $v0, 10
	syscall
	
FUNZIONE:	
	beqz $a0, caso_base0
	beq $a0, 1, caso_base1	
	
	subu $sp, $sp, 8	#crea spazio nello stack
	sw $ra, 0($sp)	#salva il valore di ritorno
	sw $a0, 4($sp)	#slava il valore attuale
	
	subi $a0, $a0, 2	#decrementa il avlore attuale
	#pe rl aprossima chiamata
	jal FUNZIONE
		
	lw $ra, 0($sp)	#recupera l'indirizzo del chiamante
	lw $a0, 4($sp)	#recupera il valore della chiamata
	addu $sp, $sp, 8	#rimuove lo spaizo dlallo stack
	subi $v0, $v0, 2	#effettua l'ultima parte della funzioen
	jr $ra

	
caso_base1:
	li $v0, 14
	jr $ra
	
	
caso_base0:
	li $v0, 10
	jr $ra					
				
