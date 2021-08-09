#Realizzare un programma in assembly MIPS che 
#sposti tutti gli 1 a destra e gli 0 a sinistra
#della rappresentazione in binario di un operando intero.
#ES:
#INPUT: 358427306 (ovvero: 00010101010111010010101010101010)
#OUTPUT: 32767 (ovvero: 00000000000000000111111111111111)
#NB: L’operando intero a 32bit è immesso da tastiera. 
#Il valore risultante deve essere riportato nel registro $t0

.text #Direttiva del Segmento Testo
.globl main #Direttiva per indicare l’etichetta main come globale
main: #Etichetta main: inizio del programma

	li $t0,0 #Inizializzazione registro con risultato
	
	li $v0,5 #Lettura intero
	syscall 
	move $t2,$v0 #Recupero dell'intero letto

ciclo:
	andi $t1,$t2,1 #Estrazione bit meno significativo
	beqz $t1, salta #Analisi bit meno significativo

	sll $t0,$t0,1 #Shift a sinistra del contenuto di $t0
	add $t0,$t0,1 #Settaggio ad 1 del bit meno significativo

salta:
	srl $t2,$t2,1 #Shift dell'operando
	bnez $t2,ciclo #Ripetzione del ciclo fino a quando l'operando non è uguale a zero

	li $t5, 0
stampa:
	rem $t4, $t0, 2
	div $t0, $t0, 2
						
	move $a0, $t4
	li $v0, 1
	syscall
	
	addi $t5, $t5 ,1
	blt $t5, 32, stampa	
	
	li $v0,10 #Terminazione del programma
	syscall