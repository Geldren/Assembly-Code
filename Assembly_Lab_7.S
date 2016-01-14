	.data
rows:	.word	0
strprm:	.ascii	"\nThis program will create a table that shows s minimum, a "
	.ascii	"maximum, and and e number of\nevenly separated sub values "
	.ascii	"inbetween dictated by the number of rows in the first column."
	.ascii	"\nIn the other column will be the value of the function f(x)="
	.ascii	"(5x^3-3x^2+2x+20)/11 with each\nvalue in the first column "
	.asciz	"being used as the x value for the second column.\n\n"
	.align	2
strmin:	.asciz	"Input the minimum value in the table:\n"
	.align	2
strmax:	.asciz	"Input the maximum value in the table:\n"
	.align	2
strrow:	.asciz	"Input the number of rows to be in the table:\n"
	.align	2
strfr1:	.asciz	"%d"
	.align	2
strfr2:	.asciz	"%s"
	.align	2
newlin:	.asciz	"\n"
	.align	2
space:	.asciz	" | "
	.align	2
space1:	.asciz	"               | "
	.align	2
xcol:	.asciz	"      xvalues      "
	.align	2
ycol:	.asciz	"     f(x)values"
	.align	2
min:	.skip	16
max:	.skip	16


	.text
	.global main
f:	stmfd	sp!, {r5-r10,lr}
	mov	r2, r4
	smull	r0, r1, r2, r4
	lsr	r0, r0, #16
	lsl	r1, r1, #16
	orr	r2, r0, r1
	smull	r0, r1, r2, r4
	lsr	r0, r0, #16
	lsl	r1, r1, #16
	orr	r3, r0, r1
	mov	r0, #5
	mul	r3, r3, r0
	mov	r0, #-3
	mul	r2, r2, r0
	mov	r0, #2
	mul	r1, r4, r0
	mov	r0, #20
	lsl	r0, r0, #16
	add	r0, r1, r0
	add	r0, r0, r2
	add	r0, r0, r3

	mov	r1, #11
	bl	sdiv32

	ldmfd	sp!, {r5-r10,lr}
	mov	pc, lr

main:	stmfd	sp!, {r4-r10,lr}

	ldr	r0, =strprm
	bl	printf

	ldr	r0, =strmin
	bl	printf
	ldr	r0, =strfr2
	ldr	r1, =min
	bl	scanf

	ldr	r0, =min
	mov	r1, #16
	bl	strtoSfixed
	mov	r4, r0

	ldr	r0, =strmax
	bl	printf
	ldr	r0, =strfr2
	ldr	r1, =max
	bl	scanf

	ldr	r0, =max
	mov	r1, #16
	bl	strtoSfixed
	mov	r5, r0

	ldr	r0, =strrow
	bl	printf
	ldr	r0, =strfr1
	ldr	r1, =rows
	bl	scanf

	sub	r6, r5, r4

	ldr	r8, =rows
	ldr	r8, [r8]

	mov	r0, r6
	sub	r1, r8, #1
	bl	sdiv32

	mov	r9, r0

	ldr	r0, =xcol
	bl	printf
	ldr	r0, =ycol
	bl	printf
	ldr	r0, =newlin
	bl	printf

	mov	r7, #0
tblprt:	sub	r6, r8, #1
	cmp	r7, r6
	moveq	r0, r5
	movne	r0, r4
	mov	r1, #16
	bl	printS
	cmp	r7, #0
	cmpne	r7, r6
	ldreq	r0, =space1
	ldrne	r0, =space
	bl	printf
	add	r7, r7, #1
	bl	f
	mov	r1, #16
	bl	printS
	ldr	r0, =newlin
	bl	printf
	add	r4, r4, r9
	cmp	r7, r8
	bne	tblprt

	ldmfd	sp!, {r4-r10,lr}
	mov	pc, lr
