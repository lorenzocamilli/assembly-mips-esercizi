#Somma elementi diagonale non principale matrice

.text
.globl main
main:
	li $t0, 1 #indice colonna
	li $t1, 1 #indice riga	
	li $a0, 4 #numero righe
	li $a1, 4 #nuemro colonne
	li $a2, 0 #sommatore
	li $t7, 4 #indice colonna diagonale 	
	li $t8, 1 #indice riga diagonale	
	
reset_indice_colonna:
	li $t0, 1
scorriemnto:	

	subi $t2, $t0, 1	#c-1
	subi $t3, $t1, 1	#r-1
	mul $t3, $t3, $a0	#C(r-1)
	add $t4, $t3, $t2   #C(r-1)+(c-1)
	mul $t4, $t4, 4		#moltiplico per la idmensione di una word
	lw $a3, M($t4)		#prelevo elemnto
	
	seq $t6, $t0, $t7	#verifico che l'indice di scorrimento corrisponda 
	#all'indice 
	seq $t5, $t1, $t8

	and $t9, $t5, $t6	#and dei due risultati
	beq $t9, 1, somma
return:
	addi $t0, $t0, 1	#incremento indice colonna
	blt $t0, $a0, scorriemnto
	addi $t1, $t1, 1	#incremento indice riga
	subi $t7, $t7, 1	
	addi $t8, $t8, 1
	
	blt $t1, $a1, reset_indice_colonna
	j fine
	
	
somma:
	add $a2, $a2, $a3
	j return	
	
fine:
	move $a0, $a2
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall	
	
.data
M: .word 1,1,2,6, 3,4,5,1, 3,3,1,4, 8,7,2,1	#6+5+3+8
	
	
	


