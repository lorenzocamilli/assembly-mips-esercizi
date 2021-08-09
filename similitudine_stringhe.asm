#Si scriva un programma in linguaggio assembly MIPS
#che legge due stringhe da tastiera e al suo interno
#usa una subroutine, denominata SIMILITUDINE, che 
#valuta quanti caratteri alle stesse posizioni delle due 
#stringhe sono uguali.
#La routine riceve due parametri, "le stringhe" (cioè 
#gli indirizzi delle stringhe), e restituisce un numero intero
#e lo stampa a video.
#Ad esempio:

#SIMILITUDINE ("ciao", "cielo") restituisce 2 in quanto 
#i primi due caratteri sono identici.
#SIMILITUDINE("ciao", "salve") restituisce 0 in quanto nessun 
#carattere alle stesse posizioni sono uguali

.text 
.global main
main:

	la $a0, s1	#input stringa
	la $a1, s2	#input stringa

	li $t0, 0	#indice scorrimento
	li $t1, 0	#contatore caratteri uguali
ciclo:	
	lb $t8, s1($t0)	#preleva il carattere dalla prima stringa
	lb $t9, s2($t0)	#preleva il carattere dalla seconda stringa
	seq $t7, $t8, $t9	#se sono uguali t7 vale 1
	add $t1, $t7, $t1	#quindi se sono uguali viene sommato 1 e incrementato il valore
	#altrimenti viene sommato 0 
	addi $t0, $t0, 1	#incrememtna l'indice di socrrimento
	beqz $t8,fine	#verifca che la prima stringa non sia finita
	#ovevro che il carattere non è quello di terminaizone (zero)
	beqz $t9, fine 
	#vengono fatti 2 copntrolli perché non è detto che le parole 
	#abbiano la stessa lunghezza
	j ciclo
	
fine:
	la $a0, s3
	li $v0, 4
	syscall
	
	move $a0, $t1
	li $v0, 1	#stampa del contatore
	syscall
	
	li $v0, 10
	syscall
		

.data
s1: .asciiz "ciao"
s2: .asciiz "cielo"
s3:	.asciiz "Numero di caratteri uguali nella stessa posizione: "
