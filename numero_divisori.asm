#Creare una funzione int DIVISORE (int n)
#che calcola quanti divisori ha un numero naturale n.
#Creare poi un programma che ricevuto 
#dall’utente un numero naturale n stampi il numero 
#d che indica quanti divisori ha n.
#ESEMPIO:
#READ(x) //immessione di x=33
#Y=DIVISORE(X)
#PRINT(Y) //risultato 4 (cioè 1, 3, 11 e 33)
.text
.globl main
main:
	
	li $v0, 5
	syscall	#prende in input un numero
	move $a0, $v0

	li $t0,1	#possibile divisiore, viene incrementato
	#ad ogni iterazione fino ad n
	li $t1, 0  #contatore dei divisori

ciclo:
	rem $t9, $a0, $t0	#verifica il resto della divisione
	beqz $t9, incrementa_counter	#se è zero
return:	#si può fare facilmente anche con una subroutine
	addi $t0, $t0, 1	#incrementa il numero da 
	#controllare per la prossima iterzione
	ble $t0,$a0, ciclo	#ripete il ciclo fino al numeor inserito
	
	li $v0, 1
	move $a0, $t1
	syscall	#stampa del numeor di divisori
	
	li $v0, 10
	syscall	#terminazione programma
	
incrementa_counter:
	addi $t1, $t1, 1	#incrementa il contatore dei divisori
	j return
