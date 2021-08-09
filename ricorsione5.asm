#Si consideri la funzione f definita su interi
#f(x,y) = f(x-1,y-1) – 1 se x+y>0
#f(x,y) = 5 se x+y<=0
#ESEMPIO f(10,5)=f(9,4)-1=(f(8,3)-1)-1=((f(7,2)-1)-1)-1=(f(6,1)-1)-3=(f(5,0)-1)-4=
#(f(4,-1)-1)-5=(f(3,-2)-1)-6)=f(2,-3)-1)-7=5-8=-3
#Realizzare un programma in assembler MIPS che, 
#acquisiti due interi positivi x e y da tastiera (mediante sycall),
#calcola il corrispondente valore di f(x,y) in modo 
#ricorsivo utilizzando lo stack e lo stampa su videoterminale


.text
.globl main
main:
	
	li $v0, 5
	syscall	#prende in input il priomo valore
	move $a1, $v0
	
	li $v0, 5	
	syscall	#prende in input il secondo valore
	move $a2, $v0
	
	jal FUNZIONE	#chiama la funzione
	
	move $a0, $v0
	li $v0, 1	#stampa il risultato
	syscall
	
	li $v0, 10
	syscall	#termina il programma
	
FUNZIONE:	
	add $t0, $a1, $a2	#calcola la somma di x e dy	
	blez $t0, caso_base	#se è <=0 allora vai al caso base
	#altrimenti procedi
	subi $sp $sp, 4	#crea spaizo nello stack
	sw $ra 0($sp)	#salva il valore di ritorno
	subi $a1, $a1, 1	#decrementa la x di 1
	subi $a2, $a2, 1	#decrementa la y di 1
	jal FUNZIONE	#chiama la funzione sui nuovi valori
	lw $ra, 0($sp)	#recupera il valore di ritorno
	addi $sp $sp, 4	#sistema lo stack
	subi $v0, $v0, 1	#calcola f(x-1,y-1) – 1
	jr $ra	#ritorna alla chiamante
						
caso_base:
	li $v0, 5
	jr $ra							



