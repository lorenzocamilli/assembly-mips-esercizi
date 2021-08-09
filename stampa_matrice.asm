#Implementare un programma in linguaggio assembly MIPS
#che definiti R (numero di righe) e C (numero di colonne) 
#rispettivamente in $t0 e $t1, stampa in maniera leggibile
#e conforme alla struttura tabellare una matrice 
#MRxC definita in memoria.

.text 
.globl main
main:

	lw $t0, R	#numero righe
	lw $t1, C	#numero colonne
	li $t2,1	#indice colonne
	li $t3,1	#indice righe
	la $t4, tab
	la $t5, a_capo


reset_indice_colonna:
	li $t2, 1 #resetta indice colonna
analisi_colonna:	
	#C(r-1)+(c-1)
	subi $t6, $t2, 1	#decremento indice colonna (c-1)
	subi $t7, $t3, 1	#decremento indice riga (r-1)
	mul $t8, $t7, $t1	#C(r-1)
	add $t8, $t8, $t6	#C(r-1)+(c-1)
	mul $t8, $t8, 4		#moltiplico per la dimensione dell'elemento
	#siccome sono word moltiplico per 4
	lw $t9, M($t8)		#preleva il valore attuale della matrice
	
	move $a0, $t9	
	li $v0, 1	#stampa elemnto matirce
	syscall
	
	move $a0, $t4
	li $v0, 4	#stampa del tab
	syscall
	
	addi $t2, $t2, 1	#incrementa indice colonna
	ble $t2, $t1, analisi_colonna	#se non è stato raggiunto
	#l'ultimo elemento della colonna ripeti il ciclo
	addi $t3, $t3, 1	#altriemtni incremetna l'indice della riga
	
	move $a0, $t5	
	li $v0, 4	#stampa dell'a capo
	syscall
	
	ble $t3, $t0, reset_indice_colonna #ricomincia il cilo sulla nuova
	#riga resettando l'indice della colonna	

	li $v0, 10
	syscall		#terminaizone programma
	
	
	
							
.data
R: .word 5 	#numero righe
C: .word 3	#nuemro colonne
M: .word 1,12,1, 1,2,3,  99,45,42,  76,15, 10, 33, 55, 0
tab: .asciiz "\t"
a_capo: .asciiz "\n"

