#Realizzare un programma in assembly MIPS 
#che immessi in input dei numeri interi calcola 
#la media aritmetica (l’acquisizione dei dati termina
#con l’immissione dello zero). Supponendo che i valori 
#immessi siano dei campioni relativi alla temperatura 
#rilevata in un luogo e stabilito che la media nazionale 
#è di 22.72°C calcolare l’errore quadratico metrico
#e stamparlo su videoterminale

# E=  sqrt (|medianazionale^2 - mediarilevata^2|)/2
 
#ESEMPIO:
#INPUT:
#22;23;25;27;22;23;21;18;0
#OUTPUT
#(Media Rilevata: 22.625)
#E=1.037775


.text
.globl main
main:

input:	
	addi $t9, $t9, 1	#contatore degli elmenti inseriti
	li $v0, 5
	syscall #$f0


	add  $t1, $t1, $v0	#sommatore 
	bnez $v0, input
	subi $t9, $t9, 1	#elimina dal contatore 1 perché il ciclo 
	#conta anche l'inserimento dello 0
	
	mtc1 $t1, $f1	#sposta il valore della somma delgi elementi nel coprocessore matematico
	cvt.s.w $f1, $f1	#converte il valore in singola precisione
	mtc1 $t9, $f9	#sposta il numero di elemenit inseriti nel coprocessore matematico
	cvt.s.w $f9, $f9	#converte il valore
	div.s $f1,$f1, $f9	#calcola la media rilevata
	
	la $a0, m1
	li $v0, 4	#stampa messaggio per l'utente
	syscall
	
	mov.s $f12, $f1
	li $v0, 2	#stampa il valore della media rilev ata
	syscall
	
	mul.s $f2, $f1, $f1	#quadrato della media rilevata
	
	l.s $f3, media_naz	#carica il valore della meida nazionale
	mul.s $f4, $f3, $f3	#calcola il quadrato
	
	sub.s $f4, $f4, $f2	#differenza tra i due valori
	abs.s $f4, $f4	#valore assoluto del risultato
	sqrt.s $f4, $f4	#radice quadrata del risultato
	l.s $f7, due #carica il valore 2.0 per fare la divisione
	div.s $f12, $f4, $f7	#effettua la divisione


	la $a0, m2
	li $v0, 4	#stampa messaggio per l'utente
	syscall


	li $v0, 2
	syscall	#stampa risultato dell'operaizone
	
	li $v0, 10
	syscall	
	

.data:
media_naz: .float 22.72
due: .float 2.0
m1: .asciiz "\nMedia rilevata: "
m2: .asciiz "\nErrore quadratico: "
