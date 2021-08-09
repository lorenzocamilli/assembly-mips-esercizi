#Scrivere un programma in linguaggio assembly MIPS 
#che legga una stringa introdotta da tastiera. 
#La stringa contiene sia caratteri maiuscoli che 
#caratteri minuscoli, e complessivamente al più 255 caratteri.
#Il programma deve svolgere le seguenti operazioni:
#visualizzare la stringa inserita
#stampare a video l'uppercase della stringa
#Ad esempio la frase "Che Bella Giornata" diviene 
#"CHE BELLA GIORNATA".


.text 
.globl main
main:

	li $t0, 0	#indice scorrimento stringa
	
	la $a0, s1	#stampa messaggio di inserimento
	li $v0, 4
	syscall
	
	la $a0, sInput	#carica l'indirizzo a cui deve cominciare la strniga 
	li $a1, 1020	#immagazina la lunghezza della stirnga
	li $v0, 8	#prende in input la stirnga
	syscall


	la $a0, s2	#messaggio per l'utente
	li $v0, 4
	syscall

	la $a0, sInput	#stampa della stringa in input
	li $v0, 4
	syscall

#	la $t0, sInput	#indiirzzo iniziale della stirnga in input
#	la $t8, sOutput #indiirzzo iniizale della strniga di output
	
		
	li $t6, 123
	li $t7, 96 
	
ciclo:
	mul $t2, $t0, 1
	lb $t3, sInput($t2)	


	
	slt $t4, $t3, $t6
	sgt $t5, $t3, $t7
	and $t5, $t5, $t4
	bnez $t5, minuscola
	beqz $t5, maiuscola

return: 
	addi $t0, $t0, 1
	beqz $t3, stampa

minuscola:
	sub $t9, $t3, 32
	sb $t9, sOutput($t2)
	j return

maiuscola:
	sb $t9, sOutput($t2)
	j return


stampa: 
	la $a0, s3	#stampa messaggio per l'utente
	li $v0, 4
	syscall
	
	la $t0, sOutput	#stampa al stringa di output
	move $a0, $t0
	li $v0, 4
	syscall	
	li $v0, 10	#termina
	syscall	
	



.data
sInput: .space 1020
sOutput: .space 1020
s1: .asciiz "Inserisci la stringa \n"
s2: .asciiz "Stampa della stringa inserita: \n"
s3: .asciiz "Stampa della stringa in UPPERCASE: \n"




