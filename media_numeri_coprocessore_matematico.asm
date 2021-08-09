#Leggere 7 valori interi da input e 
#calcolarne la media (stampandola a video).
#INPUT
#12;82;11;2345;67;123456;675
#OUTPUT
#18092.57142857
#NB: La media deve essere espressa con un 
#numero reale (float). Utilizzare il coprocessore matematico.

.text 
.globl main
main:

	li $t1, 0	#conta il numero di valori inseriti 
	li $t3, 0 #è necessario inizializzarlo a 0
input:
	beq $t1, 7, salta	#se sono stati inseriti 7 numeri
#va a fare la media 
	li $v0, 5	#prendi numero in input
	syscall
	move $t2, $v0	
	add $t3, $t3, $t2	#somma dei valori
	addi $t1, $t1, 1	#incrememtno del contatore
	j input

salta:
	mtc1 $t1, $f1	#muove nel coprocessore il numero di 
	#valori inseriti
	mtc1 $t3, $f3	#muove nel coprocessore la somme dei valori
	cvt.s.w $f1,$f1		#conversione in virgola mobile a singola precisione
	cvt.s.w $f3,$f3		#conversione in virgola mobile a singola precisione
	div.s $f2, $f3, $f1	#calcola la media
	
	li $v0, 2	#syscall per stampa di float
	mov.s $f12,$f2	
	syscall

	li $v0, 10
	syscall 

