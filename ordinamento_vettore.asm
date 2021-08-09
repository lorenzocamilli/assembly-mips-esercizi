#Si scriva un programma in linguaggio assembly MIPS 
#che mediante la subroutine ORDINA ordina un vettore 
#immesso da input. La routine ORDINA ha come argomento
#il vettore (cioè l'indirizzo del vettore), e restituisce
#il vettore ordinato (l'indrizzo del vettore, con gli 
#elementi ordinati).
#Ad esempio
#v=(1,10,6,3,2,4)
#ORDINA(v)=(1,2,3,4,6,10)
.text
.globl main
main:
	#per farlo generale basta che si prenda in input la lunghezza del vettore
	#e gli elemenit interessati, e si sostituisce il confronto con 6 (lunghezza del
	#vettore slavato in memoria) con la lunghezza del vettore preso in input
	
	lw $a3, max		#valore massimo utile per confrontare
	#con il minimo alla prima iteraizone e per sovrascrievre i numeri già
	#scritti nel vettore di output, in quetso sono sicuro che non verrà preso come minimo
	#un valore già scritto
	li $t0, 0	#contatore vettore input
	
	li $t6, 0	#contatore stampa
	li $t7,0	#contatore vettore output
	lw $t5, max	
	
return2:
	li $t0, 0	#resetta il contatore del vettore di input, in modo
	#che ogni volta che torno qui scorro tutto il vettore di input
trova_minimo:
	#scorre il vettore di input e trova il minimo attuale
	#in particolare alla prima iteraizone prende il primo elemento
	#che sicuramente sarà minore del massimo, susccessivamente confonta
	#gli elementi successivi con il minimo aggiornato	
	mul $t1, $t0,4
	lw $t9, v($t1)
	addi $t0, $t0, 1	
	blt $t9, $a3, aggiorna_minimo 
return:	
	blt $t0, 6, trova_minimo
	j ordina

ordina:
	mul $t4, $t7, 4
	sw $a3, out($t4)	#scrive nel vettore di output
	#il minimo
	sw $t5, v($a2)	#scrive alla posizone del minimo trovato il valore del massimo
	#in modo da escluderlo per i confronti siccessivi
	lw $a3, max	#riposiziona il massimo come minimo, altrimenti non funzionerebbe
	#più la ricerca del minimo, perché confronterei tutti gli elementi con il 
	#valore del minimo e quindi non si andrebbe avanti
	addi $t7, $t7, 1	#incremnta l'indice di scorrimento
	blt $t7, 6, return2 	#si va a rcialcolare il nuovo minimo	
	j stampa		
							

aggiorna_minimo:
	move $a3, $t9	#nuovo minimo
	move $a2, $t1	#posizione del minimo, utile per aggiornare il vettore
	#di input con il massimo in modo da eliminare gli elementi
	#già scritti nell'output
	j return


stampa:
	#stampa del vettore di output ordinato
	mul $t4, $t6, 4
	lw $a0, out($t4)
	li $v0, 1
	syscall
	
	la $a0, s
	li $v0, 4	#stampa uno spaizo per idstanziare gli elementi
	syscall
	
	addi $t6, $t6, 1
	blt $t6, 6, stampa  
	
	li $v0, 10
	syscall		#terminazione programma

.data
v: .word 1,10,6,3,2,4
out: .space 1024
max: .word 100000
s: .asciiz " "

