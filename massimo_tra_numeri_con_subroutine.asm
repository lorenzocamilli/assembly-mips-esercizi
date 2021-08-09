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

.text
.globl main
main:


	la $a0, s1	
	li $v0, 4	#stampa il messaggio per l'utente
	syscall
	
	li $a0, 0
	li $a1, 0


input_numeri:
	li $v0, 5
	syscall #input primo numero da tatsiera
	move $a0, $v0

	bltz $a0, fine	#se il numero è minore di 0 vaa terminar eil programma
	jal MASSIMO_TRA_DUE		#calcola una volta il massimo
#nella prima iterazione il masismo è il numero appena inserito
#perché fa il massimo tra quello e lo 0
	move $t0, $v0	#salva il avlore del massimo risultato dlala subroutine


	li $v0, 5
	syscall	#prende ilun altro unemro da tastiera
	move $a1, $v0

	bltz $a1, fine	#ss il numeo oè minore do 0 va a terminare il programma

	jal MASSIMO_TRA_DUE	#va ad aggiornare il massimo
	move $t1, $v0

	move $a0, $t0
	move $a1, $t1
	jal MASSIMO_TRA_DUE	#calcola il massimo tra due gli ultimi due numeri


	j input_numeri #ripete il ciclo


MASSIMO_TRA_DUE:

	move $v0, $a0	#prepara in v0 il potenziale massimo
	blt $a0, $a1, aggiorna_massimo	#verifica con a1, se è minore 
#va a metetre a1 come massimo, altrimenti ritorna a0
	jr $ra

aggiorna_massimo:
	move $v0, $a1
	jr $ra

fine:

	la $a0, s2	#stampa del messaggio per l'utente
	li $v0, 4
	syscall

	move $a0, $t0
	li $v0, 1
	syscall	#stampa del massimo

	li $v0, 10
	syscall



.data
s1: .asciiz "Inserisci numeri da tastiera: \n"
s2: .asciiz "Massimo: \n"
