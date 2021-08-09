#Si consideri la funzione f definita su interi
#f(x) = f(x-1) - 1 se x è multiplo di 3
#f(x) = f(x-1) + 1 se x non è multiplo di 3
#f(1) = 1

.text 
.globl main
main:

	li $v0, 5
	syscall	#input numero
	move $a0, $v0
	
	jal RECURSION
	
	move $a0, $v0
	li $v0, 1	#stampa risultato
	syscall
	
	li $v0, 10
	syscall

RECURSION:
	beq $a0, 1, caso_base	#se x è 1 allora caso abse
	subu $sp $sp, 8	#crea spazio nello stack
	sw $ra, 0($sp)	#salva il valore di ritorno
	sw $a0, 4($sp)	#salva il valore attuale
	subi $a0, $a0, 1 #decrementa il valore attuale
	jal  RECURSION	#chiama nuovamente la funzione sul valore decrementato
	#ritorni qui dopo aver effuatuato una chiamata ricorsiva
	lw $ra, 0($sp)	#preleva il valore di rirotrno
	lw $a0, 4($sp)	#preleva il valore inserito durante la chiamata
	addi $sp, $sp, 8 #elimina le due celle 
	rem $t0, $a0, 3	#verifica se il valore è multiplo di 3
	beqz $t0, multiplo	#se lo è vai alla funzione "multiplo"
	add $v0,$v0,1	#altrimenti incrememtna di 1 il vlaore di ritorno
	j fine	#ritorna lala chiamante
	
multiplo:
	subi $v0,$v0,1		

fine:
	jr $ra				
												
caso_base:
	li $v0, 1
	jr $ra				
