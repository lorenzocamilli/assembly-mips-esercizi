#Implementare in linguaggio asembly MIPS 
#un programma che calcola il massimo tra 
#n elementi immessi in input (la lettura 
#termina quando si introduce un numero negativo. 
#Utilizzare la sub-routine (funzione) MASSIMO 
#che presi due elementi restituisce il massimo.
#Esempio
#INPUT:
#45; 66; 34; 156; 233; 234; 56; 0 ; -11
#ANALISI
#MASSIMONUM(45, 66, 34, 156,233,234,56,0,-11)=234
#MASSIMO(MASSIMO(MASSIMO(MASSIMO(MASSIMO(MASSIMO(MASSIMO(45,66),34),156),233),234),56),0)=234
#OUTPUT:
#234
#esercizio svolto con un vettore per esercitazione
	
	la $a0, s1
	li $v0, 4	#messaggio per l'utente
	syscall
	
	li $v0 5
	syscall	#preleva la lunghezza del vettore (masismo 30)
	move $a1, $v0
		
	li $t0, 0	#idice scorriemnto vettore		
		
input:
	mul $t1, $t0, 4
	
	la $a0, s2
	li $v0, 4	#messaggiuo per l'utente
	syscall

	li $v0 5
	syscall	#preleva il valore da inserire nel vettore
	move $t9, $v0
		
	sw $t9, in($t1)	#salva il valore preso in input nel vettore
	
	addi $t0, $t0, 1	#incrementa indice scorriemnto vettore
	blt $t0, $a1, input

	li $t2, 1 #indice di socrriemnto del vettore per prelevare gli elemenit
	#inizializzato ad 1 in mod tale da prendere nella prima iterazione
	#il valore a posizone 0 e 1, senza generare segmentation fault

take:
	mul $t3, $t2, 4
	lw $a0, in($t3)	#preleva il primo elemnto
	subi $t4, $t2, 1 #decrementa l'indice in modo da prendere l'elemnto precedente
	#con cui confrontarlo
	mul $t5, $t4, 4
	lw $a2, in($t5)	#preleva il secondo elemento
	
	jal MASISMO	
	
	move $a3, $v0	#sis alva il valore del massimo risultante dalla 
	#funzione
	
	addi $t2, $t2, 1	#incrementa l'inidce di socrrimento
	blt $t2, $a1, take
	
	la $a0, s3
	li $v0, 4	#stampa messaggio per l'utente
	syscall
	
	move $a0, $a3
	li $v0, 1	#stampa del massimo
	syscall
	
	li $v0, 10
	syscall	#terminazione programma

MASISMO:
	move $v0, $a0
	bgt $a2, $a0, max
	jr $ra
	
max:	#aggiorna il masismo se il secodno vlaore è magigore del primo
	move $v0, $a2
	jr $ra

.data
s1: .asciiz "\nInserisci la lunghezza del vettore (massimo 30): "
s2: .asciiz "\nInserisci un valore: "
s3: .asciiz "\nIl massimo è: "
in: .word 0:30
