#Definita una matrice in memoria di 8 righe e 8 colonne
#con elementi word, A8x8, stampare in output una nuova
#matrice B8x4 in cui le colonne sono date dal prodotto 
#degli elementi delle colonne della matrice originaria: 
#cioè B4x8 b1,1=a1,1*a1,2; b1,2=a1,3*a1,4; b1,3=a1,5*a1,6; b1,4=a1,7*a1,8.
#ESEMPIO
#A
#02 04 06 07 00 12 03 08
#01 10 05 16 00 01 01 10
#00 03 20 21 01 01 02 04
#02 22 06 00 00 12 37 00
#30 50 01 34 00 05 04 13
#10 63 08 08 01 06 05 03
#05 04 00 01 00 09 06 02
#41 00 14 02 00 14 00 01

#B
#0008 0042 0000 0024
#0010 0080 0000 0010
#0000 0421 0001 0008
#0044 0000 0000 0000
#1500 0340 0000 0052
#0630 0064 0006 0015
#0020 0000 0000 0012
#0000 0028 0000 0000



.text
.globl main
main:

	li $t0, 1	#indice riga
	li $t1, 2	#indice colonna, inizializzato a 2 perché
	#prendo ad ogni iterazione 2 elementi, quello corrente e il precedente

	
reset_colonna:
	li $t1, 2	#resetta al valore iniziale l'indice della colonna
scorrimento:
	#C(r-1)+(c-1)
	subi $t2, $t1, 1	#c-1
	subi $t3, $t0, 1	#r-1	
	mul $t3, $t3, 8		#C(r-1)
	add $t4, $t3, $t2
	mul $t4, $t4, 4		#moltiplica per dimensione word
	
	lw $a0, A($t4)	#preleva il primo valore

	subi $t2, $t1, 2	#decrementa l'indice della colonna
	#per prelevare l'altro valore
	add $t4, $t3, $t2	#C(r-1)+(c-1)
	mul $t4, $t4, 4		#moltiplica per la dimensione di una word
	
	lw $a1, A($t4)	#preleva il secondo valroe
	
	mul $a0, $a0, $a1	#effettua la moltiplicaizone tra i due valori
	
	li $v0, 1
	syscall	#stampa il risultato della moltiplicaizone
	
	la $a0, tab
	li $v0, 4
	syscall	#stampa un tabulato 
	
	addi $t1, $t1, 2	#incrementa di 2 per prelevare i successivisi 2 valori
	
	ble $t1, 8, scorrimento	#vai alal prossima colonna
	
	addi $t0, $t0, 1	#incrementa indice della riga
	
	la $a0, nl	
	li $v0, 4
	syscall	#stampa un a capo
	
	ble $t0, 8, reset_colonna	#e ho prelevato tutti gli elemnti della riga
	#attuale ripeti il ciclo sulla riga successiva
		
	li $v0, 10
	syscall	#terminaizone programma
	
	
.data:
A: .word 02, 04, 06, 07, 00, 12, 03, 08,
		 01, 10, 05, 16, 00, 01, 01, 10,
		 00, 03, 20, 21, 01, 01, 02, 04,
	     02, 22, 06, 00, 00, 12, 37, 00,
	     30, 50, 01, 34, 00, 05, 04, 13,
	   	 10, 63, 08, 08, 01, 06, 05, 03,
	 	 05, 04, 00, 01, 00, 09, 06, 02,
	  	 41, 00, 14, 02, 00, 14, 00, 01
	  	 
tab: .asciiz "\t"
nl: .asciiz "\n"