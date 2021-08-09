#Definita una matrice in memoria di 4 righe e 3 
#colonne A4x3 con elementi word, stampare in o
#utput la matrice trasposta At3x4.
#La matrice trasposta At è costituita dagli elementi
#alla posizione inversa della matrice originale A: 
#cioè A(ai,j) si trova in At(aj,i)

#ESEMPIO
#A
#12 74 06 07
#99 10 11 16
#00 03 20 21

#At
#12 99 00
#74 10 03
#06 11 20
#07 16 21

.text
.globl main
main:

	li $t0, 1	#indice riga
	li $t1, 1	#indice colonna
	
	la $a0, s3	
	li $v0, 4	#stampa messaggio per l'utente
	syscall
	
#per lòa trasposta anziché stampare i valori colonna per colonna
#li stampo riga per riga invertendo quindi l'indice i con j	
	
	
reset_riga:	#da notare che questo per le matrici normali
#è il reset dell'inidce della colonna
	li $t0, 1
scorrimento:
	#C(r-1)+(c-1)
	subi $t2, $t1, 1	#c-1
	subi $t3, $t0, 1	#r-1
	mul $t3, $t3, 4		#c(r-1)
	add $t4, $t3, $t2
	mul $t4, $t4, 4		#moltiplica per 4 grandezza di una word
	
	lw $a0, A($t4)	#preleva l'elemento
	li $v0, 1
	syscall		#stampa
	
	la $a0, s
	li $v0, 4
	syscall	#stampa uno spaizo tra un emento e l'altro
	
	#anziché incrementare l'indice della colonna incremento 
	#quello della riga e faccio il contorllo su essa
	addi $t0, $t0, 1	
	ble $t0, 3, scorrimento	#ripeto finché non ho terminato il numero
	#di righe della non trasposta
	addi $t1, $t1, 1	#incrementa indice colonna
	
	la $a0, s1
	li $v0, 4	#stampa un a capo per la riga successiva
	syscall
	
	ble $t1, 4,  reset_riga #ripete il ciclo per ogni riga della trasposta
	
	li $v0, 10
	syscall
	
.data
A: .word 12, 74, 06, 07,   99, 10, 11, 16,   00, 03, 20, 21
s: .asciiz "\t"
s1: .asciiz "\n"
s3: .asciiz "Matrice trasposta: \n"
