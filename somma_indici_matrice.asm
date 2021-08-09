#Data una matrice RxC realizzare un programma in asembly
#MIPS che restutisce la somma degli elementi aventi 
#il valore uguale alla somma degli indici r e c
#Esempio
#2 5 7
#3 0 8
#7 9 6
#1 6 5
#a11+a21+a33+a42 output=2+3+6+6=17
#NB: La matrice è definita in memoria. Gli elementi
#della matrice sono interi a 16bit. Il programma 
#deve valere per ogni matrice RxC, lo studente 
#può inizializzare una generica matrice di 
#dimensione fissa con R e C prefissati.


.text
.globl main
main:	
	li $t0, 1	#indice riga
	li $t1, 1	#indice colonna
	
	li $a0, 0
	
reset_colonna:
	li $t1, 1
scorrimento:
	#C(r-1)+(c-1)
	subi $t2, $t1, 1	#c-1
	subi $t3, $t0, 1	#r-1
	mul $t3, $t3, 3		#C(r-1) 3 numero di colonne
	add $t4, $t3, $t2	#C(r-1)+(c-1)
	mul	$t4, $t4, 2		#moltiplica per la dimensione di una half word
		
	lh $t9, M($t4)		#preleva l'elemento della matrice
	add $t5, $t0, $t1	#calcola la somma tra gli indici
	beq $t5, $t9, somma	#se la sooma è uguale  al vlaore prelevato
return:
	addi $t1, $t1, 1	#incrementa l'indice della oclonna
	ble $t1, 3, scorrimento	#se è minore di 3 continua a scorrere
	
	addi $t0, $t0, 1	#incrementa l'indice della riga
	ble $t0, 4, reset_colonna	
	
	li $v0, 1
	syscall	#stampa il valore della somma
	
	li $v0, 10
	syscall	#termina programma
	
somma:
	add $a0, $a0, $t9	#effettua la somma 
	j return	

.data

M: .half 2, 5, 7,
		 3, 0, 8,
		 7, 9, 6,
		 1, 6, 5


