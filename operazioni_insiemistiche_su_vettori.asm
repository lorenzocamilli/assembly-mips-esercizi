#Si scriva un programma in linguaggio assembly MIPS
#che definiti due INSIEMI (cioè due vettori halfword) 
#opera su di essi con tre subroutine UNIONE, INTERSEZIONE,
#DIFFERENZA. In particolare: UNIONE ha in input "i due 
#insiemi" (cioè gli indirizzi dei vettori) e restituisce un 
#"nuovo insieme" (cioè l'indirizzo iniziale del vettori) che
#riporta l'unione dei due insiemi [NB: L'unione fra due insiemi
#è l'operazione che associa ai due insiemi l'insieme i cui elementi 
#appartengono al primo oppure al secondo insieme]
#INTERSEZIONE ha in input "i due insieme" (cioè gli indirizzi dei 
#vettori) e restituisce un "nuovo insieme" (cioè l'indirizzo 
#iniziale del vettori) che riporta l'intersezione de due insiemi 
#[NB: L'intersezione fra due insiemi è l'operazione che associa ai 
#due insiemi l'insieme i cui elementi appartengono contemporaneamente 
#al primo e al secondo insieme]
#DIFFERENZA ha in input "i due insiemi" (cioè gli indirizzi
#dei vettori) e restituisce un "nuovo insieme" (cioè l'indirizzo
#iniziale del vettori) he riporta la differenza dei due insiemi.
#[NB: Si definisce differenza fra due insiemi l'insieme degli elementi 
#del primo insieme che non appartengono al secondo insieme;]
#ESEMPIO:
#Dati gli insiemi
#A = { 1, 2, 3, 4 }
#B = { 3, 4, 5, 6 }
#AunioneB = { 1, 2, 3, 4, 5, 6 }
#AintersezioneB = { 3, 4}
#AdifferenzaB = {1, 2}

.text
.globl main
main:
			
	la $t0, A
	la $t1, B
	
	move $a0, $t0
	move $a1, $t1
	
	li $a2, 8	#lunghezza vettore A	(4 x 2(dim. halfword))
	li $a3, 8	#lunghezza vettore B
	
	jal UNIONE
	
UNIONE:
	li $t9, 0	#indice scorrimento vettore A
	
#agigungo come prima ocsa tutto A in out	
scorrimentoA:
	mul $t9, $t9, 2	#moltiplica l'indice di socrrimento per 2(dimensione half)
	lh $t8, A($t9)	#preleva il valore da A
	sw $t8, out($t9)	#scrive il valore in out
	blt $t9, $a2, scorrimentoA	#ripete il ciclo
	
	li $t7, 0	#indice di scorriemnto di B	
scorrimentoB:
	mul $t7, $t7, 2
	lh $t8, B($t7)	#preleva il valore da B
	move $a0, $t8	#lo sposta in un registro preservante per chiamare
	#la subroutine
	jal CHECK_IN_OUT	#chiama la subroutine per verificare che l'elemenot
#non appartenga già al vettore di output
	bgtz $v0, aggiungi_in_out
	blt $t9, $a2, scorrimentoB



CHECK_IN_OUT:
	li $t6, 0	#scorriemnto out, ad ogni chiamata della subroutine
#si azzera
	li $v0, 0
ciclo:
	mul $t6, $t6, 2
	addi $t6, $t6, 1 #preleva il avlore da out
	seq $t0 $t5, $t8	#lo confronta ocn il valore di B
#se non sono uguali lo va a scrivere in out, altrimenti 
	add $v0, $v0, $t3
	blt $t6, $t1, ciclo
	jr $ra

aggiungi_in_out:
	mul $t1, $t1, 2
	sw $t8, out($t1)
	j scorrimentoB


.data
A: .half 1, 2, 3, 4
B:  .half 3, 4, 5, 6 
out: .space 1024

