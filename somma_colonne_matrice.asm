#Definita in memoria una matrice di 4 righe e 4 colonne
#con elementi byte, stampare in output la somma 
#degli elementi presenti lungo una colonna ESEMPIO
#MEMORIA
#3 6 7 8
#1 5 2 0
#6 8 10 5
#4 1 -9 2
#OUTPUT
#COLONNA 1: 14
#COLONNA 2: 20
#COLONNA 3: 10
#COLONNA 4: 15

.text
.globl main
main:
	li $t0, 1	#indice scorrimento colonne
	li $t1, 1	#indice scorrimento righe

	#sommatori colonne
	li $t5, 0
	li $t6, 0
	li $t7, 0
	li $t8, 0
	

reset_indice_colonna:
	li $t0, 1
analisi_colonna:
	#C(r-1)+(c-1)
	subi $t2, $t0, 1	#c-1
	
	subi $t3, $t1, 1	#r-1
	mul $t3, $t3, 4		#C(r-1)
	
	add $t4, $t3, $t2
	mul $t4, $t4, 4		#4->dimensione word
	
	lw $t9, M($t4)	#preleva l'elemnto
	
	beq $t0, 1, somma_colonna1		
	beq $t0, 2, somma_colonna2
	beq $t0, 3, somma_colonna3
	beq $t0, 4, somma_colonna4

return:

	addi $t0, $t0, 1	#incrementa indice scorrimento colonne
	ble $t0, 4, analisi_colonna
	
	addi $t1, $t1, 1	#incrementa indice scorrimento righe
	
	ble $t1, 4 reset_indice_colonna
	
stampa:
	li $v0, 4
	la $a0, s1
	syscall	#stampa messaggio per l'utenet
	
	li $v0, 1
	move $a0, $t5
	syscall	#stampa valore somma
	
	li $v0, 4
	la $a0, s2
	syscall	#stampa messaggio per l'utenet
	
	li $v0, 1
	move $a0, $t6
	syscall	#stampa valore somma
	
	
	li $v0, 4
	la $a0, s3
	syscall	#stampa messaggio per l'utenet
	
	li $v0, 1
	move $a0, $t7
	syscall	#stampa valore somma
	
	
	li $v0, 4
	la $a0, s4
	syscall	#stampa messaggio per l'utenet
	
	li $v0, 1
	move $a0, $t8
	syscall	#stampa valore somma
	
	
	li $v0, 10
	syscall
	
	
	
somma_colonna1:
	add $t5, $t5, $t9
	j return

somma_colonna2:
	add $t6, $t6, $t9
	j return

somma_colonna3:
	add $t7, $t7, $t9
	j return

somma_colonna4:
	add $t8, $t8, $t9
	j return

.data
M: .word 3, 6, 7, 8, 1, 5, 2, 0, 6, 8, 10, 5, 4, ,1, -9, 2
s1: .asciiz "\nCOLONNA 1: "
s2: .asciiz "\nCOLONNA 2: "
s3: .asciiz "\nCOLONNA 3: "
s4: .asciiz "\nCOLONNA 4: "
