#Scrivere un programma che inizializza un 
#vettore di 10 elementi a 16bit con valori 
#casuali compresi tra 0 e 65000 e che copia 
#in un nuovo vettore il quadrato degli elementi 
#del primo (utilizzare una funziona per realizzare 
#il quadrato degli elementi).

#ESEMPIO:
#v1= 5,60000,0,1,45,76,99,456,4321,12876
#v2= 25,3600000000,0,1,2025,5776,9801,207936,18671041,165791376
.text
	
	li $t0, 0 #indice scorrimento vettore

inserimento:
	mul $t1, $t0, 4
	
    li $v0, 42 	#syscall per nuemri casuali
    li $a1,  100 #65000, limite superiore
    syscall

    jal QUADRATO	#chiama la subroutine
	
	move $t9, $a0	
	sw $t9, out($t1)	#scrittura nel vettore
		
	addi $t0, $t0, 1
	blt $t0, 10, inserimento
	j stampaV
	
QUADRATO:
	mul $t7, $a0, $a0
	sw $t7, quad($t1)		#scrittura nel vettore dei quadrati
	jr $ra
	
	
stampaV:
	la $a0, s1
	li $v0, 4
	syscall
	
	li $t0, 0 #indice scorrimento vettore
	
cicloStampa:	#stampa vettore numeri
	mul $t1, $t0, 4
	lw $t9, out($t1)
	
	move $a0, $t9
	li $v0, 1
	syscall
	
	la $a0, s
	li $v0, 4
	syscall
	
	addi $t0, $t0, 1
	blt $t0, 10, cicloStampa
	

#stampa del evttore dei quadrtai
	la $a0, s2
	li $v0, 4
	syscall
	
	li $t0, 0 #indice sc
	
stampaQuad:
	mul $t1, $t0, 4
	lw $t9, quad($t1)
	
	move $a0, $t9
	li $v0, 1
	syscall
	
	la $a0, s
	li $v0, 4
	syscall
	
	addi $t0, $t0, 1
	blt $t0, 10, stampaQuad			

	li $v0, 10	
	syscall

.data
out: .space 1024
quad: .space 2048
s: .asciiz " "
s1: .asciiz "Vettore elementi casuali: \n"
s2: .asciiz "\nVettori con quadrato degli leementi: \n"