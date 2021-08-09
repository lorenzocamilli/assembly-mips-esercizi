#Scrivere un programma in linguaggio assembly MIPS
#che legga una stringa introdotta da tastiera. 
#La stringa contiene sia caratteri maiuscoli che 
#caratteri minuscoli, e complessivamente al più 100 
#caratteri. Il programma deve svolgere le seguenti operazioni:

#visualizzare la stringa inserita
#costruire una nuova stringa in cui il primo carattere di 
#ciascuna parola nella frase di partenza è stato reso maiuscolo.
#Tutti gli altri caratteri devono essere resi minuscoli. 
#Il programma deve memorizzare la nuova stringa
#visualizzare la nuova frase.
#Ad esempio la frase "cHe bElLA gIOrnaTa" diviene "Che Bella Giornata".


.text
.globl main
main:
	
	la $a0, s
	li $v0, 4	#messaggio per l'utente
	syscall

	la, $a0, sInput
	li $a1, 100	
	li $v0, 8	#ricevi in input la stirnga 
	syscall
	
	
	la $a0, s1
	li $v0, 4	#messaggio per l'utente
	syscall
	
	la $a0, sInput	#stampa della stringa in input
	li $v0, 4
	syscall  

	
	li $a3, 0	#indice di scorrimento caratteri
	
scorrimento:
	lb $a1, sInput($a3)	#preleva iòl carattere	
	beqz $a1, stampa	#se il carattere è uguale a 0 (terminatore di stringa)
	#allora termina il ciclo

	beq $a1, 32, spazio	#se il carattere ha codice ASCII uguale a
	#32 allora è uno spazio
	beqz $a3, check_minuscola	#rende maiuscolo il primo
	#carattere 
	jal SCRIVI	
return:					
	addi $a3, $a3, 1	#incrementa l'indice di scorriemnto per prelevare il carttere successivo												
	j scorrimento


spazio:
	jal SCRIVI	#scrive lo spazio in oputput
	addi $a3, $a3, 1	#incremnta di 1 l'indice di socrirmento
	lb $a1, sInput($a3)	#prelva il carattere dopo lo psaizo		
	#le letetre minuscole hanno codice ASCII compreso tra 97 e 122 inclusi
	bgt $a1, 96, check_minuscola	#se ha codice ASCII maggiore di 96
	#allora controlla se è minuscola
	blt $a1, 91, check_maiuscola	#altrimenti se ha un codice ASCII minore di 91
	#vedi se è maiuscola
	#i caratteri maiusocli hanno codice ASCII compreso tra 66 e 90
	j return 
	
check_minuscola:
	#97-122->minusocle
	bgt $a1, 122, special_char	#se non è compreso tra 
	#97 e 122 allora è un carattere speciale 
	subi $a2 $a1, 32	#rende maiuscola il carattere, infatti
	#il corrispondeten maiuscolo si trova a distanza -32 del codice ASCII
	move $a1, $a2
	jal SCRIVI	#scrive il carattere maisucolo
	j return 

check_maiuscola:
	#66-90->maiuscole
	blt $a1, 65, special_char	#e è minore di 65 allora è un carattere speciale
	jal SCRIVI	#altrimenti scrivi semplicemnte il carattere senza
	#ulteriori modifiche
	j return 

special_char:
	jal SCRIVI	#scrivi il carattere
	j return
	
SCRIVI:
	sb $a1, sOutput($a3)
	jr $ra 
	
	
stampa:
	la $a0, s2
	li $v0, 4	#stampa messaggio per l'utente
	syscall
	
	la $a0, sOutput
	li $v0, 4
	syscall	#stampa stringa output
	
	li $v0, 10
	syscall	#terminazione programma
	
.data
sInput: .space 100
sOutput: .space 100
s: .asciiz "\nInserisci una stringa di massimo 100 caratteri: "
s1: .asciiz "\nStringa inserita: "
s2: .asciiz "\nStringa modificata: "
