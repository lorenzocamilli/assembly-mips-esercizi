#V1 e V2 e restituisce il vettore V3 formato dall'elemento 
#più grande alla stessa posizione dei vettori V1 e V2.
#ESEMPIO:
#V1=3,56,12,45,33
#V2=-4,67,89,11,4700
#V3=3,67,89,45,4700

.text
.globl main
main:
			
scorrimento:
	mul $t9, $t0, 1	#indice scorriemnto vettore v1
	#moltiuplica pe 1 perché di byte
	mul $t8, $t1, 2	#indice scorriemnto vettore v2
	#moltiplica per 2 perché di half-word
	lb $a1, v1($t9)	#preleva l'elemento di v1
	lh $a2, v2($t8)	#preleva l'elemento di v2
	
	jal SCRIVI	#chiama la funzione che si occupa di scrivere
	#nel vettore di output
	
	addi $t0, $t0, 1 #incrementa gli indici di scorrimento
	addi $t1, $t1, 1 #incrementa gli indici di scorrimento
	blt $t1, 5, scorrimento
	
	
stampa:	#subroutine che si occupa della stampa del vettore
#di output
	mul $t5, $t4, 2
	lh $a0, v3($t5)
	
	li $v0, 1
	syscall	#stampa elemento
	
	la $a0, s
	li $v0, 4
	syscall	#stampa spazio tra due lementi
	
	addi $t4, $t4, 1	#incrementa l'indice
	blt $t4, 5, stampa	
			
	li $v0, 10
	syscall	#terminazione programma
	
	
SCRIVI:	
	mul $t7, $t6, 2	#indice vettore output
	bgt $a1, $a2, salta	#confronta i due elemnti
	sh $a2, v3($t7)	#se a2>a1 allora scrive a2 in output
	addi $t6, $t6, 1 #e incrementa l'indice
	jr $ra	#ritorna alla funzioone chiamante
	
salta:	
	sh $a1, v3($t7)	#altrimenti scrive a1 
	addi $t6, $t6, 1 #incrememnta l'indice di socrirmento		
	jr $ra	#ritorna alla funzioone chiamante
	


.data
v1: .byte 3,56,12,45,33
v2: .half -4,67,89,11,4700
v3: .space 10	#spazio di 10 perché al più il vettore di output
#può ospitare 5 half word
s: .asciiz " "





