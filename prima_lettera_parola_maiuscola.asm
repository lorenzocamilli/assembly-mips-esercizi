#Scrivere un programma in linguaggio assembly MIPS
#che legga una stringa introdotta da tastiera. La 
#stringa contiene sia caratteri maiuscoli che caratteri
#minuscoli, e complessivamente al più 100 caratteri. 
#Il programma deve svolgere le seguenti operazioni:
#visualizzare la stringa inserita
#costruire una nuova stringa in cui 
#il primo carattere di ciascuna parola nella frase di 
#partenza è stato reso maiuscolo. Tutti gli altri caratteri 
#devono essere resi minuscoli. Il programma deve memorizzare la nuova stringa
#visualizzare la nuova frase.
#Ad esempio la frase "cHe bElLA gIOrnaTa" diviene "Che Bella Giornata".

.text
.globl main
main:
	
	la $a0, s1	
	li $v0, 4 #stampa il messaggio pe rl'utente
	syscall

	la, $a0, sInput
	li $a1, 100	#lunghezza della stringa
	li $v0, 8	#ricevi in input la stirnga 
	syscall
	
	la $a0, s2	#messaggio per l'utente
	li $v0, 4
	syscall

	la $a0, sInput	#stampa della stringa in input
	li $v0, 4
	syscall
	
	#carcia l'indirizzo iniziale delle stringhe
	la $t0, sInput
	la $t1, sOutput
		
	
scorrimento_caratteri:
	lb $t2, ($t0)	#carica il carattere in $t2	
	beqz $t2, termina	#se il carattere è Null allora termina
	#perché ha analizzato tutta la stirnga
	beq $t2, 32, is_spazio	#se il carattere è uguale al codice ASCII
	#32 vuol dire che è uno spazio
	#altrimenti vrifica che è una letetra maisucola (ovvero ha
	#codice ASCII compreso tra 91 e 64
	li $t5, 91
	slt $t3, $t2, $t5
	li $t5, 64
	sgt $t4, $t2, $t5
	and $t4, $t3, $t4

	beq $t4, 1, rendi_minuscola	#vai a metterla minuscola
	j scrivi	#altrimenti è un carattere speciale e vai
	#a sciverlo normalmente
	
is_spazio:
	sb $t2, ($t1)	#scrivi nella stirnga di output lo spaizo
	addi $t0, $t0, 1	#incrememtna i puntatori di socrrimento della stringa
	addi $t1, $t1, 1
	lb $t2, ($t0)	#carica il carattere succesivo allo spaizo
	#controlla se quel carattere è minuscolo ovvero ha un 
	#codice ASCII compreso tra 96 e 123
	li $t5, 123
	slt $t3, $t2, $t5	#mette t3 a 1 se il valore in t2 è minore di
	#quello in t5
	li $t5, 96
	sgt $t4, $t2, $t5	#mette t4 a 1 se il valore di t2 è maggiore di
	#quello di t5
	and $t4, $t3, $t4	#t3 è 1 se sia t3 che t4 sono 1
	beq $t4, 1, rendi_maiuscola	#se è minuscolo vai a renderlo
	#maiuscolo
	j scrivi	#altrimenti scrivilo normalmente

	
rendi_maiuscola:
	#seri arrivato qui se il carattere è minuscolo quindi
	#decrementa la codice ASCII del caratttere il valore 32
	#ovvero la distanza tra un carattere e il corrispondente MAIUSCOLO
	subi $t4, $t2, 32
	sb $t4, ($t1)	#scrivi il carattere sulla stringa di output
	addi $t0, $t0, 1	#incrementa gli indici di scorrimento
	addi $t1, $t1, 1
	j scorrimento_caratteri	
	
rendi_minuscola:
	#arrivi qui se il carattere (ceh non si torva dopo uno spazio
	#è maiuscolo allora
	addi $t4, $t2, 32	#incrementa al suo codice ASCII il valore 32
	#ovvero la distanza tra un carattere e il suo corrispondente minuscolo
	sb $t4, ($t1)	#scrivi il carattere sulla strniga di output
	addi $t0, $t0, 1 #incrememtna gli indici di scorrimento delle stringhe
	addi $t1, $t1, 1
	j scorrimento_caratteri	

scrivi:
	#arrivi qui se il carattere analizzato è un carattere speciale
	sb $t2, ($t1)	#scrivi semplicemnte i carattere
	addi $t0, $t0, 1	#incrememtna gli indici di socrrimento delle stringhe
	addi $t1, $t1, 1
	j scorrimento_caratteri		
	
	
	
termina:
	la $a0, s3	#stampa della stringa di messaggio pe rl'utente
	li $v0, 4
	syscall


	la $a0, sOutput	#stampa della stringa di output
	li $v0, 4
	syscall
	
	li $v0, 10	#termina il programma
	syscall



.data
sInput: .space 100	#100 caratteri
sOutput: .space 100
s1: .asciiz "Inserisci la stringa: \n"
s2: .asciiz "Stampa della stringa inserita: \n"
s3: .asciiz "Stampa della stringa in con prima letetra maiuscola: \n"
