#Descrivere l'algoritmo che dato un numero intero maggiore di
# 2 (definito in memoria) stabilisca se il numero è primo 
#(valore 1 in $t2) o no (valore 2 in $t2). Provare ad 
#implementare il programma utilizzando l'emulatore MARS.
#Esempio numeri primi 1,3,5,7,11,13,...
#PS: un numero è primo solo se è divisibile per se stesso e per 1.

.text
.globl main
main:

	li $v0, 5
	syscall	#input numeor da testiera
	move $t0, $v0

#verifica che il numero inserito sia maggiore o uguale a 2
	blt $t0, 2, print_error

	li $t1, 2 #indice da cui partire per il ciclo
	div $t2, $t0, 2
	addi $t2, $t2, 1	#indice a cui arrivare ovvero (n/2)+1

ciclo:
	beq $t1, $t2, primo	#se l'indice ha raggionto il limite superiore di
#(n/2)+1 vuol dire che sono stati controllati tuti i nuemri come
#possibili divisori
	rem $t3, $t0, $t1 	#resto della divisione tra il numero inserito e
#l'indice attuale
	beqz $t3, non_primo	#se il resto è 0 (quindi è divisibile per un dato numero)
#allora vuol dire che il nuemro inserito non è primo
	addi $t1, $t1, 1	#altirmenti incrementa l'indice e ripeti il ciclo
	j ciclo

primo: 
	la $a0, p	#carica ion memoria la stringa
	li $v0, 4
	syscall	#stampa la stringa
	j termina


non_primo:
	la $a0, np #carica ion memoria la stringa
	li $v0, 4
	syscall	#stampa la stirnga
	j termina


print_error:
	la $a0, errore #carica ion memoria la stringa
	li $v0, 4	#stampa la stirnga
	syscall

termina:	#termina il programma
	li $v0, 10
	syscall

.data 
errore: .asciiz "Il numero deve essere maggiore o uguale a 2"
np: .asciiz "Il numero inserito non è primo"
p: .asciiz "Il numero inserito è primo"
