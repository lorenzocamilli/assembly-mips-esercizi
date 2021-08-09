#Simulare il gioco di carta, forbice e sasso
#di due giocatori sapendo che:
#a) la carta batte il sasso;
#b) il sasso batte la forbice;
#c) la forbice batte la carta;
#d) il gioco termina dopo 10 lanci
#e) carta, sasso e forbice sono determinati in 
#maniera casuale. il MIPS consente di generare un
#numero INTERO casuale mediante la syscall 42 in $v0
#(il numero casuale generato si trova in $a0 dopo la chiamata 
#a sistema).
#NB: prima della chiamata a syscall è possibile impostare 
#ad n il registro $a1 per generare i valori interi inclusi
# tra 0 e n-1. Ad esempio impostando a 6 il registro $a1, 
#dopo la syscall in $a0 si ha un numero compreso tra 0 e 5.
#In questo modo è possibile pensare di assegnare al sasso, 
#forbice e carta un valore numerico che poi dovrà essere 
#confrontato in base alle regole a), b), c).
#Mostrare per ogni iterazione il segno prescelto dai concorrenti
#e riportare, alla fine del gioco, il nome del vincitore.

	#0->carta, 1->forbice, 2->sasso
.text
.globl main
main:

	li $t0, 0	#contatore dellle manche (iteraizoni)
	li $s1, 0	#punteggio g1
	li $s2, 0	#punteggio g2

manche:
	la $a0, s1	
	li $v0, 4	
	syscall	#stampa stringa
	
	li $v0, 1
	move $a0, $t0
	syscall	#stampa il nuemro di manche attuale
		
	#giocatore 1
	li $v0, 42	#syscall valore casuale
	li $a1, 3	#limite supeorpre random	
	syscall
	move $a2, $a0	#output g1
		
	jal TRADUCI	#si occupa di tradurre il risultato d anumeor a letetre
	move $a1, $v0
		
	la $a0, s2
	li $v0, 4	#stampa
	syscall 
	
	move $a0, $a1
	li $v0, 4
	syscall 	
			
	
	#giocatore 2	
	li $v0, 42	#syscall valore casuale
	li $a1, 3	#limite supeorpre random	
	syscall
	move $a3, $a0	
	jal TRADUCI
	
	move $a1, $v0
		
	la $a0, s3
	li $v0, 4
	syscall 
	
	move $a0, $a1
	li $v0, 4	#stampa traduzione 
	syscall 	
	
	jal CALCOLA	 #aggiorna il punteggio attuale 
	
	
	addi $t0, $t0, 1	#incremnta il nuemro di manche
	blt $t0,10, manche 	#cicla per 10 volte
	
risultato:	
	# si occupa di calcolar eil risultato e stampare
	#il vincitorre della partita
	bgt $s1, $s2, g1_win 	#se il punteggio di g1>g2 allora g1 ha vinto
	bgt $s2, $s1, g2_win	#se il punteggio di g1<g2 allora g2 ha vinto	
	la $a0, spar	#altrimenti è un pareggio
	li $v0, 4
	syscall
	j termina

g1_win: 
	la $a0, sg1win
	li $v0, 4
	syscall
	j termina
 												
g2_win:	
	la $a0, sg2win
	li $v0, 4
	syscall
	j termina	
																																		
termina:	
	li $v0, 10
	syscall
	
TRADUCI:
	#0->carta, 1->forbice, 2->sasso
	beq $a0, 0, stampa_carta	#se l'input è 0 allora
	#equivale  acarta
	beq $a0, 1, stampa_forbice	#e è 1 equivale a forbice
	la $t1, sasso	#altrimenti (se è 2) a sasso
	move $v0, $t1
	jr $ra 
	
stampa_carta:
	la $t1, carta
	move $v0, $t1	#stampa la stirnga carta
	jr $ra 
	
stampa_forbice:	
	la $t1, forbice
	move $v0, $t1	#stampa la stringa forbice
	jr $ra 	

CALCOLA:
	beq $a2, 0, check_g1carta	#se il g1 ha fatto carta
	beq $a2, 1, check_g1forbice #se il g1 ha fatto forbice
	beq $a2, 2, check_g1sasso   #se il g1 ha fatto sasso

check_g1carta:
	#giocatore 2
	beq $a3, $a2, pareggio 	#se anche g2 ha fatto carta
	beq $a3, 1, punto_g2 	#se g2 ha fatto forbice allora il punot va a g2
	beq $a3, 2, punto_g1 	#se g2 ha fatto sasso il punto va a g1
	
check_g1forbice:
	#giocatore 2
	beq $a3, $a2, pareggio  #se anche g2 ha fatto forbice
	beq $a3, 2, punto_g2 	#se g2 ha fatto sasso allora il punto va a g2	
	beq $a3, 0, punto_g1 	#se g2 ha fatto carta allora il punto va a g1
	
check_g1sasso: 
	beq $a3, $a2, pareggio 	#se anche g2 ha fatto sasso
	beq $a3, 0, punto_g2	#se g2 ha fatto carta il punto va a g2
	beq $a3, 1, punto_g1	#se g2 ha fatto forbice allora il punto va ag1
	
	
pareggio:
	#incrementa di 0 entrmabi i punteggi (non serve è stato messo
	#solo per migliorare la leggibilità)
	addi $s1, $s1, 0	
	addi $s2, $s2, 0	
	jr $ra
	
punto_g1:
	#incrementa il punteggio di g1 di 1
	addi $s1, $s1, 1	
	jr $ra
	
punto_g2:
	#incrementa il punteggio di g2 di 1
	addi $s2, $s2, 1	
	jr $ra	

.data:
s1: .asciiz "\nManche: "
s2: .asciiz	"\nIl giocatore 1 ha fatto: "
s3: .asciiz "\nIl giocatore 2 ha fatto: "
sg1win: .asciiz "\nIl giocatore 1 ha vinto"
sg2win: .asciiz "\nIl giocatore 2 ha vinto"
spar:	.asciiz "\nLa partita è finita in pareggio"
carta: 	.asciiz "carta"
forbice: .asciiz "forbice"
sasso: .asciiz "sasso"

